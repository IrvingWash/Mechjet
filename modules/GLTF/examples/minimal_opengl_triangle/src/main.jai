#import "Basic"()(
    MEMORY_DEBUGGER = true,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = true,
);
WC :: #import "Window_Creation";
Simp :: #import "Simp"; // Only for set_render_target and swap_buffers
Input :: #import "Input";
#import "Math";
#import "GL";

GLTF :: #import,file "../../../module.jai"(DO_SANITY_CHECKS = true);

Renderable :: struct {
    meshes: [..]Mesh;

    Mesh :: struct {
        vao: u32;
        vbo: u32;
        ebo: u32;

        index_count: u32;

        local_transform: Matrix4; // Not using nodes to keep this example simple

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

void main()
{
    gl_Position = uProjectionTransform * uViewTransform * uModelTransform * vec4(aPosition, 1);
}
GLSL

FRAGMENT_SOURCE :: #string GLSL
#version 330 core

uniform vec4 uColor;

out vec4 fragmentColor;

void main()
{
    fragmentColor = uColor;
}
GLSL

SIXTY_DEGREES_IN_RADIANS :: 1.0472;

WINDOW_WIDTH  :: 800.0;
WINDOW_HEIGHT :: 600.0;

Z_NEAR :: 0.1;
Z_FAR  :: 1000;

should_quit: bool;
projection_transform: Matrix4;

main :: () {
    defer report_memory_leaks();

    // =========================================================================
    // Window
    // =========================================================================
    window := WC.create_window(cast(s32, WINDOW_WIDTH), cast(s32, WINDOW_HEIGHT), "Triangle");
    Simp.set_render_target(window);

    // =========================================================================
    // Creating renderables
    // =========================================================================
    renderable_triangle := make_renderable_triangle();
    defer release_renderable(*renderable_triangle);
    
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

    uColor := glGetUniformLocation(shader, "uColor");
    uModelTransform := glGetUniformLocation(shader, "uModelTransform");
    uViewTransform := glGetUniformLocation(shader, "uViewTransform");
    uProjectionTransform := glGetUniformLocation(shader, "uProjectionTransform");

    // =========================================================================
    // Create transforms
    // =========================================================================
    view_transform := make_look_at_matrix({ 3, 0, 0 }, { 0, 0, 0 }, { 0, 1, 0 }, false);
    projection_transform = make_projection_matrix(
        SIXTY_DEGREES_IN_RADIANS,
        WINDOW_WIDTH / WINDOW_HEIGHT,
        Z_NEAR,
        Z_FAR,
    );

    // =========================================================================
    // Game loop
    // =========================================================================
    while !should_quit {
        process_input();

        glClearColor(0, 0, 1, 1);
        glClear(GL_COLOR_BUFFER_BIT);

        glUseProgram(shader);

        for renderable_triangle.meshes {
            if it.material.double_sided {
                glDisable(GL_CULL_FACE);
            } else {
                glEnable(GL_CULL_FACE);
            }

            if it.material.alpha_mode == .BLEND {
                glEnable(GL_BLEND);
            } else {
                glDisable(GL_BLEND);
            }

            {
                using it.material.pbr_metallic_roughness.base_color_factor;
                glUniform4f(uColor, x, y, z, w);
            }
            glUniformMatrix4fv(uModelTransform, 1, GL_TRUE, *it.local_transform.coef[0][0]);
            glUniformMatrix4fv(uViewTransform, 1, GL_TRUE, *view_transform.coef[0][0]);
            glUniformMatrix4fv(uProjectionTransform, 1, GL_TRUE, *projection_transform.coef[0][0]);

            glBindVertexArray(it.vao);

            glDrawElements(
                GL_TRIANGLES,
                cast(GLsizei, it.index_count),
                GL_UNSIGNED_INT,
                cast(*void, 0),
            );
        }

        Simp.swap_buffers(window);

        reset_temporary_storage();
    }
}

make_renderable_triangle :: () -> Renderable {
    renderable: Renderable;

    // =========================================================================
    // Asset loading
    // =========================================================================
    converter := GLTF.create_converter();

    error, triangle_scene := GLTF.load_scene(converter, "assets/triangle_glb/triangle.glb");
    assert(!error, error);
    defer GLTF.release_scene(*triangle_scene);

    // We don't need the converter anymore as we loaded all the models we wanted.
    GLTF.destroy_converter(converter);

    // =========================================================================
    // OpenGL buffers
    // =========================================================================
    using gl;

    for triangle_scene.meshes {
        renderable_mesh: Renderable.Mesh;
        renderable_mesh.index_count = xx it.indices.count;
        renderable_mesh.material = triangle_scene.materials[it.material_index];
        renderable_mesh.local_transform = triangle_scene.nodes[0].local_transform;

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
    }
    array_free(renderable.meshes);

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
