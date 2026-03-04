#import "Basic"()(
    MEMORY_DEBUGGER = true,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = true,
);
WC :: #import "Window_Creation";
Simp :: #import "Simp"; // Only for set_render_target and swap_buffers
Input :: #import "Input";
#import "Math";
#import "GL";
#import "stb_image";

GLTF :: #import,file "../../../module.jai"(DO_SANITY_CHECKS = true);

Renderable :: struct {
    meshes: [..]Mesh;
    nodes:  [..]Node;

    Node :: struct {
        parent_index:     s32      = -1;
        children_indices: [..]s32;

        first_mesh_index: s32;
        mesh_count: s32;

        local_transform: Matrix4;
    }

    Mesh :: struct {
        vao: u32;
        vbo: u32;
        ebo: u32;

        index_count: u32;

        texture: u32;

        material: GLTF.Material;
    }
}

VERTEX_SOURCE :: #string GLSL
#version 330 core

layout(location = 0) in vec3 aPosition;
layout(location = 1) in vec3 aNormal;
layout(location = 2) in vec2 aUV;

uniform mat4 uModelTransform;
uniform mat4 uViewTransform;
uniform mat4 uProjectionTransform;

out vec2 uv;

void main()
{
    gl_Position = uProjectionTransform * uViewTransform * uModelTransform * vec4(aPosition, 1);
    uv = aUV;
}
GLSL

FRAGMENT_SOURCE :: #string GLSL
#version 330 core

in vec2 uv;

uniform vec4 uColor;
uniform sampler2D uTexture;

out vec4 fragmentColor;

void main()
{
    fragmentColor = texture(uTexture, uv) * uColor;
}
GLSL

SIXTY_DEGREES_IN_RADIANS :: 1.0472;

WINDOW_WIDTH :: 800.0;
WINDOW_HEIGHT :: 600.0;

Z_NEAR :: 0.1;
Z_FAR  :: 1000;

projection_transform: Matrix4;
should_quit: bool;

main :: () {
    defer report_memory_leaks();

    // =========================================================================
    // Window
    // =========================================================================
    window := WC.create_window(cast(s32, WINDOW_WIDTH), cast(s32, WINDOW_HEIGHT), "Lantern");
    Simp.set_render_target(window);

    // =========================================================================
    // Creating renderables
    // =========================================================================
    renderable := make_renderable();
    defer release_renderable(*renderable);
    
    // =========================================================================
    // Creating the shader
    // =========================================================================
    using gl;

    shader: u32;
    {
        vertex := glCreateShader(GL_VERTEX_SHADER);
        glShaderSource(vertex, 1, *temp_c_string(VERTEX_SOURCE), null);
        glCompileShader(vertex);

        fragment := glCreateShader(GL_FRAGMENT_SHADER);
        glShaderSource(fragment, 1, *temp_c_string(FRAGMENT_SOURCE), null);
        glCompileShader(fragment);

        shader = glCreateProgram();
        glAttachShader(shader, vertex);
        glAttachShader(shader, fragment);
        glLinkProgram(shader);

        glDeleteShader(vertex);
        glDeleteShader(fragment);
    }
    defer glDeleteProgram(shader);

    projection_transform = make_projection_matrix(SIXTY_DEGREES_IN_RADIANS, WINDOW_WIDTH / WINDOW_HEIGHT, Z_NEAR, Z_FAR);
    uViewTransform := glGetUniformLocation(shader, "uViewTransform");
    uProjectionTransform := glGetUniformLocation(shader, "uProjectionTransform");

    // =========================================================================
    // Create transforms
    // =========================================================================
    view_transform := make_look_at_matrix({ 0, 0, 50 }, { 0, 0, 0 }, { 0, 1, 0 }, false);

    // =========================================================================
    // Game loop
    // =========================================================================
    glEnable(GL_DEPTH_TEST);
    glCullFace(GL_BACK);
    glFrontFace(GL_CCW);

    while !should_quit {
        process_input();

        glClearColor(0, 0, 1, 1);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUseProgram(shader);

        glUniformMatrix4fv(uViewTransform, 1, GL_TRUE, *view_transform.coef[0][0]);
        glUniformMatrix4fv(uProjectionTransform, 1, GL_TRUE, *projection_transform.coef[0][0]);

        for renderable_node: renderable.nodes {
            if renderable_node.parent_index == -1 {
                draw_node(renderable, renderable_node, Matrix4_Identity, shader);
            }
        }

        Simp.swap_buffers(window);

        reset_temporary_storage();
    }
}

draw_node :: (renderable: Renderable, renderable_node: Renderable.Node, parent_transform: Matrix4, shader: u32) {
    uColor := glGetUniformLocation(shader, "uColor"); // No reason to do this every draw_node call
    uModelTransform := glGetUniformLocation(shader, "uModelTransform");
    uTexture := glGetUniformLocation(shader, "uTexture");

    transform := parent_transform * renderable_node.local_transform;

    for renderable_node.first_mesh_index..(renderable_node.first_mesh_index + renderable_node.mesh_count - 1) {
        mesh := renderable.meshes[it];

        if mesh.material.double_sided {
            glDisable(GL_CULL_FACE);
        } else {
            glEnable(GL_CULL_FACE);
        }

        if mesh.material.alpha_mode == .BLEND {
            glEnable(GL_BLEND);
        } else {
            glDisable(GL_BLEND);
        }

        {
            using mesh.material.pbr_metallic_roughness.base_color_factor;
            glUniform4f(uColor, x, y, z, w);
        }
        glUniformMatrix4fv(uModelTransform, 1, GL_TRUE, *transform.coef[0][0]);

        glBindVertexArray(mesh.vao);

        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, mesh.texture);
        glUniform1i(uTexture, 0);

        glDrawElements(
            GL_TRIANGLES,
            cast(GLsizei, mesh.index_count),
            GL_UNSIGNED_INT,
            cast(*void, 0),
        );
    }

    for renderable_node.children_indices {
        draw_node(renderable, renderable.nodes[it], transform, shader);
    }
}

make_renderable :: () -> Renderable {
    renderable: Renderable;

    // =========================================================================
    // Asset loading
    // =========================================================================
    converter := GLTF.create_converter();

    error, lantern_scene := GLTF.load_scene(converter, "assets/lantern_glb/lantern.glb");
    assert(!error, error);
    defer GLTF.release_scene(*lantern_scene);

    // We don't need the converter anymore as we loaded all the models we wanted.
    GLTF.destroy_converter(converter);

    using gl;

    // =========================================================================
    // GPU Data
    // =========================================================================

    for lantern_scene.nodes {
        renderable_node: Renderable.Node;
        renderable_node.local_transform = it.local_transform;
        renderable_node.parent_index = it.parent_index;
        array_copy(*renderable_node.children_indices, it.children_indices);
        renderable_node.first_mesh_index = it.first_mesh_index;
        renderable_node.mesh_count = it.mesh_count;

        array_add(*renderable.nodes, renderable_node);
    }

    for lantern_scene.meshes {
        renderable_mesh: Renderable.Mesh;
        renderable_mesh.index_count = xx it.indices.count;
        renderable_mesh.material = lantern_scene.materials[it.material_index];

        // =========================================================================
        // Textures
        // =========================================================================
        image_path := renderable_mesh.material.pbr_metallic_roughness.base_color_texture.image_path;

        width, height, channels: s32;
        data: *u8;
        if image_path {
            data = stbi_load(temp_c_string(image_path), *width, *height, *channels, 0);
        } else {
            image_data := renderable_mesh.material.pbr_metallic_roughness.base_color_texture.image_data;

            data = stbi_load_from_memory(
                temp_c_string(image_data),
                xx image_data.count,
                *width,
                *height,
                *channels,
                0,
            );
        }
        defer stbi_image_free(data);

        glGenTextures(1, *renderable_mesh.texture);
        glBindTexture(GL_TEXTURE_2D, renderable_mesh.texture);
        glTexImage2D(
            GL_TEXTURE_2D,
            0, // Mipmap level - topmost
            GL_RGBA,
            cast(GLsizei, width),
            cast(GLsizei, height),
            0, // "Some legacy stuff" (c)
            GL_RGBA,
            GL_UNSIGNED_BYTE,
            data,
        );
        glGenerateMipmap(GL_TEXTURE_2D);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

        // =========================================================================
        // Buffers
        // =========================================================================

        glGenVertexArrays(1, *renderable_mesh.vao);
        glGenBuffers(1, *renderable_mesh.vbo);
        glGenBuffers(1, *renderable_mesh.ebo);

        glBindVertexArray(renderable_mesh.vao);

        // EBO
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, renderable_mesh.ebo);
        glBufferData(
            GL_ELEMENT_ARRAY_BUFFER,
            it.indices.count * size_of(GLTF.Mesh.INDEX_TYPE),
            it.indices.data,
            GL_STATIC_DRAW,
        );

        // VBO
        glBindBuffer(GL_ARRAY_BUFFER, renderable_mesh.vbo);
        glBufferData(
            GL_ARRAY_BUFFER,
            it.vertices.count * size_of(GLTF.Vertex),
            it.vertices.data,
            GL_STATIC_DRAW,
        );
        // Position
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(
            0,
            3,
            GL_FLOAT,
            GL_FALSE,
            size_of(GLTF.Vertex),
            cast(*void, GLTF.Vertex.POSITION_OFFSET),
        );
        // Normal
        glEnableVertexAttribArray(1);
        glVertexAttribPointer(
            1,
            3,
            GL_FLOAT,
            GL_FALSE,
            size_of(GLTF.Vertex),
            cast(*void, GLTF.Vertex.NORMAL_OFFSET),
        );
        // UV
        glEnableVertexAttribArray(2);
        glVertexAttribPointer(
            2,
            2,
            GL_FLOAT,
            GL_FALSE,
            size_of(GLTF.Vertex),
            cast(*void, GLTF.Vertex.UV_OFFSET),
        );

        array_add(*renderable.meshes, renderable_mesh);
    }

    return renderable;
}

release_renderable :: (renderable: *Renderable) {
    using gl;

    for renderable.meshes {
        glDeleteVertexArrays(1, *it.vao);
        glDeleteBuffers(1, *it.vbo);
        glDeleteBuffers(1, *it.ebo);
        glDeleteTextures(1, *it.texture);
    }
    array_free(renderable.meshes);

    for renderable.nodes {
        array_free(it.children_indices);
    }
    array_free(renderable.nodes);

    renderable.* = {};
}

process_input :: () {
    Input.update_window_events();

    for Input.events_this_frame {
        if it.type == {
            case .QUIT;
                should_quit = true;
        }
    }

    for Input.get_window_resizes() {
        Simp.update_window(it.window);
        width, height := Simp.get_render_dimensions(it.window);

        projection_transform = make_projection_matrix(
            SIXTY_DEGREES_IN_RADIANS,
            cast(float, width) / cast(float, height),
            Z_NEAR,
            Z_FAR,
        );
    }
}
