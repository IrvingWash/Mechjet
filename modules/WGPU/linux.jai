//
// This file was auto-generated using the following command:
//
// jai ./modules/WGPU/generate.jai
//



/**
* \defgroup UtilityTypes Utility Types
*
* @{
*/
Flags :: u64;
Bool :: u32;

/**
* Nullable value defining a pointer+length view into a UTF-8 encoded string.
*
* Values passed into the API may use the special length value @ref WGPU_STRLEN
* to indicate a null-terminated string.
* Non-null values passed out of the API (for example as callback arguments)
* always provide an explicit length and **may or may not be null-terminated**.
*
* Some inputs to the API accept null values. Those which do not accept null
* values "default" to the empty string when null values are passed.
*
* Values are encoded as follows:
* - `{NULL, WGPU_STRLEN}`: the null value.
* - `{non_null_pointer, WGPU_STRLEN}`: a null-terminated string view.
* - `{any, 0}`: the empty string.
* - `{NULL, non_zero_length}`: not allowed (null dereference).
* - `{non_null_pointer, non_zero_length}`: an explictly-sized string view with
*   size `non_zero_length` (in bytes).
*
* For info on how this is used in various places, see \ref Strings.
*/
StringView :: struct {
    data:   *u8;
    length: u64;
}

AdapterImpl :: struct {}
/**
* \defgroup Objects
* \brief Opaque, non-dispatchable handles to WebGPU objects.
*
* @{
*/
Adapter :: *AdapterImpl;
BindGroupImpl :: struct {}
BindGroup :: *BindGroupImpl;
BindGroupLayoutImpl :: struct {}
BindGroupLayout :: *BindGroupLayoutImpl;
BufferImpl :: struct {}
Buffer :: *BufferImpl;
CommandBufferImpl :: struct {}
CommandBuffer :: *CommandBufferImpl;
CommandEncoderImpl :: struct {}
CommandEncoder :: *CommandEncoderImpl;
ComputePassEncoderImpl :: struct {}
ComputePassEncoder :: *ComputePassEncoderImpl;
ComputePipelineImpl :: struct {}
ComputePipeline :: *ComputePipelineImpl;
DeviceImpl :: struct {}
Device :: *DeviceImpl;
InstanceImpl :: struct {}
Instance :: *InstanceImpl;
PipelineLayoutImpl :: struct {}
PipelineLayout :: *PipelineLayoutImpl;
QuerySetImpl :: struct {}
QuerySet :: *QuerySetImpl;
QueueImpl :: struct {}
Queue :: *QueueImpl;
RenderBundleImpl :: struct {}
RenderBundle :: *RenderBundleImpl;
RenderBundleEncoderImpl :: struct {}
RenderBundleEncoder :: *RenderBundleEncoderImpl;
RenderPassEncoderImpl :: struct {}
RenderPassEncoder :: *RenderPassEncoderImpl;
RenderPipelineImpl :: struct {}
RenderPipeline :: *RenderPipelineImpl;
SamplerImpl :: struct {}
Sampler :: *SamplerImpl;
ShaderModuleImpl :: struct {}
ShaderModule :: *ShaderModuleImpl;

SurfaceImpl :: struct {}
/**
* An object used to continuously present image data to the user, see @ref Surfaces for more details.
*/
Surface :: *SurfaceImpl;
TextureImpl :: struct {}
Texture :: *TextureImpl;
TextureViewImpl :: struct {}
TextureView :: *TextureViewImpl;

/**
* \defgroup Enumerations
* \brief Enums.
*
* @{
*/
AdapterType :: enum u32 {
    DiscreteGPU   :: 1;
    IntegratedGPU :: 2;
    CPU           :: 3;
    Unknown       :: 4;
    Force32       :: 2147483647;

    WGPUAdapterType_DiscreteGPU   :: DiscreteGPU;
    WGPUAdapterType_IntegratedGPU :: IntegratedGPU;
    WGPUAdapterType_CPU           :: CPU;
    WGPUAdapterType_Unknown       :: Unknown;
    WGPUAdapterType_Force32       :: Force32;
}

AddressMode :: enum u32 {
    Undefined    :: 0;
    ClampToEdge  :: 1;
    Repeat       :: 2;
    MirrorRepeat :: 3;
    Force32      :: 2147483647;

    WGPUAddressMode_Undefined    :: Undefined;
    WGPUAddressMode_ClampToEdge  :: ClampToEdge;
    WGPUAddressMode_Repeat       :: Repeat;
    WGPUAddressMode_MirrorRepeat :: MirrorRepeat;
    WGPUAddressMode_Force32      :: Force32;
}

BackendType :: enum u32 {
    Undefined :: 0;
    Null      :: 1;
    WebGPU    :: 2;
    D3D11     :: 3;
    D3D12     :: 4;
    Metal     :: 5;
    Vulkan    :: 6;
    OpenGL    :: 7;
    OpenGLES  :: 8;
    Force32   :: 2147483647;

    WGPUBackendType_Undefined :: Undefined;
    WGPUBackendType_Null      :: Null;
    WGPUBackendType_WebGPU    :: WebGPU;
    WGPUBackendType_D3D11     :: D3D11;
    WGPUBackendType_D3D12     :: D3D12;
    WGPUBackendType_Metal     :: Metal;
    WGPUBackendType_Vulkan    :: Vulkan;
    WGPUBackendType_OpenGL    :: OpenGL;
    WGPUBackendType_OpenGLES  :: OpenGLES;
    WGPUBackendType_Force32   :: Force32;
}

BlendFactor :: enum u32 {
    Undefined         :: 0;
    Zero              :: 1;
    One               :: 2;
    Src               :: 3;
    OneMinusSrc       :: 4;
    SrcAlpha          :: 5;
    OneMinusSrcAlpha  :: 6;
    Dst               :: 7;
    OneMinusDst       :: 8;
    DstAlpha          :: 9;
    OneMinusDstAlpha  :: 10;
    SrcAlphaSaturated :: 11;
    Constant          :: 12;
    OneMinusConstant  :: 13;
    Src1              :: 14;
    OneMinusSrc1      :: 15;
    Src1Alpha         :: 16;
    OneMinusSrc1Alpha :: 17;
    Force32           :: 2147483647;

    WGPUBlendFactor_Undefined         :: Undefined;
    WGPUBlendFactor_Zero              :: Zero;
    WGPUBlendFactor_One               :: One;
    WGPUBlendFactor_Src               :: Src;
    WGPUBlendFactor_OneMinusSrc       :: OneMinusSrc;
    WGPUBlendFactor_SrcAlpha          :: SrcAlpha;
    WGPUBlendFactor_OneMinusSrcAlpha  :: OneMinusSrcAlpha;
    WGPUBlendFactor_Dst               :: Dst;
    WGPUBlendFactor_OneMinusDst       :: OneMinusDst;
    WGPUBlendFactor_DstAlpha          :: DstAlpha;
    WGPUBlendFactor_OneMinusDstAlpha  :: OneMinusDstAlpha;
    WGPUBlendFactor_SrcAlphaSaturated :: SrcAlphaSaturated;
    WGPUBlendFactor_Constant          :: Constant;
    WGPUBlendFactor_OneMinusConstant  :: OneMinusConstant;
    WGPUBlendFactor_Src1              :: Src1;
    WGPUBlendFactor_OneMinusSrc1      :: OneMinusSrc1;
    WGPUBlendFactor_Src1Alpha         :: Src1Alpha;
    WGPUBlendFactor_OneMinusSrc1Alpha :: OneMinusSrc1Alpha;
    WGPUBlendFactor_Force32           :: Force32;
}

BlendOperation :: enum u32 {
    Undefined       :: 0;
    Add             :: 1;
    Subtract        :: 2;
    ReverseSubtract :: 3;
    Min             :: 4;
    Max             :: 5;
    Force32         :: 2147483647;

    WGPUBlendOperation_Undefined       :: Undefined;
    WGPUBlendOperation_Add             :: Add;
    WGPUBlendOperation_Subtract        :: Subtract;
    WGPUBlendOperation_ReverseSubtract :: ReverseSubtract;
    WGPUBlendOperation_Min             :: Min;
    WGPUBlendOperation_Max             :: Max;
    WGPUBlendOperation_Force32         :: Force32;
}

BufferBindingType :: enum u32 {
    BindingNotUsed  :: 0;

    Undefined       :: 1;
    Uniform         :: 2;
    Storage         :: 3;
    ReadOnlyStorage :: 4;
    Force32         :: 2147483647;

    WGPUBufferBindingType_BindingNotUsed  :: BindingNotUsed;

    WGPUBufferBindingType_Undefined       :: Undefined;
    WGPUBufferBindingType_Uniform         :: Uniform;
    WGPUBufferBindingType_Storage         :: Storage;
    WGPUBufferBindingType_ReadOnlyStorage :: ReadOnlyStorage;
    WGPUBufferBindingType_Force32         :: Force32;
}

BufferMapState :: enum u32 {
    Unmapped :: 1;
    Pending  :: 2;
    Mapped   :: 3;
    Force32  :: 2147483647;

    WGPUBufferMapState_Unmapped :: Unmapped;
    WGPUBufferMapState_Pending  :: Pending;
    WGPUBufferMapState_Mapped   :: Mapped;
    WGPUBufferMapState_Force32  :: Force32;
}

/**
* The callback mode controls how a callback for an asynchronous operation may be fired. See @ref Asynchronous-Operations for how these are used.
*/
CallbackMode :: enum u32 {
    WaitAnyOnly        :: 1;

    AllowProcessEvents :: 2;

    AllowSpontaneous   :: 3;
    Force32            :: 2147483647;

    WGPUCallbackMode_WaitAnyOnly        :: WaitAnyOnly;

    WGPUCallbackMode_AllowProcessEvents :: AllowProcessEvents;

    WGPUCallbackMode_AllowSpontaneous   :: AllowSpontaneous;
    WGPUCallbackMode_Force32            :: Force32;
}

CompareFunction :: enum u32 {
    Undefined    :: 0;
    Never        :: 1;
    Less         :: 2;
    Equal        :: 3;
    LessEqual    :: 4;
    Greater      :: 5;
    NotEqual     :: 6;
    GreaterEqual :: 7;
    Always       :: 8;
    Force32      :: 2147483647;

    WGPUCompareFunction_Undefined    :: Undefined;
    WGPUCompareFunction_Never        :: Never;
    WGPUCompareFunction_Less         :: Less;
    WGPUCompareFunction_Equal        :: Equal;
    WGPUCompareFunction_LessEqual    :: LessEqual;
    WGPUCompareFunction_Greater      :: Greater;
    WGPUCompareFunction_NotEqual     :: NotEqual;
    WGPUCompareFunction_GreaterEqual :: GreaterEqual;
    WGPUCompareFunction_Always       :: Always;
    WGPUCompareFunction_Force32      :: Force32;
}

CompilationInfoRequestStatus :: enum u32 {
    Success         :: 1;
    InstanceDropped :: 2;
    Error           :: 3;
    Unknown         :: 4;
    Force32         :: 2147483647;

    WGPUCompilationInfoRequestStatus_Success         :: Success;
    WGPUCompilationInfoRequestStatus_InstanceDropped :: InstanceDropped;
    WGPUCompilationInfoRequestStatus_Error           :: Error;
    WGPUCompilationInfoRequestStatus_Unknown         :: Unknown;
    WGPUCompilationInfoRequestStatus_Force32         :: Force32;
}

CompilationMessageType :: enum u32 {
    Error   :: 1;
    Warning :: 2;
    Info    :: 3;
    Force32 :: 2147483647;

    WGPUCompilationMessageType_Error   :: Error;
    WGPUCompilationMessageType_Warning :: Warning;
    WGPUCompilationMessageType_Info    :: Info;
    WGPUCompilationMessageType_Force32 :: Force32;
}

/**
* Describes how frames are composited with other contents on the screen when `::wgpuSurfacePresent` is called.
*/
CompositeAlphaMode :: enum u32 {
    Auto            :: 0;

    Opaque          :: 1;

    Premultiplied   :: 2;

    Unpremultiplied :: 3;

    Inherit         :: 4;
    Force32         :: 2147483647;

    WGPUCompositeAlphaMode_Auto            :: Auto;

    WGPUCompositeAlphaMode_Opaque          :: Opaque;

    WGPUCompositeAlphaMode_Premultiplied   :: Premultiplied;

    WGPUCompositeAlphaMode_Unpremultiplied :: Unpremultiplied;

    WGPUCompositeAlphaMode_Inherit         :: Inherit;
    WGPUCompositeAlphaMode_Force32         :: Force32;
}

CreatePipelineAsyncStatus :: enum u32 {
    Success         :: 1;
    InstanceDropped :: 2;
    ValidationError :: 3;
    InternalError   :: 4;
    Unknown         :: 5;
    Force32         :: 2147483647;

    WGPUCreatePipelineAsyncStatus_Success         :: Success;
    WGPUCreatePipelineAsyncStatus_InstanceDropped :: InstanceDropped;
    WGPUCreatePipelineAsyncStatus_ValidationError :: ValidationError;
    WGPUCreatePipelineAsyncStatus_InternalError   :: InternalError;
    WGPUCreatePipelineAsyncStatus_Unknown         :: Unknown;
    WGPUCreatePipelineAsyncStatus_Force32         :: Force32;
}

CullMode :: enum u32 {
    Undefined :: 0;
    None      :: 1;
    Front     :: 2;
    Back      :: 3;
    Force32   :: 2147483647;

    WGPUCullMode_Undefined :: Undefined;
    WGPUCullMode_None      :: None;
    WGPUCullMode_Front     :: Front;
    WGPUCullMode_Back      :: Back;
    WGPUCullMode_Force32   :: Force32;
}

DeviceLostReason :: enum u32 {
    Unknown         :: 1;
    Destroyed       :: 2;
    InstanceDropped :: 3;
    FailedCreation  :: 4;
    Force32         :: 2147483647;

    WGPUDeviceLostReason_Unknown         :: Unknown;
    WGPUDeviceLostReason_Destroyed       :: Destroyed;
    WGPUDeviceLostReason_InstanceDropped :: InstanceDropped;
    WGPUDeviceLostReason_FailedCreation  :: FailedCreation;
    WGPUDeviceLostReason_Force32         :: Force32;
}

ErrorFilter :: enum u32 {
    Validation  :: 1;
    OutOfMemory :: 2;
    Internal    :: 3;
    Force32     :: 2147483647;

    WGPUErrorFilter_Validation  :: Validation;
    WGPUErrorFilter_OutOfMemory :: OutOfMemory;
    WGPUErrorFilter_Internal    :: Internal;
    WGPUErrorFilter_Force32     :: Force32;
}

ErrorType :: enum u32 {
    NoError     :: 1;
    Validation  :: 2;
    OutOfMemory :: 3;
    Internal    :: 4;
    Unknown     :: 5;
    Force32     :: 2147483647;

    WGPUErrorType_NoError     :: NoError;
    WGPUErrorType_Validation  :: Validation;
    WGPUErrorType_OutOfMemory :: OutOfMemory;
    WGPUErrorType_Internal    :: Internal;
    WGPUErrorType_Unknown     :: Unknown;
    WGPUErrorType_Force32     :: Force32;
}

/**
* See @ref WGPURequestAdapterOptions::featureLevel.
*/
FeatureLevel :: enum u32 {
    Compatibility :: 1;

    Core          :: 2;
    Force32       :: 2147483647;

    WGPUFeatureLevel_Compatibility :: Compatibility;

    WGPUFeatureLevel_Core          :: Core;
    WGPUFeatureLevel_Force32       :: Force32;
}

FeatureName :: enum u32 {
    Undefined                      :: 0;
    DepthClipControl               :: 1;
    Depth32FloatStencil8           :: 2;
    TimestampQuery                 :: 3;
    TextureCompressionBC           :: 4;
    TextureCompressionBCSliced3D   :: 5;
    TextureCompressionETC2         :: 6;
    TextureCompressionASTC         :: 7;
    TextureCompressionASTCSliced3D :: 8;
    IndirectFirstInstance          :: 9;
    ShaderF16                      :: 10;
    RG11B10UfloatRenderable        :: 11;
    BGRA8UnormStorage              :: 12;
    Float32Filterable              :: 13;
    Float32Blendable               :: 14;
    ClipDistances                  :: 15;
    DualSourceBlending             :: 16;
    Force32                        :: 2147483647;

    WGPUFeatureName_Undefined                      :: Undefined;
    WGPUFeatureName_DepthClipControl               :: DepthClipControl;
    WGPUFeatureName_Depth32FloatStencil8           :: Depth32FloatStencil8;
    WGPUFeatureName_TimestampQuery                 :: TimestampQuery;
    WGPUFeatureName_TextureCompressionBC           :: TextureCompressionBC;
    WGPUFeatureName_TextureCompressionBCSliced3D   :: TextureCompressionBCSliced3D;
    WGPUFeatureName_TextureCompressionETC2         :: TextureCompressionETC2;
    WGPUFeatureName_TextureCompressionASTC         :: TextureCompressionASTC;
    WGPUFeatureName_TextureCompressionASTCSliced3D :: TextureCompressionASTCSliced3D;
    WGPUFeatureName_IndirectFirstInstance          :: IndirectFirstInstance;
    WGPUFeatureName_ShaderF16                      :: ShaderF16;
    WGPUFeatureName_RG11B10UfloatRenderable        :: RG11B10UfloatRenderable;
    WGPUFeatureName_BGRA8UnormStorage              :: BGRA8UnormStorage;
    WGPUFeatureName_Float32Filterable              :: Float32Filterable;
    WGPUFeatureName_Float32Blendable               :: Float32Blendable;
    WGPUFeatureName_ClipDistances                  :: ClipDistances;
    WGPUFeatureName_DualSourceBlending             :: DualSourceBlending;
    WGPUFeatureName_Force32                        :: Force32;
}

FilterMode :: enum u32 {
    Undefined :: 0;
    Nearest   :: 1;
    Linear    :: 2;
    Force32   :: 2147483647;

    WGPUFilterMode_Undefined :: Undefined;
    WGPUFilterMode_Nearest   :: Nearest;
    WGPUFilterMode_Linear    :: Linear;
    WGPUFilterMode_Force32   :: Force32;
}

FrontFace :: enum u32 {
    Undefined :: 0;
    CCW       :: 1;
    CW        :: 2;
    Force32   :: 2147483647;

    WGPUFrontFace_Undefined :: Undefined;
    WGPUFrontFace_CCW       :: CCW;
    WGPUFrontFace_CW        :: CW;
    WGPUFrontFace_Force32   :: Force32;
}

IndexFormat :: enum u32 {
    Undefined :: 0;
    Uint16    :: 1;
    Uint32    :: 2;
    Force32   :: 2147483647;

    WGPUIndexFormat_Undefined :: Undefined;
    WGPUIndexFormat_Uint16    :: Uint16;
    WGPUIndexFormat_Uint32    :: Uint32;
    WGPUIndexFormat_Force32   :: Force32;
}

LoadOp :: enum u32 {
    Undefined :: 0;
    Load      :: 1;
    Clear     :: 2;
    Force32   :: 2147483647;

    WGPULoadOp_Undefined :: Undefined;
    WGPULoadOp_Load      :: Load;
    WGPULoadOp_Clear     :: Clear;
    WGPULoadOp_Force32   :: Force32;
}

MapAsyncStatus :: enum u32 {
    Success         :: 1;
    InstanceDropped :: 2;
    Error           :: 3;
    Aborted         :: 4;
    Unknown         :: 5;
    Force32         :: 2147483647;

    WGPUMapAsyncStatus_Success         :: Success;
    WGPUMapAsyncStatus_InstanceDropped :: InstanceDropped;
    WGPUMapAsyncStatus_Error           :: Error;
    WGPUMapAsyncStatus_Aborted         :: Aborted;
    WGPUMapAsyncStatus_Unknown         :: Unknown;
    WGPUMapAsyncStatus_Force32         :: Force32;
}

MipmapFilterMode :: enum u32 {
    Undefined :: 0;
    Nearest   :: 1;
    Linear    :: 2;
    Force32   :: 2147483647;

    WGPUMipmapFilterMode_Undefined :: Undefined;
    WGPUMipmapFilterMode_Nearest   :: Nearest;
    WGPUMipmapFilterMode_Linear    :: Linear;
    WGPUMipmapFilterMode_Force32   :: Force32;
}

OptionalBool :: enum u32 {
    False     :: 0;
    True      :: 1;
    Undefined :: 2;
    Force32   :: 2147483647;

    WGPUOptionalBool_False     :: False;
    WGPUOptionalBool_True      :: True;
    WGPUOptionalBool_Undefined :: Undefined;
    WGPUOptionalBool_Force32   :: Force32;
}

PopErrorScopeStatus :: enum u32 {
    Success         :: 1;
    InstanceDropped :: 2;

    EmptyStack      :: 3;
    Force32         :: 2147483647;

    WGPUPopErrorScopeStatus_Success         :: Success;
    WGPUPopErrorScopeStatus_InstanceDropped :: InstanceDropped;

    WGPUPopErrorScopeStatus_EmptyStack      :: EmptyStack;
    WGPUPopErrorScopeStatus_Force32         :: Force32;
}

PowerPreference :: enum u32 {
    Undefined       :: 0;
    LowPower        :: 1;
    HighPerformance :: 2;
    Force32         :: 2147483647;

    WGPUPowerPreference_Undefined       :: Undefined;
    WGPUPowerPreference_LowPower        :: LowPower;
    WGPUPowerPreference_HighPerformance :: HighPerformance;
    WGPUPowerPreference_Force32         :: Force32;
}

/**
* Describes when and in which order frames are presented on the screen when `::wgpuSurfacePresent` is called.
*/
PresentMode :: enum u32 {
    Undefined   :: 0;

    Fifo        :: 1;

    FifoRelaxed :: 2;

    Immediate   :: 3;

    Mailbox     :: 4;
    Force32     :: 2147483647;

    WGPUPresentMode_Undefined   :: Undefined;

    WGPUPresentMode_Fifo        :: Fifo;

    WGPUPresentMode_FifoRelaxed :: FifoRelaxed;

    WGPUPresentMode_Immediate   :: Immediate;

    WGPUPresentMode_Mailbox     :: Mailbox;
    WGPUPresentMode_Force32     :: Force32;
}

PrimitiveTopology :: enum u32 {
    Undefined     :: 0;
    PointList     :: 1;
    LineList      :: 2;
    LineStrip     :: 3;
    TriangleList  :: 4;
    TriangleStrip :: 5;
    Force32       :: 2147483647;

    WGPUPrimitiveTopology_Undefined     :: Undefined;
    WGPUPrimitiveTopology_PointList     :: PointList;
    WGPUPrimitiveTopology_LineList      :: LineList;
    WGPUPrimitiveTopology_LineStrip     :: LineStrip;
    WGPUPrimitiveTopology_TriangleList  :: TriangleList;
    WGPUPrimitiveTopology_TriangleStrip :: TriangleStrip;
    WGPUPrimitiveTopology_Force32       :: Force32;
}

QueryType :: enum u32 {
    Occlusion :: 1;
    Timestamp :: 2;
    Force32   :: 2147483647;

    WGPUQueryType_Occlusion :: Occlusion;
    WGPUQueryType_Timestamp :: Timestamp;
    WGPUQueryType_Force32   :: Force32;
}

QueueWorkDoneStatus :: enum u32 {
    Success         :: 1;
    InstanceDropped :: 2;
    Error           :: 3;
    Unknown         :: 4;
    Force32         :: 2147483647;

    WGPUQueueWorkDoneStatus_Success         :: Success;
    WGPUQueueWorkDoneStatus_InstanceDropped :: InstanceDropped;
    WGPUQueueWorkDoneStatus_Error           :: Error;
    WGPUQueueWorkDoneStatus_Unknown         :: Unknown;
    WGPUQueueWorkDoneStatus_Force32         :: Force32;
}

RequestAdapterStatus :: enum u32 {
    Success         :: 1;
    InstanceDropped :: 2;
    Unavailable     :: 3;
    Error           :: 4;
    Unknown         :: 5;
    Force32         :: 2147483647;

    WGPURequestAdapterStatus_Success         :: Success;
    WGPURequestAdapterStatus_InstanceDropped :: InstanceDropped;
    WGPURequestAdapterStatus_Unavailable     :: Unavailable;
    WGPURequestAdapterStatus_Error           :: Error;
    WGPURequestAdapterStatus_Unknown         :: Unknown;
    WGPURequestAdapterStatus_Force32         :: Force32;
}

RequestDeviceStatus :: enum u32 {
    Success         :: 1;
    InstanceDropped :: 2;
    Error           :: 3;
    Unknown         :: 4;
    Force32         :: 2147483647;

    WGPURequestDeviceStatus_Success         :: Success;
    WGPURequestDeviceStatus_InstanceDropped :: InstanceDropped;
    WGPURequestDeviceStatus_Error           :: Error;
    WGPURequestDeviceStatus_Unknown         :: Unknown;
    WGPURequestDeviceStatus_Force32         :: Force32;
}

SType :: enum u32 {
    ShaderSourceSPIRV                :: 1;
    ShaderSourceWGSL                 :: 2;
    RenderPassMaxDrawCount           :: 3;
    SurfaceSourceMetalLayer          :: 4;
    SurfaceSourceWindowsHWND         :: 5;
    SurfaceSourceXlibWindow          :: 6;
    SurfaceSourceWaylandSurface      :: 7;
    SurfaceSourceAndroidNativeWindow :: 8;
    SurfaceSourceXCBWindow           :: 9;
    Force32                          :: 2147483647;

    WGPUSType_ShaderSourceSPIRV                :: ShaderSourceSPIRV;
    WGPUSType_ShaderSourceWGSL                 :: ShaderSourceWGSL;
    WGPUSType_RenderPassMaxDrawCount           :: RenderPassMaxDrawCount;
    WGPUSType_SurfaceSourceMetalLayer          :: SurfaceSourceMetalLayer;
    WGPUSType_SurfaceSourceWindowsHWND         :: SurfaceSourceWindowsHWND;
    WGPUSType_SurfaceSourceXlibWindow          :: SurfaceSourceXlibWindow;
    WGPUSType_SurfaceSourceWaylandSurface      :: SurfaceSourceWaylandSurface;
    WGPUSType_SurfaceSourceAndroidNativeWindow :: SurfaceSourceAndroidNativeWindow;
    WGPUSType_SurfaceSourceXCBWindow           :: SurfaceSourceXCBWindow;
    WGPUSType_Force32                          :: Force32;
}

SamplerBindingType :: enum u32 {
    BindingNotUsed :: 0;

    Undefined      :: 1;
    Filtering      :: 2;
    NonFiltering   :: 3;
    Comparison     :: 4;
    Force32        :: 2147483647;

    WGPUSamplerBindingType_BindingNotUsed :: BindingNotUsed;

    WGPUSamplerBindingType_Undefined      :: Undefined;
    WGPUSamplerBindingType_Filtering      :: Filtering;
    WGPUSamplerBindingType_NonFiltering   :: NonFiltering;
    WGPUSamplerBindingType_Comparison     :: Comparison;
    WGPUSamplerBindingType_Force32        :: Force32;
}

/**
* Status code returned (synchronously) from many operations. Generally
* indicates an invalid input like an unknown enum value or @ref OutStructChainError.
* Read the function's documentation for specific error conditions.
*/
Status :: enum u32 {
    Success :: 1;
    Error   :: 2;
    Force32 :: 2147483647;

    WGPUStatus_Success :: Success;
    WGPUStatus_Error   :: Error;
    WGPUStatus_Force32 :: Force32;
}

StencilOperation :: enum u32 {
    Undefined      :: 0;
    Keep           :: 1;
    Zero           :: 2;
    Replace        :: 3;
    Invert         :: 4;
    IncrementClamp :: 5;
    DecrementClamp :: 6;
    IncrementWrap  :: 7;
    DecrementWrap  :: 8;
    Force32        :: 2147483647;

    WGPUStencilOperation_Undefined      :: Undefined;
    WGPUStencilOperation_Keep           :: Keep;
    WGPUStencilOperation_Zero           :: Zero;
    WGPUStencilOperation_Replace        :: Replace;
    WGPUStencilOperation_Invert         :: Invert;
    WGPUStencilOperation_IncrementClamp :: IncrementClamp;
    WGPUStencilOperation_DecrementClamp :: DecrementClamp;
    WGPUStencilOperation_IncrementWrap  :: IncrementWrap;
    WGPUStencilOperation_DecrementWrap  :: DecrementWrap;
    WGPUStencilOperation_Force32        :: Force32;
}

StorageTextureAccess :: enum u32 {
    BindingNotUsed :: 0;

    Undefined      :: 1;
    WriteOnly      :: 2;
    ReadOnly       :: 3;
    ReadWrite      :: 4;
    Force32        :: 2147483647;

    WGPUStorageTextureAccess_BindingNotUsed :: BindingNotUsed;

    WGPUStorageTextureAccess_Undefined      :: Undefined;
    WGPUStorageTextureAccess_WriteOnly      :: WriteOnly;
    WGPUStorageTextureAccess_ReadOnly       :: ReadOnly;
    WGPUStorageTextureAccess_ReadWrite      :: ReadWrite;
    WGPUStorageTextureAccess_Force32        :: Force32;
}

StoreOp :: enum u32 {
    Undefined :: 0;
    Store     :: 1;
    Discard   :: 2;
    Force32   :: 2147483647;

    WGPUStoreOp_Undefined :: Undefined;
    WGPUStoreOp_Store     :: Store;
    WGPUStoreOp_Discard   :: Discard;
    WGPUStoreOp_Force32   :: Force32;
}

/**
* The status enum for `::wgpuSurfaceGetCurrentTexture`.
*/
SurfaceGetCurrentTextureStatus :: enum u32 {
    SuccessOptimal    :: 1;

    SuccessSuboptimal :: 2;

    Timeout           :: 3;

    Outdated          :: 4;

    Lost              :: 5;

    OutOfMemory       :: 6;

    DeviceLost        :: 7;

    Error             :: 8;
    Force32           :: 2147483647;

    WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal    :: SuccessOptimal;

    WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal :: SuccessSuboptimal;

    WGPUSurfaceGetCurrentTextureStatus_Timeout           :: Timeout;

    WGPUSurfaceGetCurrentTextureStatus_Outdated          :: Outdated;

    WGPUSurfaceGetCurrentTextureStatus_Lost              :: Lost;

    WGPUSurfaceGetCurrentTextureStatus_OutOfMemory       :: OutOfMemory;

    WGPUSurfaceGetCurrentTextureStatus_DeviceLost        :: DeviceLost;

    WGPUSurfaceGetCurrentTextureStatus_Error             :: Error;
    WGPUSurfaceGetCurrentTextureStatus_Force32           :: Force32;
}

TextureAspect :: enum u32 {
    Undefined   :: 0;
    All         :: 1;
    StencilOnly :: 2;
    DepthOnly   :: 3;
    Force32     :: 2147483647;

    WGPUTextureAspect_Undefined   :: Undefined;
    WGPUTextureAspect_All         :: All;
    WGPUTextureAspect_StencilOnly :: StencilOnly;
    WGPUTextureAspect_DepthOnly   :: DepthOnly;
    WGPUTextureAspect_Force32     :: Force32;
}

TextureDimension :: enum u32 {
    Undefined :: 0;
    _1D       :: 1;
    _2D       :: 2;
    _3D       :: 3;
    Force32   :: 2147483647;

    WGPUTextureDimension_Undefined :: Undefined;
    WGPUTextureDimension_1D        :: _1D;
    WGPUTextureDimension_2D        :: _2D;
    WGPUTextureDimension_3D        :: _3D;
    WGPUTextureDimension_Force32   :: Force32;
}

TextureFormat :: enum u32 {
    Undefined            :: 0;
    R8Unorm              :: 1;
    R8Snorm              :: 2;
    R8Uint               :: 3;
    R8Sint               :: 4;
    R16Uint              :: 5;
    R16Sint              :: 6;
    R16Float             :: 7;
    RG8Unorm             :: 8;
    RG8Snorm             :: 9;
    RG8Uint              :: 10;
    RG8Sint              :: 11;
    R32Float             :: 12;
    R32Uint              :: 13;
    R32Sint              :: 14;
    RG16Uint             :: 15;
    RG16Sint             :: 16;
    RG16Float            :: 17;
    RGBA8Unorm           :: 18;
    RGBA8UnormSrgb       :: 19;
    RGBA8Snorm           :: 20;
    RGBA8Uint            :: 21;
    RGBA8Sint            :: 22;
    BGRA8Unorm           :: 23;
    BGRA8UnormSrgb       :: 24;
    RGB10A2Uint          :: 25;
    RGB10A2Unorm         :: 26;
    RG11B10Ufloat        :: 27;
    RGB9E5Ufloat         :: 28;
    RG32Float            :: 29;
    RG32Uint             :: 30;
    RG32Sint             :: 31;
    RGBA16Uint           :: 32;
    RGBA16Sint           :: 33;
    RGBA16Float          :: 34;
    RGBA32Float          :: 35;
    RGBA32Uint           :: 36;
    RGBA32Sint           :: 37;
    Stencil8             :: 38;
    Depth16Unorm         :: 39;
    Depth24Plus          :: 40;
    Depth24PlusStencil8  :: 41;
    Depth32Float         :: 42;
    Depth32FloatStencil8 :: 43;
    BC1RGBAUnorm         :: 44;
    BC1RGBAUnormSrgb     :: 45;
    BC2RGBAUnorm         :: 46;
    BC2RGBAUnormSrgb     :: 47;
    BC3RGBAUnorm         :: 48;
    BC3RGBAUnormSrgb     :: 49;
    BC4RUnorm            :: 50;
    BC4RSnorm            :: 51;
    BC5RGUnorm           :: 52;
    BC5RGSnorm           :: 53;
    BC6HRGBUfloat        :: 54;
    BC6HRGBFloat         :: 55;
    BC7RGBAUnorm         :: 56;
    BC7RGBAUnormSrgb     :: 57;
    ETC2RGB8Unorm        :: 58;
    ETC2RGB8UnormSrgb    :: 59;
    ETC2RGB8A1Unorm      :: 60;
    ETC2RGB8A1UnormSrgb  :: 61;
    ETC2RGBA8Unorm       :: 62;
    ETC2RGBA8UnormSrgb   :: 63;
    EACR11Unorm          :: 64;
    EACR11Snorm          :: 65;
    EACRG11Unorm         :: 66;
    EACRG11Snorm         :: 67;
    ASTC4x4Unorm         :: 68;
    ASTC4x4UnormSrgb     :: 69;
    ASTC5x4Unorm         :: 70;
    ASTC5x4UnormSrgb     :: 71;
    ASTC5x5Unorm         :: 72;
    ASTC5x5UnormSrgb     :: 73;
    ASTC6x5Unorm         :: 74;
    ASTC6x5UnormSrgb     :: 75;
    ASTC6x6Unorm         :: 76;
    ASTC6x6UnormSrgb     :: 77;
    ASTC8x5Unorm         :: 78;
    ASTC8x5UnormSrgb     :: 79;
    ASTC8x6Unorm         :: 80;
    ASTC8x6UnormSrgb     :: 81;
    ASTC8x8Unorm         :: 82;
    ASTC8x8UnormSrgb     :: 83;
    ASTC10x5Unorm        :: 84;
    ASTC10x5UnormSrgb    :: 85;
    ASTC10x6Unorm        :: 86;
    ASTC10x6UnormSrgb    :: 87;
    ASTC10x8Unorm        :: 88;
    ASTC10x8UnormSrgb    :: 89;
    ASTC10x10Unorm       :: 90;
    ASTC10x10UnormSrgb   :: 91;
    ASTC12x10Unorm       :: 92;
    ASTC12x10UnormSrgb   :: 93;
    ASTC12x12Unorm       :: 94;
    ASTC12x12UnormSrgb   :: 95;
    Force32              :: 2147483647;

    WGPUTextureFormat_Undefined            :: Undefined;
    WGPUTextureFormat_R8Unorm              :: R8Unorm;
    WGPUTextureFormat_R8Snorm              :: R8Snorm;
    WGPUTextureFormat_R8Uint               :: R8Uint;
    WGPUTextureFormat_R8Sint               :: R8Sint;
    WGPUTextureFormat_R16Uint              :: R16Uint;
    WGPUTextureFormat_R16Sint              :: R16Sint;
    WGPUTextureFormat_R16Float             :: R16Float;
    WGPUTextureFormat_RG8Unorm             :: RG8Unorm;
    WGPUTextureFormat_RG8Snorm             :: RG8Snorm;
    WGPUTextureFormat_RG8Uint              :: RG8Uint;
    WGPUTextureFormat_RG8Sint              :: RG8Sint;
    WGPUTextureFormat_R32Float             :: R32Float;
    WGPUTextureFormat_R32Uint              :: R32Uint;
    WGPUTextureFormat_R32Sint              :: R32Sint;
    WGPUTextureFormat_RG16Uint             :: RG16Uint;
    WGPUTextureFormat_RG16Sint             :: RG16Sint;
    WGPUTextureFormat_RG16Float            :: RG16Float;
    WGPUTextureFormat_RGBA8Unorm           :: RGBA8Unorm;
    WGPUTextureFormat_RGBA8UnormSrgb       :: RGBA8UnormSrgb;
    WGPUTextureFormat_RGBA8Snorm           :: RGBA8Snorm;
    WGPUTextureFormat_RGBA8Uint            :: RGBA8Uint;
    WGPUTextureFormat_RGBA8Sint            :: RGBA8Sint;
    WGPUTextureFormat_BGRA8Unorm           :: BGRA8Unorm;
    WGPUTextureFormat_BGRA8UnormSrgb       :: BGRA8UnormSrgb;
    WGPUTextureFormat_RGB10A2Uint          :: RGB10A2Uint;
    WGPUTextureFormat_RGB10A2Unorm         :: RGB10A2Unorm;
    WGPUTextureFormat_RG11B10Ufloat        :: RG11B10Ufloat;
    WGPUTextureFormat_RGB9E5Ufloat         :: RGB9E5Ufloat;
    WGPUTextureFormat_RG32Float            :: RG32Float;
    WGPUTextureFormat_RG32Uint             :: RG32Uint;
    WGPUTextureFormat_RG32Sint             :: RG32Sint;
    WGPUTextureFormat_RGBA16Uint           :: RGBA16Uint;
    WGPUTextureFormat_RGBA16Sint           :: RGBA16Sint;
    WGPUTextureFormat_RGBA16Float          :: RGBA16Float;
    WGPUTextureFormat_RGBA32Float          :: RGBA32Float;
    WGPUTextureFormat_RGBA32Uint           :: RGBA32Uint;
    WGPUTextureFormat_RGBA32Sint           :: RGBA32Sint;
    WGPUTextureFormat_Stencil8             :: Stencil8;
    WGPUTextureFormat_Depth16Unorm         :: Depth16Unorm;
    WGPUTextureFormat_Depth24Plus          :: Depth24Plus;
    WGPUTextureFormat_Depth24PlusStencil8  :: Depth24PlusStencil8;
    WGPUTextureFormat_Depth32Float         :: Depth32Float;
    WGPUTextureFormat_Depth32FloatStencil8 :: Depth32FloatStencil8;
    WGPUTextureFormat_BC1RGBAUnorm         :: BC1RGBAUnorm;
    WGPUTextureFormat_BC1RGBAUnormSrgb     :: BC1RGBAUnormSrgb;
    WGPUTextureFormat_BC2RGBAUnorm         :: BC2RGBAUnorm;
    WGPUTextureFormat_BC2RGBAUnormSrgb     :: BC2RGBAUnormSrgb;
    WGPUTextureFormat_BC3RGBAUnorm         :: BC3RGBAUnorm;
    WGPUTextureFormat_BC3RGBAUnormSrgb     :: BC3RGBAUnormSrgb;
    WGPUTextureFormat_BC4RUnorm            :: BC4RUnorm;
    WGPUTextureFormat_BC4RSnorm            :: BC4RSnorm;
    WGPUTextureFormat_BC5RGUnorm           :: BC5RGUnorm;
    WGPUTextureFormat_BC5RGSnorm           :: BC5RGSnorm;
    WGPUTextureFormat_BC6HRGBUfloat        :: BC6HRGBUfloat;
    WGPUTextureFormat_BC6HRGBFloat         :: BC6HRGBFloat;
    WGPUTextureFormat_BC7RGBAUnorm         :: BC7RGBAUnorm;
    WGPUTextureFormat_BC7RGBAUnormSrgb     :: BC7RGBAUnormSrgb;
    WGPUTextureFormat_ETC2RGB8Unorm        :: ETC2RGB8Unorm;
    WGPUTextureFormat_ETC2RGB8UnormSrgb    :: ETC2RGB8UnormSrgb;
    WGPUTextureFormat_ETC2RGB8A1Unorm      :: ETC2RGB8A1Unorm;
    WGPUTextureFormat_ETC2RGB8A1UnormSrgb  :: ETC2RGB8A1UnormSrgb;
    WGPUTextureFormat_ETC2RGBA8Unorm       :: ETC2RGBA8Unorm;
    WGPUTextureFormat_ETC2RGBA8UnormSrgb   :: ETC2RGBA8UnormSrgb;
    WGPUTextureFormat_EACR11Unorm          :: EACR11Unorm;
    WGPUTextureFormat_EACR11Snorm          :: EACR11Snorm;
    WGPUTextureFormat_EACRG11Unorm         :: EACRG11Unorm;
    WGPUTextureFormat_EACRG11Snorm         :: EACRG11Snorm;
    WGPUTextureFormat_ASTC4x4Unorm         :: ASTC4x4Unorm;
    WGPUTextureFormat_ASTC4x4UnormSrgb     :: ASTC4x4UnormSrgb;
    WGPUTextureFormat_ASTC5x4Unorm         :: ASTC5x4Unorm;
    WGPUTextureFormat_ASTC5x4UnormSrgb     :: ASTC5x4UnormSrgb;
    WGPUTextureFormat_ASTC5x5Unorm         :: ASTC5x5Unorm;
    WGPUTextureFormat_ASTC5x5UnormSrgb     :: ASTC5x5UnormSrgb;
    WGPUTextureFormat_ASTC6x5Unorm         :: ASTC6x5Unorm;
    WGPUTextureFormat_ASTC6x5UnormSrgb     :: ASTC6x5UnormSrgb;
    WGPUTextureFormat_ASTC6x6Unorm         :: ASTC6x6Unorm;
    WGPUTextureFormat_ASTC6x6UnormSrgb     :: ASTC6x6UnormSrgb;
    WGPUTextureFormat_ASTC8x5Unorm         :: ASTC8x5Unorm;
    WGPUTextureFormat_ASTC8x5UnormSrgb     :: ASTC8x5UnormSrgb;
    WGPUTextureFormat_ASTC8x6Unorm         :: ASTC8x6Unorm;
    WGPUTextureFormat_ASTC8x6UnormSrgb     :: ASTC8x6UnormSrgb;
    WGPUTextureFormat_ASTC8x8Unorm         :: ASTC8x8Unorm;
    WGPUTextureFormat_ASTC8x8UnormSrgb     :: ASTC8x8UnormSrgb;
    WGPUTextureFormat_ASTC10x5Unorm        :: ASTC10x5Unorm;
    WGPUTextureFormat_ASTC10x5UnormSrgb    :: ASTC10x5UnormSrgb;
    WGPUTextureFormat_ASTC10x6Unorm        :: ASTC10x6Unorm;
    WGPUTextureFormat_ASTC10x6UnormSrgb    :: ASTC10x6UnormSrgb;
    WGPUTextureFormat_ASTC10x8Unorm        :: ASTC10x8Unorm;
    WGPUTextureFormat_ASTC10x8UnormSrgb    :: ASTC10x8UnormSrgb;
    WGPUTextureFormat_ASTC10x10Unorm       :: ASTC10x10Unorm;
    WGPUTextureFormat_ASTC10x10UnormSrgb   :: ASTC10x10UnormSrgb;
    WGPUTextureFormat_ASTC12x10Unorm       :: ASTC12x10Unorm;
    WGPUTextureFormat_ASTC12x10UnormSrgb   :: ASTC12x10UnormSrgb;
    WGPUTextureFormat_ASTC12x12Unorm       :: ASTC12x12Unorm;
    WGPUTextureFormat_ASTC12x12UnormSrgb   :: ASTC12x12UnormSrgb;
    WGPUTextureFormat_Force32              :: Force32;
}

TextureSampleType :: enum u32 {
    BindingNotUsed    :: 0;

    Undefined         :: 1;
    Float             :: 2;
    UnfilterableFloat :: 3;
    Depth             :: 4;
    Sint              :: 5;
    Uint              :: 6;
    Force32           :: 2147483647;

    WGPUTextureSampleType_BindingNotUsed    :: BindingNotUsed;

    WGPUTextureSampleType_Undefined         :: Undefined;
    WGPUTextureSampleType_Float             :: Float;
    WGPUTextureSampleType_UnfilterableFloat :: UnfilterableFloat;
    WGPUTextureSampleType_Depth             :: Depth;
    WGPUTextureSampleType_Sint              :: Sint;
    WGPUTextureSampleType_Uint              :: Uint;
    WGPUTextureSampleType_Force32           :: Force32;
}

TextureViewDimension :: enum u32 {
    Undefined :: 0;
    _1D       :: 1;
    _2D       :: 2;
    _2DArray  :: 3;
    Cube      :: 4;
    CubeArray :: 5;
    _3D       :: 6;
    Force32   :: 2147483647;

    WGPUTextureViewDimension_Undefined :: Undefined;
    WGPUTextureViewDimension_1D        :: _1D;
    WGPUTextureViewDimension_2D        :: _2D;
    WGPUTextureViewDimension_2DArray   :: _2DArray;
    WGPUTextureViewDimension_Cube      :: Cube;
    WGPUTextureViewDimension_CubeArray :: CubeArray;
    WGPUTextureViewDimension_3D        :: _3D;
    WGPUTextureViewDimension_Force32   :: Force32;
}

VertexFormat :: enum u32 {
    Uint8           :: 1;
    Uint8x2         :: 2;
    Uint8x4         :: 3;
    Sint8           :: 4;
    Sint8x2         :: 5;
    Sint8x4         :: 6;
    Unorm8          :: 7;
    Unorm8x2        :: 8;
    Unorm8x4        :: 9;
    Snorm8          :: 10;
    Snorm8x2        :: 11;
    Snorm8x4        :: 12;
    Uint16          :: 13;
    Uint16x2        :: 14;
    Uint16x4        :: 15;
    Sint16          :: 16;
    Sint16x2        :: 17;
    Sint16x4        :: 18;
    Unorm16         :: 19;
    Unorm16x2       :: 20;
    Unorm16x4       :: 21;
    Snorm16         :: 22;
    Snorm16x2       :: 23;
    Snorm16x4       :: 24;
    Float16         :: 25;
    Float16x2       :: 26;
    Float16x4       :: 27;
    Float32         :: 28;
    Float32x2       :: 29;
    Float32x3       :: 30;
    Float32x4       :: 31;
    Uint32          :: 32;
    Uint32x2        :: 33;
    Uint32x3        :: 34;
    Uint32x4        :: 35;
    Sint32          :: 36;
    Sint32x2        :: 37;
    Sint32x3        :: 38;
    Sint32x4        :: 39;
    Unorm10_10_10_2 :: 40;
    Unorm8x4BGRA    :: 41;
    Force32         :: 2147483647;

    WGPUVertexFormat_Uint8           :: Uint8;
    WGPUVertexFormat_Uint8x2         :: Uint8x2;
    WGPUVertexFormat_Uint8x4         :: Uint8x4;
    WGPUVertexFormat_Sint8           :: Sint8;
    WGPUVertexFormat_Sint8x2         :: Sint8x2;
    WGPUVertexFormat_Sint8x4         :: Sint8x4;
    WGPUVertexFormat_Unorm8          :: Unorm8;
    WGPUVertexFormat_Unorm8x2        :: Unorm8x2;
    WGPUVertexFormat_Unorm8x4        :: Unorm8x4;
    WGPUVertexFormat_Snorm8          :: Snorm8;
    WGPUVertexFormat_Snorm8x2        :: Snorm8x2;
    WGPUVertexFormat_Snorm8x4        :: Snorm8x4;
    WGPUVertexFormat_Uint16          :: Uint16;
    WGPUVertexFormat_Uint16x2        :: Uint16x2;
    WGPUVertexFormat_Uint16x4        :: Uint16x4;
    WGPUVertexFormat_Sint16          :: Sint16;
    WGPUVertexFormat_Sint16x2        :: Sint16x2;
    WGPUVertexFormat_Sint16x4        :: Sint16x4;
    WGPUVertexFormat_Unorm16         :: Unorm16;
    WGPUVertexFormat_Unorm16x2       :: Unorm16x2;
    WGPUVertexFormat_Unorm16x4       :: Unorm16x4;
    WGPUVertexFormat_Snorm16         :: Snorm16;
    WGPUVertexFormat_Snorm16x2       :: Snorm16x2;
    WGPUVertexFormat_Snorm16x4       :: Snorm16x4;
    WGPUVertexFormat_Float16         :: Float16;
    WGPUVertexFormat_Float16x2       :: Float16x2;
    WGPUVertexFormat_Float16x4       :: Float16x4;
    WGPUVertexFormat_Float32         :: Float32;
    WGPUVertexFormat_Float32x2       :: Float32x2;
    WGPUVertexFormat_Float32x3       :: Float32x3;
    WGPUVertexFormat_Float32x4       :: Float32x4;
    WGPUVertexFormat_Uint32          :: Uint32;
    WGPUVertexFormat_Uint32x2        :: Uint32x2;
    WGPUVertexFormat_Uint32x3        :: Uint32x3;
    WGPUVertexFormat_Uint32x4        :: Uint32x4;
    WGPUVertexFormat_Sint32          :: Sint32;
    WGPUVertexFormat_Sint32x2        :: Sint32x2;
    WGPUVertexFormat_Sint32x3        :: Sint32x3;
    WGPUVertexFormat_Sint32x4        :: Sint32x4;
    WGPUVertexFormat_Unorm10_10_10_2 :: Unorm10_10_10_2;
    WGPUVertexFormat_Unorm8x4BGRA    :: Unorm8x4BGRA;
    WGPUVertexFormat_Force32         :: Force32;
}

VertexStepMode :: enum u32 {
    VertexBufferNotUsed :: 0;

    Undefined           :: 1;
    Vertex              :: 2;
    Instance            :: 3;
    Force32             :: 2147483647;

    WGPUVertexStepMode_VertexBufferNotUsed :: VertexBufferNotUsed;

    WGPUVertexStepMode_Undefined           :: Undefined;
    WGPUVertexStepMode_Vertex              :: Vertex;
    WGPUVertexStepMode_Instance            :: Instance;
    WGPUVertexStepMode_Force32             :: Force32;
}

WGSLLanguageFeatureName :: enum u32 {
    ReadonlyAndReadwriteStorageTextures :: 1;
    Packed4x8IntegerDotProduct          :: 2;
    UnrestrictedPointerParameters       :: 3;
    PointerCompositeAccess              :: 4;
    Force32                             :: 2147483647;

    WGPUWGSLLanguageFeatureName_ReadonlyAndReadwriteStorageTextures :: ReadonlyAndReadwriteStorageTextures;
    WGPUWGSLLanguageFeatureName_Packed4x8IntegerDotProduct          :: Packed4x8IntegerDotProduct;
    WGPUWGSLLanguageFeatureName_UnrestrictedPointerParameters       :: UnrestrictedPointerParameters;
    WGPUWGSLLanguageFeatureName_PointerCompositeAccess              :: PointerCompositeAccess;
    WGPUWGSLLanguageFeatureName_Force32                             :: Force32;
}

/**
* Status returned from a call to ::wgpuInstanceWaitAny.
*/
WaitStatus :: enum u32 {
    Success                 :: 1;

    TimedOut                :: 2;

    UnsupportedTimeout      :: 3;

    UnsupportedCount        :: 4;

    UnsupportedMixedSources :: 5;
    Force32                 :: 2147483647;

    WGPUWaitStatus_Success                 :: Success;

    WGPUWaitStatus_TimedOut                :: TimedOut;

    WGPUWaitStatus_UnsupportedTimeout      :: UnsupportedTimeout;

    WGPUWaitStatus_UnsupportedCount        :: UnsupportedCount;

    WGPUWaitStatus_UnsupportedMixedSources :: UnsupportedMixedSources;
    WGPUWaitStatus_Force32                 :: Force32;
}

/**
* \defgroup Bitflags
* \brief Type and constant definitions for bitflag types.
*
* @{
*/
BufferUsage :: Flags;
WGPUBufferUsage_None: BufferUsage : 0;
WGPUBufferUsage_MapRead: BufferUsage : 1;
WGPUBufferUsage_MapWrite: BufferUsage : 2;
WGPUBufferUsage_CopySrc: BufferUsage : 4;
WGPUBufferUsage_CopyDst: BufferUsage : 8;
WGPUBufferUsage_Index: BufferUsage : 16;
WGPUBufferUsage_Vertex: BufferUsage : 32;
WGPUBufferUsage_Uniform: BufferUsage : 64;
WGPUBufferUsage_Storage: BufferUsage : 128;
WGPUBufferUsage_Indirect: BufferUsage : 256;
WGPUBufferUsage_QueryResolve: BufferUsage : 512;

ColorWriteMask :: Flags;
WGPUColorWriteMask_None: ColorWriteMask : 0;
WGPUColorWriteMask_Red: ColorWriteMask : 1;
WGPUColorWriteMask_Green: ColorWriteMask : 2;
WGPUColorWriteMask_Blue: ColorWriteMask : 4;
WGPUColorWriteMask_Alpha: ColorWriteMask : 8;
WGPUColorWriteMask_All: ColorWriteMask : 15; /* Red | Green | Blue | Alpha */

MapMode :: Flags;
WGPUMapMode_None: MapMode : 0;
WGPUMapMode_Read: MapMode : 1;
WGPUMapMode_Write: MapMode : 2;

ShaderStage :: Flags;
WGPUShaderStage_None: ShaderStage : 0;
WGPUShaderStage_Vertex: ShaderStage : 1;
WGPUShaderStage_Fragment: ShaderStage : 2;
WGPUShaderStage_Compute: ShaderStage : 4;

TextureUsage :: Flags;
WGPUTextureUsage_None: TextureUsage : 0;
WGPUTextureUsage_CopySrc: TextureUsage : 1;
WGPUTextureUsage_CopyDst: TextureUsage : 2;
WGPUTextureUsage_TextureBinding: TextureUsage : 4;
WGPUTextureUsage_StorageBinding: TextureUsage : 8;
WGPUTextureUsage_RenderAttachment: TextureUsage : 16;

/** @} */
Proc :: #type () -> void #c_call;

/**
* \defgroup Callbacks
* \brief Callbacks through which asynchronous functions return.
*
* @{
*/
/**
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
BufferMapCallback :: #type (status: MapAsyncStatus, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param compilationInfo
* This parameter is @ref PassedWithoutOwnership.
*/
CompilationInfoCallback :: #type (status: CompilationInfoRequestStatus, compilationInfo: *CompilationInfo, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param pipeline
* This parameter is @ref PassedWithOwnership.
*/
CreateComputePipelineAsyncCallback :: #type (status: CreatePipelineAsyncStatus, pipeline: ComputePipeline, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param pipeline
* This parameter is @ref PassedWithOwnership.
*/
CreateRenderPipelineAsyncCallback :: #type (status: CreatePipelineAsyncStatus, pipeline: RenderPipeline, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param device
* Reference to the device which was lost. If, and only if, the `reason` is @ref WGPUDeviceLostReason_FailedCreation, this is a non-null pointer to a null @ref WGPUDevice.
* This parameter is @ref PassedWithoutOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
DeviceLostCallback :: #type (device: *Device, reason: DeviceLostReason, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param status
* See @ref WGPUPopErrorScopeStatus.
*
* @param type
* The type of the error caught by the scope, or @ref WGPUErrorType_NoError if there was none.
* If the `status` is not @ref WGPUPopErrorScopeStatus_Success, this is @ref WGPUErrorType_NoError.
*
* @param message
* If the `type` is not @ref WGPUErrorType_NoError, this is a non-empty @ref LocalizableHumanReadableMessageString;
* otherwise, this is an empty string.
* This parameter is @ref PassedWithoutOwnership.
*/
PopErrorScopeCallback :: #type (status: PopErrorScopeStatus, type: ErrorType, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;
QueueWorkDoneCallback :: #type (status: QueueWorkDoneStatus, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param adapter
* This parameter is @ref PassedWithOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
RequestAdapterCallback :: #type (status: RequestAdapterStatus, adapter: Adapter, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param device
* This parameter is @ref PassedWithOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
RequestDeviceCallback :: #type (status: RequestDeviceStatus, device: Device, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;

/**
* @param device
* This parameter is @ref PassedWithoutOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
UncapturedErrorCallback :: #type (device: *Device, type: ErrorType, message: StringView, userdata1: *void, userdata2: *void) -> void #c_call;

/** @} */
/**
* \defgroup ChainedStructures Chained Structures
* \brief Structures used to extend descriptors.
*
* @{
*/
ChainedStruct :: struct {
    next:  *ChainedStruct;
    sType: SType;
}

ChainedStructOut :: struct {
    next:  *ChainedStructOut;
    sType: SType;
}

// Callback info structure forward declarations
BufferMapCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    BufferMapCallback;
    userdata1:   *void;
    userdata2:   *void;
}

CompilationInfoCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    CompilationInfoCallback;
    userdata1:   *void;
    userdata2:   *void;
}

CreateComputePipelineAsyncCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    CreateComputePipelineAsyncCallback;
    userdata1:   *void;
    userdata2:   *void;
}

CreateRenderPipelineAsyncCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    CreateRenderPipelineAsyncCallback;
    userdata1:   *void;
    userdata2:   *void;
}

DeviceLostCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    DeviceLostCallback;
    userdata1:   *void;
    userdata2:   *void;
}

PopErrorScopeCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    PopErrorScopeCallback;
    userdata1:   *void;
    userdata2:   *void;
}

QueueWorkDoneCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    QueueWorkDoneCallback;
    userdata1:   *void;
    userdata2:   *void;
}

RequestAdapterCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    RequestAdapterCallback;
    userdata1:   *void;
    userdata2:   *void;
}

RequestDeviceCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    mode:        CallbackMode;
    callback:    RequestDeviceCallback;
    userdata1:   *void;
    userdata2:   *void;
}

UncapturedErrorCallbackInfo :: struct {
    nextInChain: *ChainedStruct;
    callback:    UncapturedErrorCallback;
    userdata1:   *void;
    userdata2:   *void;
}

/** @} */
// Structure forward declarations
AdapterInfo :: struct {
    nextInChain:  *ChainedStructOut;

    /**
    * This is an \ref OutputString.
    */
    vendor:       StringView;

    /**
    * This is an \ref OutputString.
    */
    architecture: StringView;

    /**
    * This is an \ref OutputString.
    */
    device:       StringView;

    /**
    * This is an \ref OutputString.
    */
    description:  StringView;
    backendType:  BackendType;
    adapterType:  AdapterType;
    vendorID:     u32;
    deviceID:     u32;
}

BindGroupEntry :: struct {
    nextInChain: *ChainedStruct;
    binding:     u32;
    buffer:      Buffer;
    offset:      u64;
    size:        u64;
    sampler:     Sampler;
    textureView: TextureView;
}

BlendComponent :: struct {
    operation: BlendOperation;
    srcFactor: BlendFactor;
    dstFactor: BlendFactor;
}

BufferBindingLayout :: struct {
    nextInChain:      *ChainedStruct;
    type:             BufferBindingType;
    hasDynamicOffset: Bool;
    minBindingSize:   u64;
}

BufferDescriptor :: struct {
    nextInChain:      *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:            StringView;
    usage:            BufferUsage;
    size:             u64;
    mappedAtCreation: Bool;
}

Color :: struct {
    r: float64;
    g: float64;
    b: float64;
    a: float64;
}

CommandBufferDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
}

CommandEncoderDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
}

CompilationMessage :: struct {
    nextInChain: *ChainedStruct;

    /**
    * A @ref LocalizableHumanReadableMessageString.
    *
    * This is an \ref OutputString.
    */
    message:     StringView;

    /**
    * Severity level of the message.
    */
    type:        CompilationMessageType;

    /**
    * Line number where the message is attached, starting at 1.
    */
    lineNum:     u64;

    /**
    * Offset in UTF-8 code units (bytes) from the beginning of the line, starting at 1.
    */
    linePos:     u64;

    /**
    * Offset in UTF-8 code units (bytes) from the beginning of the shader code, starting at 0.
    */
    offset:      u64;

    /**
    * Length in UTF-8 code units (bytes) of the span the message corresponds to.
    */
    length:      u64;
}

ComputePassTimestampWrites :: struct {
    querySet:                  QuerySet;
    beginningOfPassWriteIndex: u32;
    endOfPassWriteIndex:       u32;
}

ConstantEntry :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    key:         StringView;
    value:       float64;
}

Extent3D :: struct {
    width:              u32;
    height:             u32;
    depthOrArrayLayers: u32;
}

/**
* Opaque handle to an asynchronous operation. See @ref Asynchronous-Operations for more information.
*/
Future :: struct {
    /**
    * Opaque id of the @ref WGPUFuture
    */
    id: u64;
}

/**
* Features enabled on the WGPUInstance
*/
InstanceCapabilities :: struct {
    /** This struct chain is used as mutable in some places and immutable in others. */
    nextInChain:          *ChainedStructOut;

    /**
    * Enable use of ::wgpuInstanceWaitAny with `timeoutNS > 0`.
    */
    timedWaitAnyEnable:   Bool;

    /**
    * The maximum number @ref WGPUFutureWaitInfo supported in a call to ::wgpuInstanceWaitAny with `timeoutNS > 0`.
    */
    timedWaitAnyMaxCount: u64;
}

Limits :: struct {
    /** This struct chain is used as mutable in some places and immutable in others. */
    nextInChain:                               *ChainedStructOut;
    maxTextureDimension1D:                     u32;
    maxTextureDimension2D:                     u32;
    maxTextureDimension3D:                     u32;
    maxTextureArrayLayers:                     u32;
    maxBindGroups:                             u32;
    maxBindGroupsPlusVertexBuffers:            u32;
    maxBindingsPerBindGroup:                   u32;
    maxDynamicUniformBuffersPerPipelineLayout: u32;
    maxDynamicStorageBuffersPerPipelineLayout: u32;
    maxSampledTexturesPerShaderStage:          u32;
    maxSamplersPerShaderStage:                 u32;
    maxStorageBuffersPerShaderStage:           u32;
    maxStorageTexturesPerShaderStage:          u32;
    maxUniformBuffersPerShaderStage:           u32;
    maxUniformBufferBindingSize:               u64;
    maxStorageBufferBindingSize:               u64;
    minUniformBufferOffsetAlignment:           u32;
    minStorageBufferOffsetAlignment:           u32;
    maxVertexBuffers:                          u32;
    maxBufferSize:                             u64;
    maxVertexAttributes:                       u32;
    maxVertexBufferArrayStride:                u32;
    maxInterStageShaderVariables:              u32;
    maxColorAttachments:                       u32;
    maxColorAttachmentBytesPerSample:          u32;
    maxComputeWorkgroupStorageSize:            u32;
    maxComputeInvocationsPerWorkgroup:         u32;
    maxComputeWorkgroupSizeX:                  u32;
    maxComputeWorkgroupSizeY:                  u32;
    maxComputeWorkgroupSizeZ:                  u32;
    maxComputeWorkgroupsPerDimension:          u32;
}

MultisampleState :: struct {
    nextInChain:            *ChainedStruct;
    count:                  u32;
    mask:                   u32;
    alphaToCoverageEnabled: Bool;
}

Origin3D :: struct {
    x: u32;
    y: u32;
    z: u32;
}

PipelineLayoutDescriptor :: struct {
    nextInChain:          *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:                StringView;
    bindGroupLayoutCount: u64;
    bindGroupLayouts:     *BindGroupLayout;
}

PrimitiveState :: struct {
    nextInChain:      *ChainedStruct;
    topology:         PrimitiveTopology;
    stripIndexFormat: IndexFormat;
    frontFace:        FrontFace;
    cullMode:         CullMode;
    unclippedDepth:   Bool;
}

QuerySetDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
    type:        QueryType;
    count:       u32;
}

QueueDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
}

RenderBundleDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
}

RenderBundleEncoderDescriptor :: struct {
    nextInChain:        *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:              StringView;
    colorFormatCount:   u64;
    colorFormats:       *TextureFormat;
    depthStencilFormat: TextureFormat;
    sampleCount:        u32;
    depthReadOnly:      Bool;
    stencilReadOnly:    Bool;
}

RenderPassDepthStencilAttachment :: struct {
    view:              TextureView;
    depthLoadOp:       LoadOp;
    depthStoreOp:      StoreOp;
    depthClearValue:   float;
    depthReadOnly:     Bool;
    stencilLoadOp:     LoadOp;
    stencilStoreOp:    StoreOp;
    stencilClearValue: u32;
    stencilReadOnly:   Bool;
}

RenderPassMaxDrawCount :: struct {
    chain:        ChainedStruct;
    maxDrawCount: u64;
}

RenderPassTimestampWrites :: struct {
    querySet:                  QuerySet;
    beginningOfPassWriteIndex: u32;
    endOfPassWriteIndex:       u32;
}

RequestAdapterOptions :: struct {
    nextInChain:          *ChainedStruct;

    /**
    * "Feature level" for the adapter request. If an adapter is returned, it must support the features and limits in the requested feature level.
    *
    * Implementations may ignore @ref WGPUFeatureLevel_Compatibility and provide @ref WGPUFeatureLevel_Core instead. @ref WGPUFeatureLevel_Core is the default in the JS API, but in C, this field is **required** (must not be undefined).
    */
    featureLevel:         FeatureLevel;
    powerPreference:      PowerPreference;

    /**
    * If true, requires the adapter to be a "fallback" adapter as defined by the JS spec.
    * If this is not possible, the request returns null.
    */
    forceFallbackAdapter: Bool;

    /**
    * If set, requires the adapter to have a particular backend type.
    * If this is not possible, the request returns null.
    */
    backendType:          BackendType;

    /**
    * If set, requires the adapter to be able to output to a particular surface.
    * If this is not possible, the request returns null.
    */
    compatibleSurface:    Surface;
}

SamplerBindingLayout :: struct {
    nextInChain: *ChainedStruct;
    type:        SamplerBindingType;
}

SamplerDescriptor :: struct {
    nextInChain:   *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:         StringView;
    addressModeU:  AddressMode;
    addressModeV:  AddressMode;
    addressModeW:  AddressMode;
    magFilter:     FilterMode;
    minFilter:     FilterMode;
    mipmapFilter:  MipmapFilterMode;
    lodMinClamp:   float;
    lodMaxClamp:   float;
    compare:       CompareFunction;
    maxAnisotropy: u16;
}

ShaderModuleDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
}

ShaderSourceSPIRV :: struct {
    chain:    ChainedStruct;
    codeSize: u32;
    code:     *u32;
}

ShaderSourceWGSL :: struct {
    chain: ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    code:  StringView;
}

StencilFaceState :: struct {
    compare:     CompareFunction;
    failOp:      StencilOperation;
    depthFailOp: StencilOperation;
    passOp:      StencilOperation;
}

StorageTextureBindingLayout :: struct {
    nextInChain:   *ChainedStruct;
    access:        StorageTextureAccess;
    format:        TextureFormat;
    viewDimension: TextureViewDimension;
}

SupportedFeatures :: struct {
    featureCount: u64;
    features:     *FeatureName;
}

SupportedWGSLLanguageFeatures :: struct {
    featureCount: u64;
    features:     *WGSLLanguageFeatureName;
}

/**
* Filled by `::wgpuSurfaceGetCapabilities` with what's supported for `::wgpuSurfaceConfigure` for a pair of @ref WGPUSurface and @ref WGPUAdapter.
*/
SurfaceCapabilities :: struct {
    nextInChain:      *ChainedStructOut;

    /**
    * The bit set of supported @ref WGPUTextureUsage bits.
    * Guaranteed to contain @ref WGPUTextureUsage_RenderAttachment.
    */
    usages:           TextureUsage;

    /**
    * A list of supported @ref WGPUTextureFormat values, in order of preference.
    */
    formatCount:      u64;
    formats:          *TextureFormat;

    /**
    * A list of supported @ref WGPUPresentMode values.
    * Guaranteed to contain @ref WGPUPresentMode_Fifo.
    */
    presentModeCount: u64;
    presentModes:     *PresentMode;

    /**
    * A list of supported @ref WGPUCompositeAlphaMode values.
    * @ref WGPUCompositeAlphaMode_Auto will be an alias for the first element and will never be present in this array.
    */
    alphaModeCount:   u64;
    alphaModes:       *CompositeAlphaMode;
}

/**
* Options to `::wgpuSurfaceConfigure` for defining how a @ref WGPUSurface will be rendered to and presented to the user.
* See @ref Surface-Configuration for more details.
*/
SurfaceConfiguration :: struct {
    nextInChain:     *ChainedStruct;

    /**
    * The @ref WGPUDevice to use to render to surface's textures.
    */
    device:          Device;

    /**
    * The @ref WGPUTextureFormat of the surface's textures.
    */
    format:          TextureFormat;

    /**
    * The @ref WGPUTextureUsage of the surface's textures.
    */
    usage:           TextureUsage;

    /**
    * The width of the surface's textures.
    */
    width:           u32;

    /**
    * The height of the surface's textures.
    */
    height:          u32;

    /**
    * The additional @ref WGPUTextureFormat for @ref WGPUTextureView format reinterpretation of the surface's textures.
    */
    viewFormatCount: u64;
    viewFormats:     *TextureFormat;

    /**
    * How the surface's frames will be composited on the screen.
    */
    alphaMode:       CompositeAlphaMode;

    /**
    * When and in which order the surface's frames will be shown on the screen. Defaults to @ref WGPUPresentMode_Fifo.
    */
    presentMode:     PresentMode;
}

/**
* The root descriptor for the creation of an @ref WGPUSurface with `::wgpuInstanceCreateSurface`.
* It isn't sufficient by itself and must have one of the `WGPUSurfaceSource*` in its chain.
* See @ref Surface-Creation for more details.
*/
SurfaceDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * Label used to refer to the object.
    *
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an Android [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window).
*/
SurfaceSourceAndroidNativeWindow :: struct {
    chain:  ChainedStruct;

    /**
    * The pointer to the [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window) that will be wrapped by the @ref WGPUSurface.
    */
    window: *void;
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc).
*/
SurfaceSourceMetalLayer :: struct {
    chain: ChainedStruct;

    /**
    * The pointer to the [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc) that will be wrapped by the @ref WGPUSurface.
    */
    layer: *void;
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [Wayland](https://wayland.freedesktop.org/) [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface).
*/
SurfaceSourceWaylandSurface :: struct {
    chain:   ChainedStruct;

    /**
    * A [`wl_display`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_display) for this Wayland instance.
    */
    display: *void;

    /**
    * A [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface) that will be wrapped by the @ref WGPUSurface
    */
    surface: *void;
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a Windows [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd).
*/
SurfaceSourceWindowsHWND :: struct {
    chain:     ChainedStruct;

    /**
    * The [`HINSTANCE`](https://learn.microsoft.com/en-us/windows/win32/learnwin32/winmain--the-application-entry-point) for this application.
    * Most commonly `GetModuleHandle(nullptr)`.
    */
    hinstance: *void;

    /**
    * The [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd) that will be wrapped by the @ref WGPUSurface.
    */
    hwnd:      *void;
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [XCB](https://xcb.freedesktop.org/) `xcb_window_t`.
*/
SurfaceSourceXCBWindow :: struct {
    chain:      ChainedStruct;

    /**
    * The `xcb_connection_t` for the connection to the X server.
    */
    connection: *void;

    /**
    * The `xcb_window_t` for the window that will be wrapped by the @ref WGPUSurface.
    */
    window:     u32;
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [Xlib](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html) `Window`.
*/
SurfaceSourceXlibWindow :: struct {
    chain:   ChainedStruct;

    /**
    * A pointer to the [`Display`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Opening_the_Display) connected to the X server.
    */
    display: *void;

    /**
    * The [`Window`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Creating_Windows) that will be wrapped by the @ref WGPUSurface.
    */
    window:  u64;
}

/**
* Queried each frame from a @ref WGPUSurface to get a @ref WGPUTexture to render to along with some metadata.
* See @ref Surface-Presenting for more details.
*/
SurfaceTexture :: struct {
    nextInChain: *ChainedStructOut;

    /**
    * The @ref WGPUTexture representing the frame that will be shown on the surface.
    * It is @ref ReturnedWithOwnership from @ref wgpuSurfaceGetCurrentTexture.
    */
    texture:     Texture;

    /**
    * Whether the call to `::wgpuSurfaceGetCurrentTexture` succeeded and a hint as to why it might not have.
    */
    status:      SurfaceGetCurrentTextureStatus;
}

TexelCopyBufferLayout :: struct {
    offset:       u64;
    bytesPerRow:  u32;
    rowsPerImage: u32;
}

TextureBindingLayout :: struct {
    nextInChain:   *ChainedStruct;
    sampleType:    TextureSampleType;
    viewDimension: TextureViewDimension;
    multisampled:  Bool;
}

TextureViewDescriptor :: struct {
    nextInChain:     *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:           StringView;
    format:          TextureFormat;
    dimension:       TextureViewDimension;
    baseMipLevel:    u32;
    mipLevelCount:   u32;
    baseArrayLayer:  u32;
    arrayLayerCount: u32;
    aspect:          TextureAspect;
    usage:           TextureUsage;
}

VertexAttribute :: struct {
    format:         VertexFormat;
    offset:         u64;
    shaderLocation: u32;
}

BindGroupDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
    layout:      BindGroupLayout;
    entryCount:  u64;
    entries:     *BindGroupEntry;
}

BindGroupLayoutEntry :: struct {
    nextInChain:    *ChainedStruct;
    binding:        u32;
    visibility:     ShaderStage;
    buffer:         BufferBindingLayout;
    sampler:        SamplerBindingLayout;
    texture:        TextureBindingLayout;
    storageTexture: StorageTextureBindingLayout;
}

BlendState :: struct {
    color: BlendComponent;
    alpha: BlendComponent;
}

CompilationInfo :: struct {
    nextInChain:  *ChainedStruct;
    messageCount: u64;
    messages:     *CompilationMessage;
}

ComputePassDescriptor :: struct {
    nextInChain:     *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:           StringView;
    timestampWrites: *ComputePassTimestampWrites;
}

DepthStencilState :: struct {
    nextInChain:         *ChainedStruct;
    format:              TextureFormat;
    depthWriteEnabled:   OptionalBool;
    depthCompare:        CompareFunction;
    stencilFront:        StencilFaceState;
    stencilBack:         StencilFaceState;
    stencilReadMask:     u32;
    stencilWriteMask:    u32;
    depthBias:           s32;
    depthBiasSlopeScale: float;
    depthBiasClamp:      float;
}

DeviceDescriptor :: struct {
    nextInChain:                 *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:                       StringView;
    requiredFeatureCount:        u64;
    requiredFeatures:            *FeatureName;
    requiredLimits:              *Limits;
    defaultQueue:                QueueDescriptor;
    deviceLostCallbackInfo:      DeviceLostCallbackInfo;
    uncapturedErrorCallbackInfo: UncapturedErrorCallbackInfo;
}

/**
* Struct holding a future to wait on, and a `completed` boolean flag.
*/
FutureWaitInfo :: struct {
    /**
    * The future to wait on.
    */
    future:    Future;

    /**
    * Whether or not the future completed.
    */
    completed: Bool;
}

InstanceDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * Instance features to enable
    */
    features:    InstanceCapabilities;
}

ProgrammableStageDescriptor :: struct {
    nextInChain:   *ChainedStruct;
    module:        ShaderModule;

    /**
    * This is a \ref NullableInputString.
    */
    entryPoint:    StringView;
    constantCount: u64;
    constants:     *ConstantEntry;
}

RenderPassColorAttachment :: struct {
    nextInChain:   *ChainedStruct;
    view:          TextureView;
    depthSlice:    u32;
    resolveTarget: TextureView;
    loadOp:        LoadOp;
    storeOp:       StoreOp;
    clearValue:    Color;
}

TexelCopyBufferInfo :: struct {
    layout: TexelCopyBufferLayout;
    buffer: Buffer;
}

TexelCopyTextureInfo :: struct {
    texture:  Texture;
    mipLevel: u32;
    origin:   Origin3D;
    aspect:   TextureAspect;
}

TextureDescriptor :: struct {
    nextInChain:     *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:           StringView;
    usage:           TextureUsage;
    dimension:       TextureDimension;
    size:            Extent3D;
    format:          TextureFormat;
    mipLevelCount:   u32;
    sampleCount:     u32;
    viewFormatCount: u64;
    viewFormats:     *TextureFormat;
}

VertexBufferLayout :: struct {
    /**
    * The step mode for the vertex buffer. If @ref WGPUVertexStepMode_VertexBufferNotUsed,
    * indicates a "hole" in the parent @ref WGPUVertexState `buffers` array:
    * the pipeline does not use a vertex buffer at this `location`.
    */
    stepMode:       VertexStepMode;
    arrayStride:    u64;
    attributeCount: u64;
    attributes:     *VertexAttribute;
}

BindGroupLayoutDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
    entryCount:  u64;
    entries:     *BindGroupLayoutEntry;
}

ColorTargetState :: struct {
    nextInChain: *ChainedStruct;

    /**
    * The texture format of the target. If @ref WGPUTextureFormat_Undefined,
    * indicates a "hole" in the parent @ref WGPUFragmentState `targets` array:
    * the pipeline does not output a value at this `location`.
    */
    format:      TextureFormat;
    blend:       *BlendState;
    writeMask:   ColorWriteMask;
}

ComputePipelineDescriptor :: struct {
    nextInChain: *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:       StringView;
    layout:      PipelineLayout;
    compute:     ProgrammableStageDescriptor;
}

RenderPassDescriptor :: struct {
    nextInChain:            *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:                  StringView;
    colorAttachmentCount:   u64;
    colorAttachments:       *RenderPassColorAttachment;
    depthStencilAttachment: *RenderPassDepthStencilAttachment;
    occlusionQuerySet:      QuerySet;
    timestampWrites:        *RenderPassTimestampWrites;
}

VertexState :: struct {
    nextInChain:   *ChainedStruct;
    module:        ShaderModule;

    /**
    * This is a \ref NullableInputString.
    */
    entryPoint:    StringView;
    constantCount: u64;
    constants:     *ConstantEntry;
    bufferCount:   u64;
    buffers:       *VertexBufferLayout;
}

FragmentState :: struct {
    nextInChain:   *ChainedStruct;
    module:        ShaderModule;

    /**
    * This is a \ref NullableInputString.
    */
    entryPoint:    StringView;
    constantCount: u64;
    constants:     *ConstantEntry;
    targetCount:   u64;
    targets:       *ColorTargetState;
}

RenderPipelineDescriptor :: struct {
    nextInChain:  *ChainedStruct;

    /**
    * This is a \ref NonNullInputString.
    */
    label:        StringView;
    layout:       PipelineLayout;
    vertex:       VertexState;
    primitive:    PrimitiveState;
    depthStencil: *DepthStencilState;
    multisample:  MultisampleState;
    fragment:     *FragmentState;
}

/**
* Proc pointer type for @ref wgpuCreateInstance:
* > @copydoc wgpuCreateInstance
*/
ProcCreateInstance :: #type (descriptor: *InstanceDescriptor) -> Instance #c_call;

/**
* Proc pointer type for @ref wgpuGetInstanceCapabilities:
* > @copydoc wgpuGetInstanceCapabilities
*/
ProcGetInstanceCapabilities :: #type (capabilities: *InstanceCapabilities) -> Status #c_call;

/**
* Proc pointer type for @ref wgpuGetProcAddress:
* > @copydoc wgpuGetProcAddress
*/
ProcGetProcAddress :: #type (procName: StringView) -> Proc #c_call;

// Procs of Adapter
/**
* Proc pointer type for @ref wgpuAdapterGetFeatures:
* > @copydoc wgpuAdapterGetFeatures
*/
ProcAdapterGetFeatures :: #type (adapter: Adapter, features: *SupportedFeatures) -> void #c_call;

/**
* Proc pointer type for @ref wgpuAdapterGetInfo:
* > @copydoc wgpuAdapterGetInfo
*/
ProcAdapterGetInfo :: #type (adapter: Adapter, info: *AdapterInfo) -> Status #c_call;

/**
* Proc pointer type for @ref wgpuAdapterGetLimits:
* > @copydoc wgpuAdapterGetLimits
*/
ProcAdapterGetLimits :: #type (adapter: Adapter, limits: *Limits) -> Status #c_call;

/**
* Proc pointer type for @ref wgpuAdapterHasFeature:
* > @copydoc wgpuAdapterHasFeature
*/
ProcAdapterHasFeature :: #type (adapter: Adapter, feature: FeatureName) -> Bool #c_call;

/**
* Proc pointer type for @ref wgpuAdapterRequestDevice:
* > @copydoc wgpuAdapterRequestDevice
*/
ProcAdapterRequestDevice :: #type (adapter: Adapter, descriptor: *DeviceDescriptor, callbackInfo: RequestDeviceCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuAdapterAddRef.
* > @copydoc wgpuAdapterAddRef
*/
ProcAdapterAddRef :: #type (adapter: Adapter) -> void #c_call;

/**
* Proc pointer type for @ref wgpuAdapterRelease.
* > @copydoc wgpuAdapterRelease
*/
ProcAdapterRelease :: #type (adapter: Adapter) -> void #c_call;

// Procs of AdapterInfo
/**
* Proc pointer type for @ref wgpuAdapterInfoFreeMembers:
* > @copydoc wgpuAdapterInfoFreeMembers
*/
ProcAdapterInfoFreeMembers :: #type (adapterInfo: AdapterInfo) -> void #c_call;

// Procs of BindGroup
/**
* Proc pointer type for @ref wgpuBindGroupSetLabel:
* > @copydoc wgpuBindGroupSetLabel
*/
ProcBindGroupSetLabel :: #type (bindGroup: BindGroup, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBindGroupAddRef.
* > @copydoc wgpuBindGroupAddRef
*/
ProcBindGroupAddRef :: #type (bindGroup: BindGroup) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBindGroupRelease.
* > @copydoc wgpuBindGroupRelease
*/
ProcBindGroupRelease :: #type (bindGroup: BindGroup) -> void #c_call;

// Procs of BindGroupLayout
/**
* Proc pointer type for @ref wgpuBindGroupLayoutSetLabel:
* > @copydoc wgpuBindGroupLayoutSetLabel
*/
ProcBindGroupLayoutSetLabel :: #type (bindGroupLayout: BindGroupLayout, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBindGroupLayoutAddRef.
* > @copydoc wgpuBindGroupLayoutAddRef
*/
ProcBindGroupLayoutAddRef :: #type (bindGroupLayout: BindGroupLayout) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBindGroupLayoutRelease.
* > @copydoc wgpuBindGroupLayoutRelease
*/
ProcBindGroupLayoutRelease :: #type (bindGroupLayout: BindGroupLayout) -> void #c_call;

// Procs of Buffer
/**
* Proc pointer type for @ref wgpuBufferDestroy:
* > @copydoc wgpuBufferDestroy
*/
ProcBufferDestroy :: #type (buffer: Buffer) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBufferGetConstMappedRange:
* > @copydoc wgpuBufferGetConstMappedRange
*/
ProcBufferGetConstMappedRange :: #type (buffer: Buffer, offset: u64, size: u64) -> *void #c_call;

/**
* Proc pointer type for @ref wgpuBufferGetMapState:
* > @copydoc wgpuBufferGetMapState
*/
ProcBufferGetMapState :: #type (buffer: Buffer) -> BufferMapState #c_call;

/**
* Proc pointer type for @ref wgpuBufferGetMappedRange:
* > @copydoc wgpuBufferGetMappedRange
*/
ProcBufferGetMappedRange :: #type (buffer: Buffer, offset: u64, size: u64) -> *void #c_call;

/**
* Proc pointer type for @ref wgpuBufferGetSize:
* > @copydoc wgpuBufferGetSize
*/
ProcBufferGetSize :: #type (buffer: Buffer) -> u64 #c_call;

/**
* Proc pointer type for @ref wgpuBufferGetUsage:
* > @copydoc wgpuBufferGetUsage
*/
ProcBufferGetUsage :: #type (buffer: Buffer) -> BufferUsage #c_call;

/**
* Proc pointer type for @ref wgpuBufferMapAsync:
* > @copydoc wgpuBufferMapAsync
*/
ProcBufferMapAsync :: #type (buffer: Buffer, mode: MapMode, offset: u64, size: u64, callbackInfo: BufferMapCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuBufferSetLabel:
* > @copydoc wgpuBufferSetLabel
*/
ProcBufferSetLabel :: #type (buffer: Buffer, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBufferUnmap:
* > @copydoc wgpuBufferUnmap
*/
ProcBufferUnmap :: #type (buffer: Buffer) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBufferAddRef.
* > @copydoc wgpuBufferAddRef
*/
ProcBufferAddRef :: #type (buffer: Buffer) -> void #c_call;

/**
* Proc pointer type for @ref wgpuBufferRelease.
* > @copydoc wgpuBufferRelease
*/
ProcBufferRelease :: #type (buffer: Buffer) -> void #c_call;

// Procs of CommandBuffer
/**
* Proc pointer type for @ref wgpuCommandBufferSetLabel:
* > @copydoc wgpuCommandBufferSetLabel
*/
ProcCommandBufferSetLabel :: #type (commandBuffer: CommandBuffer, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandBufferAddRef.
* > @copydoc wgpuCommandBufferAddRef
*/
ProcCommandBufferAddRef :: #type (commandBuffer: CommandBuffer) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandBufferRelease.
* > @copydoc wgpuCommandBufferRelease
*/
ProcCommandBufferRelease :: #type (commandBuffer: CommandBuffer) -> void #c_call;

// Procs of CommandEncoder
/**
* Proc pointer type for @ref wgpuCommandEncoderBeginComputePass:
* > @copydoc wgpuCommandEncoderBeginComputePass
*/
ProcCommandEncoderBeginComputePass :: #type (commandEncoder: CommandEncoder, descriptor: *ComputePassDescriptor) -> ComputePassEncoder #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderBeginRenderPass:
* > @copydoc wgpuCommandEncoderBeginRenderPass
*/
ProcCommandEncoderBeginRenderPass :: #type (commandEncoder: CommandEncoder, descriptor: *RenderPassDescriptor) -> RenderPassEncoder #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderClearBuffer:
* > @copydoc wgpuCommandEncoderClearBuffer
*/
ProcCommandEncoderClearBuffer :: #type (commandEncoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyBufferToBuffer:
* > @copydoc wgpuCommandEncoderCopyBufferToBuffer
*/
ProcCommandEncoderCopyBufferToBuffer :: #type (commandEncoder: CommandEncoder, source: Buffer, sourceOffset: u64, destination: Buffer, destinationOffset: u64, size: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyBufferToTexture:
* > @copydoc wgpuCommandEncoderCopyBufferToTexture
*/
ProcCommandEncoderCopyBufferToTexture :: #type (commandEncoder: CommandEncoder, source: *TexelCopyBufferInfo, destination: *TexelCopyTextureInfo, copySize: *Extent3D) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyTextureToBuffer:
* > @copydoc wgpuCommandEncoderCopyTextureToBuffer
*/
ProcCommandEncoderCopyTextureToBuffer :: #type (commandEncoder: CommandEncoder, source: *TexelCopyTextureInfo, destination: *TexelCopyBufferInfo, copySize: *Extent3D) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyTextureToTexture:
* > @copydoc wgpuCommandEncoderCopyTextureToTexture
*/
ProcCommandEncoderCopyTextureToTexture :: #type (commandEncoder: CommandEncoder, source: *TexelCopyTextureInfo, destination: *TexelCopyTextureInfo, copySize: *Extent3D) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderFinish:
* > @copydoc wgpuCommandEncoderFinish
*/
ProcCommandEncoderFinish :: #type (commandEncoder: CommandEncoder, descriptor: *CommandBufferDescriptor) -> CommandBuffer #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderInsertDebugMarker:
* > @copydoc wgpuCommandEncoderInsertDebugMarker
*/
ProcCommandEncoderInsertDebugMarker :: #type (commandEncoder: CommandEncoder, markerLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderPopDebugGroup:
* > @copydoc wgpuCommandEncoderPopDebugGroup
*/
ProcCommandEncoderPopDebugGroup :: #type (commandEncoder: CommandEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderPushDebugGroup:
* > @copydoc wgpuCommandEncoderPushDebugGroup
*/
ProcCommandEncoderPushDebugGroup :: #type (commandEncoder: CommandEncoder, groupLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderResolveQuerySet:
* > @copydoc wgpuCommandEncoderResolveQuerySet
*/
ProcCommandEncoderResolveQuerySet :: #type (commandEncoder: CommandEncoder, querySet: QuerySet, firstQuery: u32, queryCount: u32, destination: Buffer, destinationOffset: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderSetLabel:
* > @copydoc wgpuCommandEncoderSetLabel
*/
ProcCommandEncoderSetLabel :: #type (commandEncoder: CommandEncoder, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderWriteTimestamp:
* > @copydoc wgpuCommandEncoderWriteTimestamp
*/
ProcCommandEncoderWriteTimestamp :: #type (commandEncoder: CommandEncoder, querySet: QuerySet, queryIndex: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderAddRef.
* > @copydoc wgpuCommandEncoderAddRef
*/
ProcCommandEncoderAddRef :: #type (commandEncoder: CommandEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuCommandEncoderRelease.
* > @copydoc wgpuCommandEncoderRelease
*/
ProcCommandEncoderRelease :: #type (commandEncoder: CommandEncoder) -> void #c_call;

// Procs of ComputePassEncoder
/**
* Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroups:
* > @copydoc wgpuComputePassEncoderDispatchWorkgroups
*/
ProcComputePassEncoderDispatchWorkgroups :: #type (computePassEncoder: ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroupsIndirect:
* > @copydoc wgpuComputePassEncoderDispatchWorkgroupsIndirect
*/
ProcComputePassEncoderDispatchWorkgroupsIndirect :: #type (computePassEncoder: ComputePassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderEnd:
* > @copydoc wgpuComputePassEncoderEnd
*/
ProcComputePassEncoderEnd :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderInsertDebugMarker:
* > @copydoc wgpuComputePassEncoderInsertDebugMarker
*/
ProcComputePassEncoderInsertDebugMarker :: #type (computePassEncoder: ComputePassEncoder, markerLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderPopDebugGroup:
* > @copydoc wgpuComputePassEncoderPopDebugGroup
*/
ProcComputePassEncoderPopDebugGroup :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderPushDebugGroup:
* > @copydoc wgpuComputePassEncoderPushDebugGroup
*/
ProcComputePassEncoderPushDebugGroup :: #type (computePassEncoder: ComputePassEncoder, groupLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderSetBindGroup:
* > @copydoc wgpuComputePassEncoderSetBindGroup
*/
ProcComputePassEncoderSetBindGroup :: #type (computePassEncoder: ComputePassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderSetLabel:
* > @copydoc wgpuComputePassEncoderSetLabel
*/
ProcComputePassEncoderSetLabel :: #type (computePassEncoder: ComputePassEncoder, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderSetPipeline:
* > @copydoc wgpuComputePassEncoderSetPipeline
*/
ProcComputePassEncoderSetPipeline :: #type (computePassEncoder: ComputePassEncoder, pipeline: ComputePipeline) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderAddRef.
* > @copydoc wgpuComputePassEncoderAddRef
*/
ProcComputePassEncoderAddRef :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePassEncoderRelease.
* > @copydoc wgpuComputePassEncoderRelease
*/
ProcComputePassEncoderRelease :: #type (computePassEncoder: ComputePassEncoder) -> void #c_call;

// Procs of ComputePipeline
/**
* Proc pointer type for @ref wgpuComputePipelineGetBindGroupLayout:
* > @copydoc wgpuComputePipelineGetBindGroupLayout
*/
ProcComputePipelineGetBindGroupLayout :: #type (computePipeline: ComputePipeline, groupIndex: u32) -> BindGroupLayout #c_call;

/**
* Proc pointer type for @ref wgpuComputePipelineSetLabel:
* > @copydoc wgpuComputePipelineSetLabel
*/
ProcComputePipelineSetLabel :: #type (computePipeline: ComputePipeline, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePipelineAddRef.
* > @copydoc wgpuComputePipelineAddRef
*/
ProcComputePipelineAddRef :: #type (computePipeline: ComputePipeline) -> void #c_call;

/**
* Proc pointer type for @ref wgpuComputePipelineRelease.
* > @copydoc wgpuComputePipelineRelease
*/
ProcComputePipelineRelease :: #type (computePipeline: ComputePipeline) -> void #c_call;

// Procs of Device
/**
* Proc pointer type for @ref wgpuDeviceCreateBindGroup:
* > @copydoc wgpuDeviceCreateBindGroup
*/
ProcDeviceCreateBindGroup :: #type (device: Device, descriptor: *BindGroupDescriptor) -> BindGroup #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateBindGroupLayout:
* > @copydoc wgpuDeviceCreateBindGroupLayout
*/
ProcDeviceCreateBindGroupLayout :: #type (device: Device, descriptor: *BindGroupLayoutDescriptor) -> BindGroupLayout #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateBuffer:
* > @copydoc wgpuDeviceCreateBuffer
*/
ProcDeviceCreateBuffer :: #type (device: Device, descriptor: *BufferDescriptor) -> Buffer #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateCommandEncoder:
* > @copydoc wgpuDeviceCreateCommandEncoder
*/
ProcDeviceCreateCommandEncoder :: #type (device: Device, descriptor: *CommandEncoderDescriptor) -> CommandEncoder #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateComputePipeline:
* > @copydoc wgpuDeviceCreateComputePipeline
*/
ProcDeviceCreateComputePipeline :: #type (device: Device, descriptor: *ComputePipelineDescriptor) -> ComputePipeline #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateComputePipelineAsync:
* > @copydoc wgpuDeviceCreateComputePipelineAsync
*/
ProcDeviceCreateComputePipelineAsync :: #type (device: Device, descriptor: *ComputePipelineDescriptor, callbackInfo: CreateComputePipelineAsyncCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreatePipelineLayout:
* > @copydoc wgpuDeviceCreatePipelineLayout
*/
ProcDeviceCreatePipelineLayout :: #type (device: Device, descriptor: *PipelineLayoutDescriptor) -> PipelineLayout #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateQuerySet:
* > @copydoc wgpuDeviceCreateQuerySet
*/
ProcDeviceCreateQuerySet :: #type (device: Device, descriptor: *QuerySetDescriptor) -> QuerySet #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateRenderBundleEncoder:
* > @copydoc wgpuDeviceCreateRenderBundleEncoder
*/
ProcDeviceCreateRenderBundleEncoder :: #type (device: Device, descriptor: *RenderBundleEncoderDescriptor) -> RenderBundleEncoder #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateRenderPipeline:
* > @copydoc wgpuDeviceCreateRenderPipeline
*/
ProcDeviceCreateRenderPipeline :: #type (device: Device, descriptor: *RenderPipelineDescriptor) -> RenderPipeline #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateRenderPipelineAsync:
* > @copydoc wgpuDeviceCreateRenderPipelineAsync
*/
ProcDeviceCreateRenderPipelineAsync :: #type (device: Device, descriptor: *RenderPipelineDescriptor, callbackInfo: CreateRenderPipelineAsyncCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateSampler:
* > @copydoc wgpuDeviceCreateSampler
*/
ProcDeviceCreateSampler :: #type (device: Device, descriptor: *SamplerDescriptor) -> Sampler #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateShaderModule:
* > @copydoc wgpuDeviceCreateShaderModule
*/
ProcDeviceCreateShaderModule :: #type (device: Device, descriptor: *ShaderModuleDescriptor) -> ShaderModule #c_call;

/**
* Proc pointer type for @ref wgpuDeviceCreateTexture:
* > @copydoc wgpuDeviceCreateTexture
*/
ProcDeviceCreateTexture :: #type (device: Device, descriptor: *TextureDescriptor) -> Texture #c_call;

/**
* Proc pointer type for @ref wgpuDeviceDestroy:
* > @copydoc wgpuDeviceDestroy
*/
ProcDeviceDestroy :: #type (device: Device) -> void #c_call;

/**
* Proc pointer type for @ref wgpuDeviceGetAdapterInfo:
* > @copydoc wgpuDeviceGetAdapterInfo
*/
ProcDeviceGetAdapterInfo :: #type (device: Device) -> AdapterInfo #c_call;

/**
* Proc pointer type for @ref wgpuDeviceGetFeatures:
* > @copydoc wgpuDeviceGetFeatures
*/
ProcDeviceGetFeatures :: #type (device: Device, features: *SupportedFeatures) -> void #c_call;

/**
* Proc pointer type for @ref wgpuDeviceGetLimits:
* > @copydoc wgpuDeviceGetLimits
*/
ProcDeviceGetLimits :: #type (device: Device, limits: *Limits) -> Status #c_call;

/**
* Proc pointer type for @ref wgpuDeviceGetLostFuture:
* > @copydoc wgpuDeviceGetLostFuture
*/
ProcDeviceGetLostFuture :: #type (device: Device) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuDeviceGetQueue:
* > @copydoc wgpuDeviceGetQueue
*/
ProcDeviceGetQueue :: #type (device: Device) -> Queue #c_call;

/**
* Proc pointer type for @ref wgpuDeviceHasFeature:
* > @copydoc wgpuDeviceHasFeature
*/
ProcDeviceHasFeature :: #type (device: Device, feature: FeatureName) -> Bool #c_call;

/**
* Proc pointer type for @ref wgpuDevicePopErrorScope:
* > @copydoc wgpuDevicePopErrorScope
*/
ProcDevicePopErrorScope :: #type (device: Device, callbackInfo: PopErrorScopeCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuDevicePushErrorScope:
* > @copydoc wgpuDevicePushErrorScope
*/
ProcDevicePushErrorScope :: #type (device: Device, filter: ErrorFilter) -> void #c_call;

/**
* Proc pointer type for @ref wgpuDeviceSetLabel:
* > @copydoc wgpuDeviceSetLabel
*/
ProcDeviceSetLabel :: #type (device: Device, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuDeviceAddRef.
* > @copydoc wgpuDeviceAddRef
*/
ProcDeviceAddRef :: #type (device: Device) -> void #c_call;

/**
* Proc pointer type for @ref wgpuDeviceRelease.
* > @copydoc wgpuDeviceRelease
*/
ProcDeviceRelease :: #type (device: Device) -> void #c_call;

// Procs of Instance
/**
* Proc pointer type for @ref wgpuInstanceCreateSurface:
* > @copydoc wgpuInstanceCreateSurface
*/
ProcInstanceCreateSurface :: #type (instance: Instance, descriptor: *SurfaceDescriptor) -> Surface #c_call;

/**
* Proc pointer type for @ref wgpuInstanceGetWGSLLanguageFeatures:
* > @copydoc wgpuInstanceGetWGSLLanguageFeatures
*/
ProcInstanceGetWGSLLanguageFeatures :: #type (instance: Instance, features: *SupportedWGSLLanguageFeatures) -> Status #c_call;

/**
* Proc pointer type for @ref wgpuInstanceHasWGSLLanguageFeature:
* > @copydoc wgpuInstanceHasWGSLLanguageFeature
*/
ProcInstanceHasWGSLLanguageFeature :: #type (instance: Instance, feature: WGSLLanguageFeatureName) -> Bool #c_call;

/**
* Proc pointer type for @ref wgpuInstanceProcessEvents:
* > @copydoc wgpuInstanceProcessEvents
*/
ProcInstanceProcessEvents :: #type (instance: Instance) -> void #c_call;

/**
* Proc pointer type for @ref wgpuInstanceRequestAdapter:
* > @copydoc wgpuInstanceRequestAdapter
*/
ProcInstanceRequestAdapter :: #type (instance: Instance, options: *RequestAdapterOptions, callbackInfo: RequestAdapterCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuInstanceWaitAny:
* > @copydoc wgpuInstanceWaitAny
*/
ProcInstanceWaitAny :: #type (instance: Instance, futureCount: u64, futures: *FutureWaitInfo, timeoutNS: u64) -> WaitStatus #c_call;

/**
* Proc pointer type for @ref wgpuInstanceAddRef.
* > @copydoc wgpuInstanceAddRef
*/
ProcInstanceAddRef :: #type (instance: Instance) -> void #c_call;

/**
* Proc pointer type for @ref wgpuInstanceRelease.
* > @copydoc wgpuInstanceRelease
*/
ProcInstanceRelease :: #type (instance: Instance) -> void #c_call;

// Procs of PipelineLayout
/**
* Proc pointer type for @ref wgpuPipelineLayoutSetLabel:
* > @copydoc wgpuPipelineLayoutSetLabel
*/
ProcPipelineLayoutSetLabel :: #type (pipelineLayout: PipelineLayout, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuPipelineLayoutAddRef.
* > @copydoc wgpuPipelineLayoutAddRef
*/
ProcPipelineLayoutAddRef :: #type (pipelineLayout: PipelineLayout) -> void #c_call;

/**
* Proc pointer type for @ref wgpuPipelineLayoutRelease.
* > @copydoc wgpuPipelineLayoutRelease
*/
ProcPipelineLayoutRelease :: #type (pipelineLayout: PipelineLayout) -> void #c_call;

// Procs of QuerySet
/**
* Proc pointer type for @ref wgpuQuerySetDestroy:
* > @copydoc wgpuQuerySetDestroy
*/
ProcQuerySetDestroy :: #type (querySet: QuerySet) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQuerySetGetCount:
* > @copydoc wgpuQuerySetGetCount
*/
ProcQuerySetGetCount :: #type (querySet: QuerySet) -> u32 #c_call;

/**
* Proc pointer type for @ref wgpuQuerySetGetType:
* > @copydoc wgpuQuerySetGetType
*/
ProcQuerySetGetType :: #type (querySet: QuerySet) -> QueryType #c_call;

/**
* Proc pointer type for @ref wgpuQuerySetSetLabel:
* > @copydoc wgpuQuerySetSetLabel
*/
ProcQuerySetSetLabel :: #type (querySet: QuerySet, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQuerySetAddRef.
* > @copydoc wgpuQuerySetAddRef
*/
ProcQuerySetAddRef :: #type (querySet: QuerySet) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQuerySetRelease.
* > @copydoc wgpuQuerySetRelease
*/
ProcQuerySetRelease :: #type (querySet: QuerySet) -> void #c_call;

// Procs of Queue
/**
* Proc pointer type for @ref wgpuQueueOnSubmittedWorkDone:
* > @copydoc wgpuQueueOnSubmittedWorkDone
*/
ProcQueueOnSubmittedWorkDone :: #type (queue: Queue, callbackInfo: QueueWorkDoneCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuQueueSetLabel:
* > @copydoc wgpuQueueSetLabel
*/
ProcQueueSetLabel :: #type (queue: Queue, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQueueSubmit:
* > @copydoc wgpuQueueSubmit
*/
ProcQueueSubmit :: #type (queue: Queue, commandCount: u64, commands: *CommandBuffer) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQueueWriteBuffer:
* > @copydoc wgpuQueueWriteBuffer
*/
ProcQueueWriteBuffer :: #type (queue: Queue, buffer: Buffer, bufferOffset: u64, data: *void, size: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQueueWriteTexture:
* > @copydoc wgpuQueueWriteTexture
*/
ProcQueueWriteTexture :: #type (queue: Queue, destination: *TexelCopyTextureInfo, data: *void, dataSize: u64, dataLayout: *TexelCopyBufferLayout, writeSize: *Extent3D) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQueueAddRef.
* > @copydoc wgpuQueueAddRef
*/
ProcQueueAddRef :: #type (queue: Queue) -> void #c_call;

/**
* Proc pointer type for @ref wgpuQueueRelease.
* > @copydoc wgpuQueueRelease
*/
ProcQueueRelease :: #type (queue: Queue) -> void #c_call;

// Procs of RenderBundle
/**
* Proc pointer type for @ref wgpuRenderBundleSetLabel:
* > @copydoc wgpuRenderBundleSetLabel
*/
ProcRenderBundleSetLabel :: #type (renderBundle: RenderBundle, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleAddRef.
* > @copydoc wgpuRenderBundleAddRef
*/
ProcRenderBundleAddRef :: #type (renderBundle: RenderBundle) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleRelease.
* > @copydoc wgpuRenderBundleRelease
*/
ProcRenderBundleRelease :: #type (renderBundle: RenderBundle) -> void #c_call;

// Procs of RenderBundleEncoder
/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDraw:
* > @copydoc wgpuRenderBundleEncoderDraw
*/
ProcRenderBundleEncoderDraw :: #type (renderBundleEncoder: RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexed:
* > @copydoc wgpuRenderBundleEncoderDrawIndexed
*/
ProcRenderBundleEncoderDrawIndexed :: #type (renderBundleEncoder: RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexedIndirect:
* > @copydoc wgpuRenderBundleEncoderDrawIndexedIndirect
*/
ProcRenderBundleEncoderDrawIndexedIndirect :: #type (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndirect:
* > @copydoc wgpuRenderBundleEncoderDrawIndirect
*/
ProcRenderBundleEncoderDrawIndirect :: #type (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderFinish:
* > @copydoc wgpuRenderBundleEncoderFinish
*/
ProcRenderBundleEncoderFinish :: #type (renderBundleEncoder: RenderBundleEncoder, descriptor: *RenderBundleDescriptor) -> RenderBundle #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderInsertDebugMarker:
* > @copydoc wgpuRenderBundleEncoderInsertDebugMarker
*/
ProcRenderBundleEncoderInsertDebugMarker :: #type (renderBundleEncoder: RenderBundleEncoder, markerLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderPopDebugGroup:
* > @copydoc wgpuRenderBundleEncoderPopDebugGroup
*/
ProcRenderBundleEncoderPopDebugGroup :: #type (renderBundleEncoder: RenderBundleEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderPushDebugGroup:
* > @copydoc wgpuRenderBundleEncoderPushDebugGroup
*/
ProcRenderBundleEncoderPushDebugGroup :: #type (renderBundleEncoder: RenderBundleEncoder, groupLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetBindGroup:
* > @copydoc wgpuRenderBundleEncoderSetBindGroup
*/
ProcRenderBundleEncoderSetBindGroup :: #type (renderBundleEncoder: RenderBundleEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetIndexBuffer:
* > @copydoc wgpuRenderBundleEncoderSetIndexBuffer
*/
ProcRenderBundleEncoderSetIndexBuffer :: #type (renderBundleEncoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetLabel:
* > @copydoc wgpuRenderBundleEncoderSetLabel
*/
ProcRenderBundleEncoderSetLabel :: #type (renderBundleEncoder: RenderBundleEncoder, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetPipeline:
* > @copydoc wgpuRenderBundleEncoderSetPipeline
*/
ProcRenderBundleEncoderSetPipeline :: #type (renderBundleEncoder: RenderBundleEncoder, pipeline: RenderPipeline) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetVertexBuffer:
* > @copydoc wgpuRenderBundleEncoderSetVertexBuffer
*/
ProcRenderBundleEncoderSetVertexBuffer :: #type (renderBundleEncoder: RenderBundleEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderAddRef.
* > @copydoc wgpuRenderBundleEncoderAddRef
*/
ProcRenderBundleEncoderAddRef :: #type (renderBundleEncoder: RenderBundleEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderRelease.
* > @copydoc wgpuRenderBundleEncoderRelease
*/
ProcRenderBundleEncoderRelease :: #type (renderBundleEncoder: RenderBundleEncoder) -> void #c_call;

// Procs of RenderPassEncoder
/**
* Proc pointer type for @ref wgpuRenderPassEncoderBeginOcclusionQuery:
* > @copydoc wgpuRenderPassEncoderBeginOcclusionQuery
*/
ProcRenderPassEncoderBeginOcclusionQuery :: #type (renderPassEncoder: RenderPassEncoder, queryIndex: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDraw:
* > @copydoc wgpuRenderPassEncoderDraw
*/
ProcRenderPassEncoderDraw :: #type (renderPassEncoder: RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexed:
* > @copydoc wgpuRenderPassEncoderDrawIndexed
*/
ProcRenderPassEncoderDrawIndexed :: #type (renderPassEncoder: RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexedIndirect:
* > @copydoc wgpuRenderPassEncoderDrawIndexedIndirect
*/
ProcRenderPassEncoderDrawIndexedIndirect :: #type (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDrawIndirect:
* > @copydoc wgpuRenderPassEncoderDrawIndirect
*/
ProcRenderPassEncoderDrawIndirect :: #type (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderEnd:
* > @copydoc wgpuRenderPassEncoderEnd
*/
ProcRenderPassEncoderEnd :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderEndOcclusionQuery:
* > @copydoc wgpuRenderPassEncoderEndOcclusionQuery
*/
ProcRenderPassEncoderEndOcclusionQuery :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderExecuteBundles:
* > @copydoc wgpuRenderPassEncoderExecuteBundles
*/
ProcRenderPassEncoderExecuteBundles :: #type (renderPassEncoder: RenderPassEncoder, bundleCount: u64, bundles: *RenderBundle) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderInsertDebugMarker:
* > @copydoc wgpuRenderPassEncoderInsertDebugMarker
*/
ProcRenderPassEncoderInsertDebugMarker :: #type (renderPassEncoder: RenderPassEncoder, markerLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderPopDebugGroup:
* > @copydoc wgpuRenderPassEncoderPopDebugGroup
*/
ProcRenderPassEncoderPopDebugGroup :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderPushDebugGroup:
* > @copydoc wgpuRenderPassEncoderPushDebugGroup
*/
ProcRenderPassEncoderPushDebugGroup :: #type (renderPassEncoder: RenderPassEncoder, groupLabel: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetBindGroup:
* > @copydoc wgpuRenderPassEncoderSetBindGroup
*/
ProcRenderPassEncoderSetBindGroup :: #type (renderPassEncoder: RenderPassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetBlendConstant:
* > @copydoc wgpuRenderPassEncoderSetBlendConstant
*/
ProcRenderPassEncoderSetBlendConstant :: #type (renderPassEncoder: RenderPassEncoder, color: *Color) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetIndexBuffer:
* > @copydoc wgpuRenderPassEncoderSetIndexBuffer
*/
ProcRenderPassEncoderSetIndexBuffer :: #type (renderPassEncoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetLabel:
* > @copydoc wgpuRenderPassEncoderSetLabel
*/
ProcRenderPassEncoderSetLabel :: #type (renderPassEncoder: RenderPassEncoder, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetPipeline:
* > @copydoc wgpuRenderPassEncoderSetPipeline
*/
ProcRenderPassEncoderSetPipeline :: #type (renderPassEncoder: RenderPassEncoder, pipeline: RenderPipeline) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetScissorRect:
* > @copydoc wgpuRenderPassEncoderSetScissorRect
*/
ProcRenderPassEncoderSetScissorRect :: #type (renderPassEncoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetStencilReference:
* > @copydoc wgpuRenderPassEncoderSetStencilReference
*/
ProcRenderPassEncoderSetStencilReference :: #type (renderPassEncoder: RenderPassEncoder, reference: u32) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetVertexBuffer:
* > @copydoc wgpuRenderPassEncoderSetVertexBuffer
*/
ProcRenderPassEncoderSetVertexBuffer :: #type (renderPassEncoder: RenderPassEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetViewport:
* > @copydoc wgpuRenderPassEncoderSetViewport
*/
ProcRenderPassEncoderSetViewport :: #type (renderPassEncoder: RenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderAddRef.
* > @copydoc wgpuRenderPassEncoderAddRef
*/
ProcRenderPassEncoderAddRef :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPassEncoderRelease.
* > @copydoc wgpuRenderPassEncoderRelease
*/
ProcRenderPassEncoderRelease :: #type (renderPassEncoder: RenderPassEncoder) -> void #c_call;

// Procs of RenderPipeline
/**
* Proc pointer type for @ref wgpuRenderPipelineGetBindGroupLayout:
* > @copydoc wgpuRenderPipelineGetBindGroupLayout
*/
ProcRenderPipelineGetBindGroupLayout :: #type (renderPipeline: RenderPipeline, groupIndex: u32) -> BindGroupLayout #c_call;

/**
* Proc pointer type for @ref wgpuRenderPipelineSetLabel:
* > @copydoc wgpuRenderPipelineSetLabel
*/
ProcRenderPipelineSetLabel :: #type (renderPipeline: RenderPipeline, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPipelineAddRef.
* > @copydoc wgpuRenderPipelineAddRef
*/
ProcRenderPipelineAddRef :: #type (renderPipeline: RenderPipeline) -> void #c_call;

/**
* Proc pointer type for @ref wgpuRenderPipelineRelease.
* > @copydoc wgpuRenderPipelineRelease
*/
ProcRenderPipelineRelease :: #type (renderPipeline: RenderPipeline) -> void #c_call;

// Procs of Sampler
/**
* Proc pointer type for @ref wgpuSamplerSetLabel:
* > @copydoc wgpuSamplerSetLabel
*/
ProcSamplerSetLabel :: #type (sampler: Sampler, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuSamplerAddRef.
* > @copydoc wgpuSamplerAddRef
*/
ProcSamplerAddRef :: #type (sampler: Sampler) -> void #c_call;

/**
* Proc pointer type for @ref wgpuSamplerRelease.
* > @copydoc wgpuSamplerRelease
*/
ProcSamplerRelease :: #type (sampler: Sampler) -> void #c_call;

// Procs of ShaderModule
/**
* Proc pointer type for @ref wgpuShaderModuleGetCompilationInfo:
* > @copydoc wgpuShaderModuleGetCompilationInfo
*/
ProcShaderModuleGetCompilationInfo :: #type (shaderModule: ShaderModule, callbackInfo: CompilationInfoCallbackInfo) -> Future #c_call;

/**
* Proc pointer type for @ref wgpuShaderModuleSetLabel:
* > @copydoc wgpuShaderModuleSetLabel
*/
ProcShaderModuleSetLabel :: #type (shaderModule: ShaderModule, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuShaderModuleAddRef.
* > @copydoc wgpuShaderModuleAddRef
*/
ProcShaderModuleAddRef :: #type (shaderModule: ShaderModule) -> void #c_call;

/**
* Proc pointer type for @ref wgpuShaderModuleRelease.
* > @copydoc wgpuShaderModuleRelease
*/
ProcShaderModuleRelease :: #type (shaderModule: ShaderModule) -> void #c_call;

// Procs of SupportedFeatures
/**
* Proc pointer type for @ref wgpuSupportedFeaturesFreeMembers:
* > @copydoc wgpuSupportedFeaturesFreeMembers
*/
ProcSupportedFeaturesFreeMembers :: #type (supportedFeatures: SupportedFeatures) -> void #c_call;

// Procs of SupportedWGSLLanguageFeatures
/**
* Proc pointer type for @ref wgpuSupportedWGSLLanguageFeaturesFreeMembers:
* > @copydoc wgpuSupportedWGSLLanguageFeaturesFreeMembers
*/
ProcSupportedWGSLLanguageFeaturesFreeMembers :: #type (supportedWGSLLanguageFeatures: SupportedWGSLLanguageFeatures) -> void #c_call;

// Procs of Surface
/**
* Proc pointer type for @ref wgpuSurfaceConfigure:
* > @copydoc wgpuSurfaceConfigure
*/
ProcSurfaceConfigure :: #type (surface: Surface, config: *SurfaceConfiguration) -> void #c_call;

/**
* Proc pointer type for @ref wgpuSurfaceGetCapabilities:
* > @copydoc wgpuSurfaceGetCapabilities
*/
ProcSurfaceGetCapabilities :: #type (surface: Surface, adapter: Adapter, capabilities: *SurfaceCapabilities) -> Status #c_call;

/**
* Proc pointer type for @ref wgpuSurfaceGetCurrentTexture:
* > @copydoc wgpuSurfaceGetCurrentTexture
*/
ProcSurfaceGetCurrentTexture :: #type (surface: Surface, surfaceTexture: *SurfaceTexture) -> void #c_call;

/**
* Proc pointer type for @ref wgpuSurfacePresent:
* > @copydoc wgpuSurfacePresent
*/
ProcSurfacePresent :: #type (surface: Surface) -> Status #c_call;

/**
* Proc pointer type for @ref wgpuSurfaceSetLabel:
* > @copydoc wgpuSurfaceSetLabel
*/
ProcSurfaceSetLabel :: #type (surface: Surface, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuSurfaceUnconfigure:
* > @copydoc wgpuSurfaceUnconfigure
*/
ProcSurfaceUnconfigure :: #type (surface: Surface) -> void #c_call;

/**
* Proc pointer type for @ref wgpuSurfaceAddRef.
* > @copydoc wgpuSurfaceAddRef
*/
ProcSurfaceAddRef :: #type (surface: Surface) -> void #c_call;

/**
* Proc pointer type for @ref wgpuSurfaceRelease.
* > @copydoc wgpuSurfaceRelease
*/
ProcSurfaceRelease :: #type (surface: Surface) -> void #c_call;

// Procs of SurfaceCapabilities
/**
* Proc pointer type for @ref wgpuSurfaceCapabilitiesFreeMembers:
* > @copydoc wgpuSurfaceCapabilitiesFreeMembers
*/
ProcSurfaceCapabilitiesFreeMembers :: #type (surfaceCapabilities: SurfaceCapabilities) -> void #c_call;

// Procs of Texture
/**
* Proc pointer type for @ref wgpuTextureCreateView:
* > @copydoc wgpuTextureCreateView
*/
ProcTextureCreateView :: #type (texture: Texture, descriptor: *TextureViewDescriptor) -> TextureView #c_call;

/**
* Proc pointer type for @ref wgpuTextureDestroy:
* > @copydoc wgpuTextureDestroy
*/
ProcTextureDestroy :: #type (texture: Texture) -> void #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetDepthOrArrayLayers:
* > @copydoc wgpuTextureGetDepthOrArrayLayers
*/
ProcTextureGetDepthOrArrayLayers :: #type (texture: Texture) -> u32 #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetDimension:
* > @copydoc wgpuTextureGetDimension
*/
ProcTextureGetDimension :: #type (texture: Texture) -> TextureDimension #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetFormat:
* > @copydoc wgpuTextureGetFormat
*/
ProcTextureGetFormat :: #type (texture: Texture) -> TextureFormat #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetHeight:
* > @copydoc wgpuTextureGetHeight
*/
ProcTextureGetHeight :: #type (texture: Texture) -> u32 #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetMipLevelCount:
* > @copydoc wgpuTextureGetMipLevelCount
*/
ProcTextureGetMipLevelCount :: #type (texture: Texture) -> u32 #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetSampleCount:
* > @copydoc wgpuTextureGetSampleCount
*/
ProcTextureGetSampleCount :: #type (texture: Texture) -> u32 #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetUsage:
* > @copydoc wgpuTextureGetUsage
*/
ProcTextureGetUsage :: #type (texture: Texture) -> TextureUsage #c_call;

/**
* Proc pointer type for @ref wgpuTextureGetWidth:
* > @copydoc wgpuTextureGetWidth
*/
ProcTextureGetWidth :: #type (texture: Texture) -> u32 #c_call;

/**
* Proc pointer type for @ref wgpuTextureSetLabel:
* > @copydoc wgpuTextureSetLabel
*/
ProcTextureSetLabel :: #type (texture: Texture, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuTextureAddRef.
* > @copydoc wgpuTextureAddRef
*/
ProcTextureAddRef :: #type (texture: Texture) -> void #c_call;

/**
* Proc pointer type for @ref wgpuTextureRelease.
* > @copydoc wgpuTextureRelease
*/
ProcTextureRelease :: #type (texture: Texture) -> void #c_call;

// Procs of TextureView
/**
* Proc pointer type for @ref wgpuTextureViewSetLabel:
* > @copydoc wgpuTextureViewSetLabel
*/
ProcTextureViewSetLabel :: #type (textureView: TextureView, label: StringView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuTextureViewAddRef.
* > @copydoc wgpuTextureViewAddRef
*/
ProcTextureViewAddRef :: #type (textureView: TextureView) -> void #c_call;

/**
* Proc pointer type for @ref wgpuTextureViewRelease.
* > @copydoc wgpuTextureViewRelease
*/
ProcTextureViewRelease :: #type (textureView: TextureView) -> void #c_call;

/**
* \defgroup GlobalFunctions Global Functions
* \brief Functions that are not specific to an object.
*
* @{
*/
/**
* Create a WGPUInstance
*/
CreateInstance :: (descriptor: *InstanceDescriptor) -> Instance #foreign libwgpu_native "wgpuCreateInstance";

/**
* Query the supported instance capabilities.
*
* @param capabilities
* The supported instance capabilities
*
* @returns
* Indicates if there was an @ref OutStructChainError.
*/
GetInstanceCapabilities :: (capabilities: *InstanceCapabilities) -> Status #foreign libwgpu_native "wgpuGetInstanceCapabilities";

/**
* Returns the "procedure address" (function pointer) of the named function.
* The result must be cast to the appropriate proc pointer type.
*/
GetProcAddress :: (procName: StringView) -> Proc #foreign libwgpu_native "wgpuGetProcAddress";

/**
* \defgroup WGPUAdapterMethods WGPUAdapter methods
* \brief Functions whose first argument has type WGPUAdapter.
*
* @{
*/
/**
* Get the list of @ref WGPUFeatureName values supported by the adapter.
*
* @param features
* This parameter is @ref ReturnedWithOwnership.
*/
AdapterGetFeatures :: (adapter: Adapter, features: *SupportedFeatures) -> void #foreign libwgpu_native "wgpuAdapterGetFeatures";

/**
* @param info
* This parameter is @ref ReturnedWithOwnership.
*
* @returns
* Indicates if there was an @ref OutStructChainError.
*/
AdapterGetInfo :: (adapter: Adapter, info: *AdapterInfo) -> Status #foreign libwgpu_native "wgpuAdapterGetInfo";

/**
* @returns
* Indicates if there was an @ref OutStructChainError.
*/
AdapterGetLimits :: (adapter: Adapter, limits: *Limits) -> Status #foreign libwgpu_native "wgpuAdapterGetLimits";
AdapterHasFeature :: (adapter: Adapter, feature: FeatureName) -> Bool #foreign libwgpu_native "wgpuAdapterHasFeature";
AdapterRequestDevice :: (adapter: Adapter, descriptor: *DeviceDescriptor, callbackInfo: RequestDeviceCallbackInfo) -> Future #foreign libwgpu_native "wgpuAdapterRequestDevice";
AdapterAddRef :: (adapter: Adapter) -> void #foreign libwgpu_native "wgpuAdapterAddRef";
AdapterRelease :: (adapter: Adapter) -> void #foreign libwgpu_native "wgpuAdapterRelease";

/**
* \defgroup WGPUAdapterInfoMethods WGPUAdapterInfo methods
* \brief Functions whose first argument has type WGPUAdapterInfo.
*
* @{
*/
/**
* Frees array members of WGPUAdapterInfo which were allocated by the API.
*/
AdapterInfoFreeMembers :: (adapterInfo: AdapterInfo) -> void #foreign libwgpu_native "wgpuAdapterInfoFreeMembers";

/**
* \defgroup WGPUBindGroupMethods WGPUBindGroup methods
* \brief Functions whose first argument has type WGPUBindGroup.
*
* @{
*/
BindGroupSetLabel :: (bindGroup: BindGroup, label: StringView) -> void #foreign libwgpu_native "wgpuBindGroupSetLabel";
BindGroupAddRef :: (bindGroup: BindGroup) -> void #foreign libwgpu_native "wgpuBindGroupAddRef";
BindGroupRelease :: (bindGroup: BindGroup) -> void #foreign libwgpu_native "wgpuBindGroupRelease";

/**
* \defgroup WGPUBindGroupLayoutMethods WGPUBindGroupLayout methods
* \brief Functions whose first argument has type WGPUBindGroupLayout.
*
* @{
*/
BindGroupLayoutSetLabel :: (bindGroupLayout: BindGroupLayout, label: StringView) -> void #foreign libwgpu_native "wgpuBindGroupLayoutSetLabel";
BindGroupLayoutAddRef :: (bindGroupLayout: BindGroupLayout) -> void #foreign libwgpu_native "wgpuBindGroupLayoutAddRef";
BindGroupLayoutRelease :: (bindGroupLayout: BindGroupLayout) -> void #foreign libwgpu_native "wgpuBindGroupLayoutRelease";

/**
* \defgroup WGPUBufferMethods WGPUBuffer methods
* \brief Functions whose first argument has type WGPUBuffer.
*
* @{
*/
BufferDestroy :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferDestroy";

/**
* @param offset
* Byte offset relative to the beginning of the buffer.
*
* @param size
* Byte size of the range to get. The returned pointer is valid for exactly this many bytes.
*
* @returns
* Returns a const pointer to beginning of the mapped range.
* It must not be written; writing to this range causes undefined behavior.
* Returns `NULL` with @ref ImplementationDefinedLogging if:
*
* - There is any content-timeline error as defined in the WebGPU specification for `getMappedRange()` (alignments, overlaps, etc.)
*   **except** for overlaps with other *const* ranges, which are allowed in C.
*   (JS does not allow this because const ranges do not exist.)
*/
BufferGetConstMappedRange :: (buffer: Buffer, offset: u64, size: u64) -> *void #foreign libwgpu_native "wgpuBufferGetConstMappedRange";
BufferGetMapState :: (buffer: Buffer) -> BufferMapState #foreign libwgpu_native "wgpuBufferGetMapState";

/**
* @param offset
* Byte offset relative to the beginning of the buffer.
*
* @param size
* Byte size of the range to get. The returned pointer is valid for exactly this many bytes.
*
* @returns
* Returns a mutable pointer to beginning of the mapped range.
* Returns `NULL` with @ref ImplementationDefinedLogging if:
*
* - There is any content-timeline error as defined in the WebGPU specification for `getMappedRange()` (alignments, overlaps, etc.)
* - The buffer is not mapped with @ref WGPUMapMode_Write.
*/
BufferGetMappedRange :: (buffer: Buffer, offset: u64, size: u64) -> *void #foreign libwgpu_native "wgpuBufferGetMappedRange";
BufferGetSize :: (buffer: Buffer) -> u64 #foreign libwgpu_native "wgpuBufferGetSize";
BufferGetUsage :: (buffer: Buffer) -> BufferUsage #foreign libwgpu_native "wgpuBufferGetUsage";
BufferMapAsync :: (buffer: Buffer, mode: MapMode, offset: u64, size: u64, callbackInfo: BufferMapCallbackInfo) -> Future #foreign libwgpu_native "wgpuBufferMapAsync";
BufferSetLabel :: (buffer: Buffer, label: StringView) -> void #foreign libwgpu_native "wgpuBufferSetLabel";
BufferUnmap :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferUnmap";
BufferAddRef :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferAddRef";
BufferRelease :: (buffer: Buffer) -> void #foreign libwgpu_native "wgpuBufferRelease";

/**
* \defgroup WGPUCommandBufferMethods WGPUCommandBuffer methods
* \brief Functions whose first argument has type WGPUCommandBuffer.
*
* @{
*/
CommandBufferSetLabel :: (commandBuffer: CommandBuffer, label: StringView) -> void #foreign libwgpu_native "wgpuCommandBufferSetLabel";
CommandBufferAddRef :: (commandBuffer: CommandBuffer) -> void #foreign libwgpu_native "wgpuCommandBufferAddRef";
CommandBufferRelease :: (commandBuffer: CommandBuffer) -> void #foreign libwgpu_native "wgpuCommandBufferRelease";

/**
* \defgroup WGPUCommandEncoderMethods WGPUCommandEncoder methods
* \brief Functions whose first argument has type WGPUCommandEncoder.
*
* @{
*/
CommandEncoderBeginComputePass :: (commandEncoder: CommandEncoder, descriptor: *ComputePassDescriptor) -> ComputePassEncoder #foreign libwgpu_native "wgpuCommandEncoderBeginComputePass";
CommandEncoderBeginRenderPass :: (commandEncoder: CommandEncoder, descriptor: *RenderPassDescriptor) -> RenderPassEncoder #foreign libwgpu_native "wgpuCommandEncoderBeginRenderPass";
CommandEncoderClearBuffer :: (commandEncoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuCommandEncoderClearBuffer";
CommandEncoderCopyBufferToBuffer :: (commandEncoder: CommandEncoder, source: Buffer, sourceOffset: u64, destination: Buffer, destinationOffset: u64, size: u64) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyBufferToBuffer";
CommandEncoderCopyBufferToTexture :: (commandEncoder: CommandEncoder, source: *TexelCopyBufferInfo, destination: *TexelCopyTextureInfo, copySize: *Extent3D) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyBufferToTexture";
CommandEncoderCopyTextureToBuffer :: (commandEncoder: CommandEncoder, source: *TexelCopyTextureInfo, destination: *TexelCopyBufferInfo, copySize: *Extent3D) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyTextureToBuffer";
CommandEncoderCopyTextureToTexture :: (commandEncoder: CommandEncoder, source: *TexelCopyTextureInfo, destination: *TexelCopyTextureInfo, copySize: *Extent3D) -> void #foreign libwgpu_native "wgpuCommandEncoderCopyTextureToTexture";
CommandEncoderFinish :: (commandEncoder: CommandEncoder, descriptor: *CommandBufferDescriptor) -> CommandBuffer #foreign libwgpu_native "wgpuCommandEncoderFinish";
CommandEncoderInsertDebugMarker :: (commandEncoder: CommandEncoder, markerLabel: StringView) -> void #foreign libwgpu_native "wgpuCommandEncoderInsertDebugMarker";
CommandEncoderPopDebugGroup :: (commandEncoder: CommandEncoder) -> void #foreign libwgpu_native "wgpuCommandEncoderPopDebugGroup";
CommandEncoderPushDebugGroup :: (commandEncoder: CommandEncoder, groupLabel: StringView) -> void #foreign libwgpu_native "wgpuCommandEncoderPushDebugGroup";
CommandEncoderResolveQuerySet :: (commandEncoder: CommandEncoder, querySet: QuerySet, firstQuery: u32, queryCount: u32, destination: Buffer, destinationOffset: u64) -> void #foreign libwgpu_native "wgpuCommandEncoderResolveQuerySet";
CommandEncoderSetLabel :: (commandEncoder: CommandEncoder, label: StringView) -> void #foreign libwgpu_native "wgpuCommandEncoderSetLabel";
CommandEncoderWriteTimestamp :: (commandEncoder: CommandEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuCommandEncoderWriteTimestamp";
CommandEncoderAddRef :: (commandEncoder: CommandEncoder) -> void #foreign libwgpu_native "wgpuCommandEncoderAddRef";
CommandEncoderRelease :: (commandEncoder: CommandEncoder) -> void #foreign libwgpu_native "wgpuCommandEncoderRelease";

/**
* \defgroup WGPUComputePassEncoderMethods WGPUComputePassEncoder methods
* \brief Functions whose first argument has type WGPUComputePassEncoder.
*
* @{
*/
ComputePassEncoderDispatchWorkgroups :: (computePassEncoder: ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) -> void #foreign libwgpu_native "wgpuComputePassEncoderDispatchWorkgroups";
ComputePassEncoderDispatchWorkgroupsIndirect :: (computePassEncoder: ComputePassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuComputePassEncoderDispatchWorkgroupsIndirect";
ComputePassEncoderEnd :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderEnd";
ComputePassEncoderInsertDebugMarker :: (computePassEncoder: ComputePassEncoder, markerLabel: StringView) -> void #foreign libwgpu_native "wgpuComputePassEncoderInsertDebugMarker";
ComputePassEncoderPopDebugGroup :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderPopDebugGroup";
ComputePassEncoderPushDebugGroup :: (computePassEncoder: ComputePassEncoder, groupLabel: StringView) -> void #foreign libwgpu_native "wgpuComputePassEncoderPushDebugGroup";
ComputePassEncoderSetBindGroup :: (computePassEncoder: ComputePassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native "wgpuComputePassEncoderSetBindGroup";
ComputePassEncoderSetLabel :: (computePassEncoder: ComputePassEncoder, label: StringView) -> void #foreign libwgpu_native "wgpuComputePassEncoderSetLabel";
ComputePassEncoderSetPipeline :: (computePassEncoder: ComputePassEncoder, pipeline: ComputePipeline) -> void #foreign libwgpu_native "wgpuComputePassEncoderSetPipeline";
ComputePassEncoderAddRef :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderAddRef";
ComputePassEncoderRelease :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderRelease";

/**
* \defgroup WGPUComputePipelineMethods WGPUComputePipeline methods
* \brief Functions whose first argument has type WGPUComputePipeline.
*
* @{
*/
ComputePipelineGetBindGroupLayout :: (computePipeline: ComputePipeline, groupIndex: u32) -> BindGroupLayout #foreign libwgpu_native "wgpuComputePipelineGetBindGroupLayout";
ComputePipelineSetLabel :: (computePipeline: ComputePipeline, label: StringView) -> void #foreign libwgpu_native "wgpuComputePipelineSetLabel";
ComputePipelineAddRef :: (computePipeline: ComputePipeline) -> void #foreign libwgpu_native "wgpuComputePipelineAddRef";
ComputePipelineRelease :: (computePipeline: ComputePipeline) -> void #foreign libwgpu_native "wgpuComputePipelineRelease";

/**
* \defgroup WGPUDeviceMethods WGPUDevice methods
* \brief Functions whose first argument has type WGPUDevice.
*
* @{
*/
DeviceCreateBindGroup :: (device: Device, descriptor: *BindGroupDescriptor) -> BindGroup #foreign libwgpu_native "wgpuDeviceCreateBindGroup";
DeviceCreateBindGroupLayout :: (device: Device, descriptor: *BindGroupLayoutDescriptor) -> BindGroupLayout #foreign libwgpu_native "wgpuDeviceCreateBindGroupLayout";
DeviceCreateBuffer :: (device: Device, descriptor: *BufferDescriptor) -> Buffer #foreign libwgpu_native "wgpuDeviceCreateBuffer";
DeviceCreateCommandEncoder :: (device: Device, descriptor: *CommandEncoderDescriptor) -> CommandEncoder #foreign libwgpu_native "wgpuDeviceCreateCommandEncoder";
DeviceCreateComputePipeline :: (device: Device, descriptor: *ComputePipelineDescriptor) -> ComputePipeline #foreign libwgpu_native "wgpuDeviceCreateComputePipeline";
DeviceCreateComputePipelineAsync :: (device: Device, descriptor: *ComputePipelineDescriptor, callbackInfo: CreateComputePipelineAsyncCallbackInfo) -> Future #foreign libwgpu_native "wgpuDeviceCreateComputePipelineAsync";
DeviceCreatePipelineLayout :: (device: Device, descriptor: *PipelineLayoutDescriptor) -> PipelineLayout #foreign libwgpu_native "wgpuDeviceCreatePipelineLayout";
DeviceCreateQuerySet :: (device: Device, descriptor: *QuerySetDescriptor) -> QuerySet #foreign libwgpu_native "wgpuDeviceCreateQuerySet";
DeviceCreateRenderBundleEncoder :: (device: Device, descriptor: *RenderBundleEncoderDescriptor) -> RenderBundleEncoder #foreign libwgpu_native "wgpuDeviceCreateRenderBundleEncoder";
DeviceCreateRenderPipeline :: (device: Device, descriptor: *RenderPipelineDescriptor) -> RenderPipeline #foreign libwgpu_native "wgpuDeviceCreateRenderPipeline";
DeviceCreateRenderPipelineAsync :: (device: Device, descriptor: *RenderPipelineDescriptor, callbackInfo: CreateRenderPipelineAsyncCallbackInfo) -> Future #foreign libwgpu_native "wgpuDeviceCreateRenderPipelineAsync";
DeviceCreateSampler :: (device: Device, descriptor: *SamplerDescriptor) -> Sampler #foreign libwgpu_native "wgpuDeviceCreateSampler";
DeviceCreateShaderModule :: (device: Device, descriptor: *ShaderModuleDescriptor) -> ShaderModule #foreign libwgpu_native "wgpuDeviceCreateShaderModule";
DeviceCreateTexture :: (device: Device, descriptor: *TextureDescriptor) -> Texture #foreign libwgpu_native "wgpuDeviceCreateTexture";
DeviceDestroy :: (device: Device) -> void #foreign libwgpu_native "wgpuDeviceDestroy";
DeviceGetAdapterInfo :: (device: Device) -> AdapterInfo #foreign libwgpu_native "wgpuDeviceGetAdapterInfo";

/**
* Get the list of @ref WGPUFeatureName values supported by the device.
*
* @param features
* This parameter is @ref ReturnedWithOwnership.
*/
DeviceGetFeatures :: (device: Device, features: *SupportedFeatures) -> void #foreign libwgpu_native "wgpuDeviceGetFeatures";

/**
* @returns
* Indicates if there was an @ref OutStructChainError.
*/
DeviceGetLimits :: (device: Device, limits: *Limits) -> Status #foreign libwgpu_native "wgpuDeviceGetLimits";

/**
* @returns
* The @ref WGPUFuture for the device-lost event of the device.
*/
DeviceGetLostFuture :: (device: Device) -> Future #foreign libwgpu_native "wgpuDeviceGetLostFuture";
DeviceGetQueue :: (device: Device) -> Queue #foreign libwgpu_native "wgpuDeviceGetQueue";
DeviceHasFeature :: (device: Device, feature: FeatureName) -> Bool #foreign libwgpu_native "wgpuDeviceHasFeature";
DevicePopErrorScope :: (device: Device, callbackInfo: PopErrorScopeCallbackInfo) -> Future #foreign libwgpu_native "wgpuDevicePopErrorScope";
DevicePushErrorScope :: (device: Device, filter: ErrorFilter) -> void #foreign libwgpu_native "wgpuDevicePushErrorScope";
DeviceSetLabel :: (device: Device, label: StringView) -> void #foreign libwgpu_native "wgpuDeviceSetLabel";
DeviceAddRef :: (device: Device) -> void #foreign libwgpu_native "wgpuDeviceAddRef";
DeviceRelease :: (device: Device) -> void #foreign libwgpu_native "wgpuDeviceRelease";

/**
* \defgroup WGPUInstanceMethods WGPUInstance methods
* \brief Functions whose first argument has type WGPUInstance.
*
* @{
*/
/**
* Creates a @ref WGPUSurface, see @ref Surface-Creation for more details.
*
* @param descriptor
* The description of the @ref WGPUSurface to create.
*
* @returns
* A new @ref WGPUSurface for this descriptor (or an error @ref WGPUSurface).
*/
InstanceCreateSurface :: (instance: Instance, descriptor: *SurfaceDescriptor) -> Surface #foreign libwgpu_native "wgpuInstanceCreateSurface";

/**
* Get the list of @ref WGPUWGSLLanguageFeatureName values supported by the instance.
*/
InstanceGetWGSLLanguageFeatures :: (instance: Instance, features: *SupportedWGSLLanguageFeatures) -> Status #foreign libwgpu_native "wgpuInstanceGetWGSLLanguageFeatures";
InstanceHasWGSLLanguageFeature :: (instance: Instance, feature: WGSLLanguageFeatureName) -> Bool #foreign libwgpu_native "wgpuInstanceHasWGSLLanguageFeature";

/**
* Processes asynchronous events on this `WGPUInstance`, calling any callbacks for asynchronous operations created with `::WGPUCallbackMode_AllowProcessEvents`.
*
* See @ref Process-Events for more information.
*/
InstanceProcessEvents :: (instance: Instance) -> void #foreign libwgpu_native "wgpuInstanceProcessEvents";
InstanceRequestAdapter :: (instance: Instance, options: *RequestAdapterOptions, callbackInfo: RequestAdapterCallbackInfo) -> Future #foreign libwgpu_native "wgpuInstanceRequestAdapter";

/**
* Wait for at least one WGPUFuture in `futures` to complete, and call callbacks of the respective completed asynchronous operations.
*
* See @ref Wait-Any for more information.
*/
InstanceWaitAny :: (instance: Instance, futureCount: u64, futures: *FutureWaitInfo, timeoutNS: u64) -> WaitStatus #foreign libwgpu_native "wgpuInstanceWaitAny";
InstanceAddRef :: (instance: Instance) -> void #foreign libwgpu_native "wgpuInstanceAddRef";
InstanceRelease :: (instance: Instance) -> void #foreign libwgpu_native "wgpuInstanceRelease";

/**
* \defgroup WGPUPipelineLayoutMethods WGPUPipelineLayout methods
* \brief Functions whose first argument has type WGPUPipelineLayout.
*
* @{
*/
PipelineLayoutSetLabel :: (pipelineLayout: PipelineLayout, label: StringView) -> void #foreign libwgpu_native "wgpuPipelineLayoutSetLabel";
PipelineLayoutAddRef :: (pipelineLayout: PipelineLayout) -> void #foreign libwgpu_native "wgpuPipelineLayoutAddRef";
PipelineLayoutRelease :: (pipelineLayout: PipelineLayout) -> void #foreign libwgpu_native "wgpuPipelineLayoutRelease";

/**
* \defgroup WGPUQuerySetMethods WGPUQuerySet methods
* \brief Functions whose first argument has type WGPUQuerySet.
*
* @{
*/
QuerySetDestroy :: (querySet: QuerySet) -> void #foreign libwgpu_native "wgpuQuerySetDestroy";
QuerySetGetCount :: (querySet: QuerySet) -> u32 #foreign libwgpu_native "wgpuQuerySetGetCount";
QuerySetGetType :: (querySet: QuerySet) -> QueryType #foreign libwgpu_native "wgpuQuerySetGetType";
QuerySetSetLabel :: (querySet: QuerySet, label: StringView) -> void #foreign libwgpu_native "wgpuQuerySetSetLabel";
QuerySetAddRef :: (querySet: QuerySet) -> void #foreign libwgpu_native "wgpuQuerySetAddRef";
QuerySetRelease :: (querySet: QuerySet) -> void #foreign libwgpu_native "wgpuQuerySetRelease";

/**
* \defgroup WGPUQueueMethods WGPUQueue methods
* \brief Functions whose first argument has type WGPUQueue.
*
* @{
*/
QueueOnSubmittedWorkDone :: (queue: Queue, callbackInfo: QueueWorkDoneCallbackInfo) -> Future #foreign libwgpu_native "wgpuQueueOnSubmittedWorkDone";
QueueSetLabel :: (queue: Queue, label: StringView) -> void #foreign libwgpu_native "wgpuQueueSetLabel";
QueueSubmit :: (queue: Queue, commandCount: u64, commands: *CommandBuffer) -> void #foreign libwgpu_native "wgpuQueueSubmit";

/**
* Produces a @ref DeviceError both content-timeline (`size` alignment) and device-timeline
* errors defined by the WebGPU specification.
*/
QueueWriteBuffer :: (queue: Queue, buffer: Buffer, bufferOffset: u64, data: *void, size: u64) -> void #foreign libwgpu_native "wgpuQueueWriteBuffer";
QueueWriteTexture :: (queue: Queue, destination: *TexelCopyTextureInfo, data: *void, dataSize: u64, dataLayout: *TexelCopyBufferLayout, writeSize: *Extent3D) -> void #foreign libwgpu_native "wgpuQueueWriteTexture";
QueueAddRef :: (queue: Queue) -> void #foreign libwgpu_native "wgpuQueueAddRef";
QueueRelease :: (queue: Queue) -> void #foreign libwgpu_native "wgpuQueueRelease";

/**
* \defgroup WGPURenderBundleMethods WGPURenderBundle methods
* \brief Functions whose first argument has type WGPURenderBundle.
*
* @{
*/
RenderBundleSetLabel :: (renderBundle: RenderBundle, label: StringView) -> void #foreign libwgpu_native "wgpuRenderBundleSetLabel";
RenderBundleAddRef :: (renderBundle: RenderBundle) -> void #foreign libwgpu_native "wgpuRenderBundleAddRef";
RenderBundleRelease :: (renderBundle: RenderBundle) -> void #foreign libwgpu_native "wgpuRenderBundleRelease";

/**
* \defgroup WGPURenderBundleEncoderMethods WGPURenderBundleEncoder methods
* \brief Functions whose first argument has type WGPURenderBundleEncoder.
*
* @{
*/
RenderBundleEncoderDraw :: (renderBundleEncoder: RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDraw";
RenderBundleEncoderDrawIndexed :: (renderBundleEncoder: RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDrawIndexed";
RenderBundleEncoderDrawIndexedIndirect :: (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDrawIndexedIndirect";
RenderBundleEncoderDrawIndirect :: (renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderDrawIndirect";
RenderBundleEncoderFinish :: (renderBundleEncoder: RenderBundleEncoder, descriptor: *RenderBundleDescriptor) -> RenderBundle #foreign libwgpu_native "wgpuRenderBundleEncoderFinish";
RenderBundleEncoderInsertDebugMarker :: (renderBundleEncoder: RenderBundleEncoder, markerLabel: StringView) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderInsertDebugMarker";
RenderBundleEncoderPopDebugGroup :: (renderBundleEncoder: RenderBundleEncoder) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderPopDebugGroup";
RenderBundleEncoderPushDebugGroup :: (renderBundleEncoder: RenderBundleEncoder, groupLabel: StringView) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderPushDebugGroup";
RenderBundleEncoderSetBindGroup :: (renderBundleEncoder: RenderBundleEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetBindGroup";
RenderBundleEncoderSetIndexBuffer :: (renderBundleEncoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetIndexBuffer";
RenderBundleEncoderSetLabel :: (renderBundleEncoder: RenderBundleEncoder, label: StringView) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetLabel";
RenderBundleEncoderSetPipeline :: (renderBundleEncoder: RenderBundleEncoder, pipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetPipeline";
RenderBundleEncoderSetVertexBuffer :: (renderBundleEncoder: RenderBundleEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetVertexBuffer";
RenderBundleEncoderAddRef :: (renderBundleEncoder: RenderBundleEncoder) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderAddRef";
RenderBundleEncoderRelease :: (renderBundleEncoder: RenderBundleEncoder) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderRelease";

/**
* \defgroup WGPURenderPassEncoderMethods WGPURenderPassEncoder methods
* \brief Functions whose first argument has type WGPURenderPassEncoder.
*
* @{
*/
RenderPassEncoderBeginOcclusionQuery :: (renderPassEncoder: RenderPassEncoder, queryIndex: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderBeginOcclusionQuery";
RenderPassEncoderDraw :: (renderPassEncoder: RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDraw";
RenderPassEncoderDrawIndexed :: (renderPassEncoder: RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDrawIndexed";
RenderPassEncoderDrawIndexedIndirect :: (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDrawIndexedIndirect";
RenderPassEncoderDrawIndirect :: (renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderDrawIndirect";
RenderPassEncoderEnd :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderEnd";
RenderPassEncoderEndOcclusionQuery :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderEndOcclusionQuery";
RenderPassEncoderExecuteBundles :: (renderPassEncoder: RenderPassEncoder, bundleCount: u64, bundles: *RenderBundle) -> void #foreign libwgpu_native "wgpuRenderPassEncoderExecuteBundles";
RenderPassEncoderInsertDebugMarker :: (renderPassEncoder: RenderPassEncoder, markerLabel: StringView) -> void #foreign libwgpu_native "wgpuRenderPassEncoderInsertDebugMarker";
RenderPassEncoderPopDebugGroup :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderPopDebugGroup";
RenderPassEncoderPushDebugGroup :: (renderPassEncoder: RenderPassEncoder, groupLabel: StringView) -> void #foreign libwgpu_native "wgpuRenderPassEncoderPushDebugGroup";
RenderPassEncoderSetBindGroup :: (renderPassEncoder: RenderPassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: u64, dynamicOffsets: *u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetBindGroup";
RenderPassEncoderSetBlendConstant :: (renderPassEncoder: RenderPassEncoder, color: *Color) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetBlendConstant";
RenderPassEncoderSetIndexBuffer :: (renderPassEncoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetIndexBuffer";
RenderPassEncoderSetLabel :: (renderPassEncoder: RenderPassEncoder, label: StringView) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetLabel";
RenderPassEncoderSetPipeline :: (renderPassEncoder: RenderPassEncoder, pipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetPipeline";
RenderPassEncoderSetScissorRect :: (renderPassEncoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetScissorRect";
RenderPassEncoderSetStencilReference :: (renderPassEncoder: RenderPassEncoder, reference: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetStencilReference";
RenderPassEncoderSetVertexBuffer :: (renderPassEncoder: RenderPassEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetVertexBuffer";
RenderPassEncoderSetViewport :: (renderPassEncoder: RenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetViewport";
RenderPassEncoderAddRef :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderAddRef";
RenderPassEncoderRelease :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderRelease";

/**
* \defgroup WGPURenderPipelineMethods WGPURenderPipeline methods
* \brief Functions whose first argument has type WGPURenderPipeline.
*
* @{
*/
RenderPipelineGetBindGroupLayout :: (renderPipeline: RenderPipeline, groupIndex: u32) -> BindGroupLayout #foreign libwgpu_native "wgpuRenderPipelineGetBindGroupLayout";
RenderPipelineSetLabel :: (renderPipeline: RenderPipeline, label: StringView) -> void #foreign libwgpu_native "wgpuRenderPipelineSetLabel";
RenderPipelineAddRef :: (renderPipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderPipelineAddRef";
RenderPipelineRelease :: (renderPipeline: RenderPipeline) -> void #foreign libwgpu_native "wgpuRenderPipelineRelease";

/**
* \defgroup WGPUSamplerMethods WGPUSampler methods
* \brief Functions whose first argument has type WGPUSampler.
*
* @{
*/
SamplerSetLabel :: (sampler: Sampler, label: StringView) -> void #foreign libwgpu_native "wgpuSamplerSetLabel";
SamplerAddRef :: (sampler: Sampler) -> void #foreign libwgpu_native "wgpuSamplerAddRef";
SamplerRelease :: (sampler: Sampler) -> void #foreign libwgpu_native "wgpuSamplerRelease";

/**
* \defgroup WGPUShaderModuleMethods WGPUShaderModule methods
* \brief Functions whose first argument has type WGPUShaderModule.
*
* @{
*/
ShaderModuleGetCompilationInfo :: (shaderModule: ShaderModule, callbackInfo: CompilationInfoCallbackInfo) -> Future #foreign libwgpu_native "wgpuShaderModuleGetCompilationInfo";
ShaderModuleSetLabel :: (shaderModule: ShaderModule, label: StringView) -> void #foreign libwgpu_native "wgpuShaderModuleSetLabel";
ShaderModuleAddRef :: (shaderModule: ShaderModule) -> void #foreign libwgpu_native "wgpuShaderModuleAddRef";
ShaderModuleRelease :: (shaderModule: ShaderModule) -> void #foreign libwgpu_native "wgpuShaderModuleRelease";

/**
* \defgroup WGPUSupportedFeaturesMethods WGPUSupportedFeatures methods
* \brief Functions whose first argument has type WGPUSupportedFeatures.
*
* @{
*/
/**
* Frees array members of WGPUSupportedFeatures which were allocated by the API.
*/
SupportedFeaturesFreeMembers :: (supportedFeatures: SupportedFeatures) -> void #foreign libwgpu_native "wgpuSupportedFeaturesFreeMembers";

/**
* \defgroup WGPUSupportedWGSLLanguageFeaturesMethods WGPUSupportedWGSLLanguageFeatures methods
* \brief Functions whose first argument has type WGPUSupportedWGSLLanguageFeatures.
*
* @{
*/
/**
* Frees array members of WGPUSupportedWGSLLanguageFeatures which were allocated by the API.
*/
SupportedWGSLLanguageFeaturesFreeMembers :: (supportedWGSLLanguageFeatures: SupportedWGSLLanguageFeatures) -> void #foreign libwgpu_native "wgpuSupportedWGSLLanguageFeaturesFreeMembers";

/**
* \defgroup WGPUSurfaceMethods WGPUSurface methods
* \brief Functions whose first argument has type WGPUSurface.
*
* @{
*/
/**
* Configures parameters for rendering to `surface`.
* Produces a @ref DeviceError for all content-timeline errors defined by the WebGPU specification.
*
* See @ref Surface-Configuration for more details.
*
* @param config
* The new configuration to use.
*/
SurfaceConfigure :: (surface: Surface, config: *SurfaceConfiguration) -> void #foreign libwgpu_native "wgpuSurfaceConfigure";

/**
* Provides information on how `adapter` is able to use `surface`.
* See @ref Surface-Capabilities for more details.
*
* @param adapter
* The @ref WGPUAdapter to get capabilities for presenting to this @ref WGPUSurface.
*
* @param capabilities
* The structure to fill capabilities in.
* It may contain memory allocations so `::wgpuSurfaceCapabilitiesFreeMembers` must be called to avoid memory leaks.
* This parameter is @ref ReturnedWithOwnership.
*
* @returns
* Indicates if there was an @ref OutStructChainError.
*/
SurfaceGetCapabilities :: (surface: Surface, adapter: Adapter, capabilities: *SurfaceCapabilities) -> Status #foreign libwgpu_native "wgpuSurfaceGetCapabilities";

/**
* Returns the @ref WGPUTexture to render to `surface` this frame along with metadata on the frame.
* Returns `NULL` and @ref WGPUSurfaceGetCurrentTextureStatus_Error if the surface is not configured.
*
* See @ref Surface-Presenting for more details.
*
* @param surfaceTexture
* The structure to fill the @ref WGPUTexture and metadata in.
*/
SurfaceGetCurrentTexture :: (surface: Surface, surfaceTexture: *SurfaceTexture) -> void #foreign libwgpu_native "wgpuSurfaceGetCurrentTexture";

/**
* Shows `surface`'s current texture to the user.
* See @ref Surface-Presenting for more details.
*
* @returns
* Returns @ref WGPUStatus_Error if the surface doesn't have a current texture.
*/
SurfacePresent :: (surface: Surface) -> Status #foreign libwgpu_native "wgpuSurfacePresent";

/**
* Modifies the label used to refer to `surface`.
*
* @param label
* The new label.
*/
SurfaceSetLabel :: (surface: Surface, label: StringView) -> void #foreign libwgpu_native "wgpuSurfaceSetLabel";

/**
* Removes the configuration for `surface`.
* See @ref Surface-Configuration for more details.
*/
SurfaceUnconfigure :: (surface: Surface) -> void #foreign libwgpu_native "wgpuSurfaceUnconfigure";
SurfaceAddRef :: (surface: Surface) -> void #foreign libwgpu_native "wgpuSurfaceAddRef";
SurfaceRelease :: (surface: Surface) -> void #foreign libwgpu_native "wgpuSurfaceRelease";

/**
* \defgroup WGPUSurfaceCapabilitiesMethods WGPUSurfaceCapabilities methods
* \brief Functions whose first argument has type WGPUSurfaceCapabilities.
*
* @{
*/
/**
* Frees array members of WGPUSurfaceCapabilities which were allocated by the API.
*/
SurfaceCapabilitiesFreeMembers :: (surfaceCapabilities: SurfaceCapabilities) -> void #foreign libwgpu_native "wgpuSurfaceCapabilitiesFreeMembers";

/**
* \defgroup WGPUTextureMethods WGPUTexture methods
* \brief Functions whose first argument has type WGPUTexture.
*
* @{
*/
TextureCreateView :: (texture: Texture, descriptor: *TextureViewDescriptor) -> TextureView #foreign libwgpu_native "wgpuTextureCreateView";
TextureDestroy :: (texture: Texture) -> void #foreign libwgpu_native "wgpuTextureDestroy";
TextureGetDepthOrArrayLayers :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetDepthOrArrayLayers";
TextureGetDimension :: (texture: Texture) -> TextureDimension #foreign libwgpu_native "wgpuTextureGetDimension";
TextureGetFormat :: (texture: Texture) -> TextureFormat #foreign libwgpu_native "wgpuTextureGetFormat";
TextureGetHeight :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetHeight";
TextureGetMipLevelCount :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetMipLevelCount";
TextureGetSampleCount :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetSampleCount";
TextureGetUsage :: (texture: Texture) -> TextureUsage #foreign libwgpu_native "wgpuTextureGetUsage";
TextureGetWidth :: (texture: Texture) -> u32 #foreign libwgpu_native "wgpuTextureGetWidth";
TextureSetLabel :: (texture: Texture, label: StringView) -> void #foreign libwgpu_native "wgpuTextureSetLabel";
TextureAddRef :: (texture: Texture) -> void #foreign libwgpu_native "wgpuTextureAddRef";
TextureRelease :: (texture: Texture) -> void #foreign libwgpu_native "wgpuTextureRelease";

/**
* \defgroup WGPUTextureViewMethods WGPUTextureView methods
* \brief Functions whose first argument has type WGPUTextureView.
*
* @{
*/
TextureViewSetLabel :: (textureView: TextureView, label: StringView) -> void #foreign libwgpu_native "wgpuTextureViewSetLabel";
TextureViewAddRef :: (textureView: TextureView) -> void #foreign libwgpu_native "wgpuTextureViewAddRef";
TextureViewRelease :: (textureView: TextureView) -> void #foreign libwgpu_native "wgpuTextureViewRelease";

NativeSType :: enum u32 {
    SType_DeviceExtras                :: 196609;
    SType_NativeLimits                :: 196610;
    SType_PipelineLayoutExtras        :: 196611;
    SType_ShaderSourceGLSL            :: 196612;
    SType_InstanceExtras              :: 196614;
    SType_BindGroupEntryExtras        :: 196615;
    SType_BindGroupLayoutEntryExtras  :: 196616;
    SType_QuerySetDescriptorExtras    :: 196617;
    SType_SurfaceConfigurationExtras  :: 196618;
    SType_SurfaceSourceSwapChainPanel :: 196619;
    SType_PrimitiveStateExtras        :: 196620;
    Force32                           :: 2147483647;

    WGPUSType_DeviceExtras                :: SType_DeviceExtras;
    WGPUSType_NativeLimits                :: SType_NativeLimits;
    WGPUSType_PipelineLayoutExtras        :: SType_PipelineLayoutExtras;
    WGPUSType_ShaderSourceGLSL            :: SType_ShaderSourceGLSL;
    WGPUSType_InstanceExtras              :: SType_InstanceExtras;
    WGPUSType_BindGroupEntryExtras        :: SType_BindGroupEntryExtras;
    WGPUSType_BindGroupLayoutEntryExtras  :: SType_BindGroupLayoutEntryExtras;
    WGPUSType_QuerySetDescriptorExtras    :: SType_QuerySetDescriptorExtras;
    WGPUSType_SurfaceConfigurationExtras  :: SType_SurfaceConfigurationExtras;
    WGPUSType_SurfaceSourceSwapChainPanel :: SType_SurfaceSourceSwapChainPanel;
    WGPUSType_PrimitiveStateExtras        :: SType_PrimitiveStateExtras;
    WGPUNativeSType_Force32               :: Force32;
}

NativeFeature :: enum u32 {
    PushConstants                                         :: 196609;
    TextureAdapterSpecificFormatFeatures                  :: 196610;
    MultiDrawIndirectCount                                :: 196612;
    VertexWritableStorage                                 :: 196613;
    TextureBindingArray                                   :: 196614;
    SampledTextureAndStorageBufferArrayNonUniformIndexing :: 196615;
    PipelineStatisticsQuery                               :: 196616;
    StorageResourceBindingArray                           :: 196617;
    PartiallyBoundBindingArray                            :: 196618;
    TextureFormat16bitNorm                                :: 196619;
    TextureCompressionAstcHdr                             :: 196620;
    MappablePrimaryBuffers                                :: 196622;
    BufferBindingArray                                    :: 196623;
    UniformBufferAndStorageTextureArrayNonUniformIndexing :: 196624;

    PolygonModeLine                                       :: 196627;
    PolygonModePoint                                      :: 196628;
    ConservativeRasterization                             :: 196629;

    SpirvShaderPassthrough                                :: 196631;

    VertexAttribute64bit                                  :: 196633;
    TextureFormatNv12                                     :: 196634;
    RayQuery                                              :: 196636;
    ShaderF64                                             :: 196637;
    ShaderI16                                             :: 196638;
    ShaderPrimitiveIndex                                  :: 196639;
    ShaderEarlyDepthTest                                  :: 196640;
    Subgroup                                              :: 196641;
    SubgroupVertex                                        :: 196642;
    SubgroupBarrier                                       :: 196643;
    TimestampQueryInsideEncoders                          :: 196644;
    TimestampQueryInsidePasses                            :: 196645;
    ShaderInt64                                           :: 196646;
    Force32                                               :: 2147483647;

    WGPUNativeFeature_PushConstants                                         :: PushConstants;
    WGPUNativeFeature_TextureAdapterSpecificFormatFeatures                  :: TextureAdapterSpecificFormatFeatures;
    WGPUNativeFeature_MultiDrawIndirectCount                                :: MultiDrawIndirectCount;
    WGPUNativeFeature_VertexWritableStorage                                 :: VertexWritableStorage;
    WGPUNativeFeature_TextureBindingArray                                   :: TextureBindingArray;
    WGPUNativeFeature_SampledTextureAndStorageBufferArrayNonUniformIndexing :: SampledTextureAndStorageBufferArrayNonUniformIndexing;
    WGPUNativeFeature_PipelineStatisticsQuery                               :: PipelineStatisticsQuery;
    WGPUNativeFeature_StorageResourceBindingArray                           :: StorageResourceBindingArray;
    WGPUNativeFeature_PartiallyBoundBindingArray                            :: PartiallyBoundBindingArray;
    WGPUNativeFeature_TextureFormat16bitNorm                                :: TextureFormat16bitNorm;
    WGPUNativeFeature_TextureCompressionAstcHdr                             :: TextureCompressionAstcHdr;
    WGPUNativeFeature_MappablePrimaryBuffers                                :: MappablePrimaryBuffers;
    WGPUNativeFeature_BufferBindingArray                                    :: BufferBindingArray;
    WGPUNativeFeature_UniformBufferAndStorageTextureArrayNonUniformIndexing :: UniformBufferAndStorageTextureArrayNonUniformIndexing;

    WGPUNativeFeature_PolygonModeLine                                       :: PolygonModeLine;
    WGPUNativeFeature_PolygonModePoint                                      :: PolygonModePoint;
    WGPUNativeFeature_ConservativeRasterization                             :: ConservativeRasterization;

    WGPUNativeFeature_SpirvShaderPassthrough                                :: SpirvShaderPassthrough;

    WGPUNativeFeature_VertexAttribute64bit                                  :: VertexAttribute64bit;
    WGPUNativeFeature_TextureFormatNv12                                     :: TextureFormatNv12;
    WGPUNativeFeature_RayQuery                                              :: RayQuery;
    WGPUNativeFeature_ShaderF64                                             :: ShaderF64;
    WGPUNativeFeature_ShaderI16                                             :: ShaderI16;
    WGPUNativeFeature_ShaderPrimitiveIndex                                  :: ShaderPrimitiveIndex;
    WGPUNativeFeature_ShaderEarlyDepthTest                                  :: ShaderEarlyDepthTest;
    WGPUNativeFeature_Subgroup                                              :: Subgroup;
    WGPUNativeFeature_SubgroupVertex                                        :: SubgroupVertex;
    WGPUNativeFeature_SubgroupBarrier                                       :: SubgroupBarrier;
    WGPUNativeFeature_TimestampQueryInsideEncoders                          :: TimestampQueryInsideEncoders;
    WGPUNativeFeature_TimestampQueryInsidePasses                            :: TimestampQueryInsidePasses;
    WGPUNativeFeature_ShaderInt64                                           :: ShaderInt64;
    WGPUNativeFeature_Force32                                               :: Force32;
}

LogLevel :: enum u32 {
    Off     :: 0;
    Error   :: 1;
    Warn    :: 2;
    Info    :: 3;
    Debug   :: 4;
    Trace   :: 5;
    Force32 :: 2147483647;

    WGPULogLevel_Off     :: Off;
    WGPULogLevel_Error   :: Error;
    WGPULogLevel_Warn    :: Warn;
    WGPULogLevel_Info    :: Info;
    WGPULogLevel_Debug   :: Debug;
    WGPULogLevel_Trace   :: Trace;
    WGPULogLevel_Force32 :: Force32;
}

InstanceBackend :: Flags;
WGPUInstanceBackend_All: InstanceBackend : 0;
WGPUInstanceBackend_Vulkan: InstanceBackend : 1 << 0;
WGPUInstanceBackend_GL: InstanceBackend : 1 << 1;
WGPUInstanceBackend_Metal: InstanceBackend : 1 << 2;
WGPUInstanceBackend_DX12: InstanceBackend : 1 << 3;
WGPUInstanceBackend_DX11: InstanceBackend : 1 << 4;
WGPUInstanceBackend_BrowserWebGPU: InstanceBackend : 1 << 5;

// Vulkan, Metal, DX12 and BrowserWebGPU
WGPUInstanceBackend_Primary: InstanceBackend : (1 << 0) | (1 << 2) | (1 << 3) | (1 << 5);

// GL and DX11
WGPUInstanceBackend_Secondary: InstanceBackend : (1 << 1) | (1 << 4);
WGPUInstanceBackend_Force32: InstanceBackend : 2147483647;

InstanceFlag :: Flags;
WGPUInstanceFlag_Default: InstanceFlag : 0;
WGPUInstanceFlag_Debug: InstanceFlag : 1 << 0;
WGPUInstanceFlag_Validation: InstanceFlag : 1 << 1;
WGPUInstanceFlag_DiscardHalLabels: InstanceFlag : 1 << 2;
WGPUInstanceFlag_Force32: InstanceFlag : 2147483647;

Dx12Compiler :: enum u32 {
    Undefined :: 0;
    Fxc       :: 1;
    Dxc       :: 2;
    Force32   :: 2147483647;

    WGPUDx12Compiler_Undefined :: Undefined;
    WGPUDx12Compiler_Fxc       :: Fxc;
    WGPUDx12Compiler_Dxc       :: Dxc;
    WGPUDx12Compiler_Force32   :: Force32;
}

Gles3MinorVersion :: enum u32 {
    Automatic :: 0;
    Version0  :: 1;
    Version1  :: 2;
    Version2  :: 3;
    Force32   :: 2147483647;

    WGPUGles3MinorVersion_Automatic :: Automatic;
    WGPUGles3MinorVersion_Version0  :: Version0;
    WGPUGles3MinorVersion_Version1  :: Version1;
    WGPUGles3MinorVersion_Version2  :: Version2;
    WGPUGles3MinorVersion_Force32   :: Force32;
}

PipelineStatisticName :: enum u32 {
    VertexShaderInvocations   :: 0;
    ClipperInvocations        :: 1;
    ClipperPrimitivesOut      :: 2;
    FragmentShaderInvocations :: 3;
    ComputeShaderInvocations  :: 4;
    Force32                   :: 2147483647;

    WGPUPipelineStatisticName_VertexShaderInvocations   :: VertexShaderInvocations;
    WGPUPipelineStatisticName_ClipperInvocations        :: ClipperInvocations;
    WGPUPipelineStatisticName_ClipperPrimitivesOut      :: ClipperPrimitivesOut;
    WGPUPipelineStatisticName_FragmentShaderInvocations :: FragmentShaderInvocations;
    WGPUPipelineStatisticName_ComputeShaderInvocations  :: ComputeShaderInvocations;
    WGPUPipelineStatisticName_Force32                   :: Force32;
}

NativeQueryType :: enum u32 {
    PipelineStatistics :: 196608;
    Force32            :: 2147483647;

    WGPUNativeQueryType_PipelineStatistics :: PipelineStatistics;
    WGPUNativeQueryType_Force32            :: Force32;
}

DxcMaxShaderModel :: enum u32 {
    V6_0    :: 0;
    V6_1    :: 1;
    V6_2    :: 2;
    V6_3    :: 3;
    V6_4    :: 4;
    V6_5    :: 5;
    V6_6    :: 6;
    V6_7    :: 7;
    Force32 :: 2147483647;

    WGPUDxcMaxShaderModel_V6_0    :: V6_0;
    WGPUDxcMaxShaderModel_V6_1    :: V6_1;
    WGPUDxcMaxShaderModel_V6_2    :: V6_2;
    WGPUDxcMaxShaderModel_V6_3    :: V6_3;
    WGPUDxcMaxShaderModel_V6_4    :: V6_4;
    WGPUDxcMaxShaderModel_V6_5    :: V6_5;
    WGPUDxcMaxShaderModel_V6_6    :: V6_6;
    WGPUDxcMaxShaderModel_V6_7    :: V6_7;
    WGPUDxcMaxShaderModel_Force32 :: Force32;
}

GLFenceBehaviour :: enum u32 {
    Normal     :: 0;
    AutoFinish :: 1;
    Force32    :: 2147483647;

    WGPUGLFenceBehaviour_Normal     :: Normal;
    WGPUGLFenceBehaviour_AutoFinish :: AutoFinish;
    WGPUGLFenceBehaviour_Force32    :: Force32;
}

Dx12SwapchainKind :: enum u32 {
    Undefined      :: 0;
    DxgiFromHwnd   :: 1;
    DxgiFromVisual :: 2;
    Force32        :: 2147483647;

    WGPUDx12SwapchainKind_Undefined      :: Undefined;
    WGPUDx12SwapchainKind_DxgiFromHwnd   :: DxgiFromHwnd;
    WGPUDx12SwapchainKind_DxgiFromVisual :: DxgiFromVisual;
    WGPUDx12SwapchainKind_Force32        :: Force32;
}

InstanceExtras :: struct {
    chain:                   ChainedStruct;
    backends:                InstanceBackend;
    flags:                   InstanceFlag;
    dx12ShaderCompiler:      Dx12Compiler;
    gles3MinorVersion:       Gles3MinorVersion;
    glFenceBehaviour:        GLFenceBehaviour;
    dxcPath:                 StringView;
    dxcMaxShaderModel:       DxcMaxShaderModel;
    dx12PresentationSystem:  Dx12SwapchainKind;

    budgetForDeviceCreation: *u8;
    budgetForDeviceLoss:     *u8;
}

DeviceExtras :: struct {
    chain:     ChainedStruct;
    tracePath: StringView;
}

NativeLimits :: struct {
    /** This struct chain is used as mutable in some places and immutable in others. */
    chain:                                 ChainedStructOut;
    maxPushConstantSize:                   u32;
    maxNonSamplerBindings:                 u32;
    maxBindingArrayElementsPerShaderStage: u32;
}

PushConstantRange :: struct {
    stages: ShaderStage;
    start:  u32;
    end:    u32;
}

PipelineLayoutExtras :: struct {
    chain:                  ChainedStruct;
    pushConstantRangeCount: u64;
    pushConstantRanges:     *PushConstantRange;
}

SubmissionIndex :: u64;

ShaderDefine :: struct {
    name:  StringView;
    value: StringView;
}

ShaderSourceGLSL :: struct {
    chain:       ChainedStruct;
    stage:       ShaderStage;
    code:        StringView;
    defineCount: u32;
    defines:     *ShaderDefine;
}

ShaderModuleDescriptorSpirV :: struct {
    label:      StringView;
    sourceSize: u32;
    source:     *u32;
}

RegistryReport :: struct {
    numAllocated:        u64;
    numKeptFromUser:     u64;
    numReleasedFromUser: u64;
    elementSize:         u64;
}

HubReport :: struct {
    adapters:         RegistryReport;
    devices:          RegistryReport;
    queues:           RegistryReport;
    pipelineLayouts:  RegistryReport;
    shaderModules:    RegistryReport;
    bindGroupLayouts: RegistryReport;
    bindGroups:       RegistryReport;
    commandBuffers:   RegistryReport;
    renderBundles:    RegistryReport;
    renderPipelines:  RegistryReport;
    computePipelines: RegistryReport;
    pipelineCaches:   RegistryReport;
    querySets:        RegistryReport;
    buffers:          RegistryReport;
    textures:         RegistryReport;
    textureViews:     RegistryReport;
    samplers:         RegistryReport;
}

GlobalReport :: struct {
    surfaces: RegistryReport;
    hub:      HubReport;
}

InstanceEnumerateAdapterOptions :: struct {
    nextInChain: *ChainedStruct;
    backends:    InstanceBackend;
}

BindGroupEntryExtras :: struct {
    chain:            ChainedStruct;
    buffers:          *Buffer;
    bufferCount:      u64;
    samplers:         *Sampler;
    samplerCount:     u64;
    textureViews:     *TextureView;
    textureViewCount: u64;
}

BindGroupLayoutEntryExtras :: struct {
    chain: ChainedStruct;
    count: u32;
}

QuerySetDescriptorExtras :: struct {
    chain:                  ChainedStruct;
    pipelineStatistics:     *PipelineStatisticName;
    pipelineStatisticCount: u64;
}

SurfaceConfigurationExtras :: struct {
    chain:                      ChainedStruct;
    desiredMaximumFrameLatency: u32;
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make a @ref WGPUSurface wrapping a WinUI [`SwapChainPanel`](https://learn.microsoft.com/en-us/windows/windows-app-sdk/api/winrt/microsoft.ui.xaml.controls.swapchainpanel).
*/
SurfaceSourceSwapChainPanel :: struct {
    chain:       ChainedStruct;

    /**
    * A pointer to the [`ISwapChainPanelNative`](https://learn.microsoft.com/en-us/windows/windows-app-sdk/api/win32/microsoft.ui.xaml.media.dxinterop/nn-microsoft-ui-xaml-media-dxinterop-iswapchainpanelnative)
    * interface of the SwapChainPanel that will be wrapped by the @ref WGPUSurface.
    */
    panelNative: *void;
}

PolygonMode :: enum u32 {
    Fill  :: 0;
    Line  :: 1;
    Point :: 2;

    WGPUPolygonMode_Fill  :: Fill;
    WGPUPolygonMode_Line  :: Line;
    WGPUPolygonMode_Point :: Point;
}

PrimitiveStateExtras :: struct {
    chain:        ChainedStruct;
    polygonMode:  PolygonMode;
    conservative: Bool;
}

LogCallback :: #type (level: LogLevel, message: StringView, userdata: *void) -> void #c_call;

NativeTextureFormat :: enum u32 {
    R16Unorm    :: 196609;
    R16Snorm    :: 196610;
    Rg16Unorm   :: 196611;
    Rg16Snorm   :: 196612;
    Rgba16Unorm :: 196613;
    Rgba16Snorm :: 196614;

    NV12        :: 196615;
    P010        :: 196616;

    WGPUNativeTextureFormat_R16Unorm    :: R16Unorm;
    WGPUNativeTextureFormat_R16Snorm    :: R16Snorm;
    WGPUNativeTextureFormat_Rg16Unorm   :: Rg16Unorm;
    WGPUNativeTextureFormat_Rg16Snorm   :: Rg16Snorm;
    WGPUNativeTextureFormat_Rgba16Unorm :: Rgba16Unorm;
    WGPUNativeTextureFormat_Rgba16Snorm :: Rgba16Snorm;

    WGPUNativeTextureFormat_NV12        :: NV12;
    WGPUNativeTextureFormat_P010        :: P010;
}

GenerateReport :: (instance: Instance, report: *GlobalReport) -> void #foreign libwgpu_native "wgpuGenerateReport";
InstanceEnumerateAdapters :: (instance: Instance, options: *InstanceEnumerateAdapterOptions, adapters: *Adapter) -> u64 #foreign libwgpu_native "wgpuInstanceEnumerateAdapters";

QueueSubmitForIndex :: (queue: Queue, commandCount: u64, commands: *CommandBuffer) -> SubmissionIndex #foreign libwgpu_native "wgpuQueueSubmitForIndex";
QueueGetTimestampPeriod :: (queue: Queue) -> float #foreign libwgpu_native "wgpuQueueGetTimestampPeriod";

// Returns true if the queue is empty, or false if there are more queue submissions still in flight.
DevicePoll :: (device: Device, wait: Bool, submissionIndex: *SubmissionIndex) -> Bool #foreign libwgpu_native "wgpuDevicePoll";
DeviceCreateShaderModuleSpirV :: (device: Device, descriptor: *ShaderModuleDescriptorSpirV) -> ShaderModule #foreign libwgpu_native "wgpuDeviceCreateShaderModuleSpirV";

SetLogCallback :: (callback: LogCallback, userdata: *void) -> void #foreign libwgpu_native "wgpuSetLogCallback";

SetLogLevel :: (level: LogLevel) -> void #foreign libwgpu_native "wgpuSetLogLevel";

GetVersion :: () -> u32 #foreign libwgpu_native "wgpuGetVersion";

RenderPassEncoderSetPushConstants :: (encoder: RenderPassEncoder, stages: ShaderStage, offset: u32, sizeBytes: u32, data: *void) -> void #foreign libwgpu_native "wgpuRenderPassEncoderSetPushConstants";
ComputePassEncoderSetPushConstants :: (encoder: ComputePassEncoder, offset: u32, sizeBytes: u32, data: *void) -> void #foreign libwgpu_native "wgpuComputePassEncoderSetPushConstants";
RenderBundleEncoderSetPushConstants :: (encoder: RenderBundleEncoder, stages: ShaderStage, offset: u32, sizeBytes: u32, data: *void) -> void #foreign libwgpu_native "wgpuRenderBundleEncoderSetPushConstants";

RenderPassEncoderMultiDrawIndirect :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndirect";
RenderPassEncoderMultiDrawIndexedIndirect :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndexedIndirect";

RenderPassEncoderMultiDrawIndirectCount :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndirectCount";
RenderPassEncoderMultiDrawIndexedIndirectCount :: (encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderMultiDrawIndexedIndirectCount";

ComputePassEncoderBeginPipelineStatisticsQuery :: (computePassEncoder: ComputePassEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuComputePassEncoderBeginPipelineStatisticsQuery";
ComputePassEncoderEndPipelineStatisticsQuery :: (computePassEncoder: ComputePassEncoder) -> void #foreign libwgpu_native "wgpuComputePassEncoderEndPipelineStatisticsQuery";
RenderPassEncoderBeginPipelineStatisticsQuery :: (renderPassEncoder: RenderPassEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderBeginPipelineStatisticsQuery";
RenderPassEncoderEndPipelineStatisticsQuery :: (renderPassEncoder: RenderPassEncoder) -> void #foreign libwgpu_native "wgpuRenderPassEncoderEndPipelineStatisticsQuery";

ComputePassEncoderWriteTimestamp :: (computePassEncoder: ComputePassEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuComputePassEncoderWriteTimestamp";
RenderPassEncoderWriteTimestamp :: (renderPassEncoder: RenderPassEncoder, querySet: QuerySet, queryIndex: u32) -> void #foreign libwgpu_native "wgpuRenderPassEncoderWriteTimestamp";

#scope_file

#import "Basic"; // For assert

libwgpu_native :: #library,no_dll "linux/libwgpu_native";

#run {
    {
        info := type_info(StringView);
        for info.members {
            if it.name == {
                case "data";
                    assert(it.offset_in_bytes == 0, "StringView.data has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "StringView.data has unexpected size % instead of 8", it.type.runtime_size);
                case "length";
                    assert(it.offset_in_bytes == 8, "StringView.length has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "StringView.length has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(StringView) == 16, "StringView has size % instead of 16", size_of(StringView));
    }

    {
        info := type_info(ChainedStruct);
        for info.members {
            if it.name == {
                case "next";
                    assert(it.offset_in_bytes == 0, "ChainedStruct.next has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ChainedStruct.next has unexpected size % instead of 8", it.type.runtime_size);
                case "sType";
                    assert(it.offset_in_bytes == 8, "ChainedStruct.sType has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ChainedStruct.sType has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ChainedStruct) == 16, "ChainedStruct has size % instead of 16", size_of(ChainedStruct));
    }

    {
        info := type_info(ChainedStructOut);
        for info.members {
            if it.name == {
                case "next";
                    assert(it.offset_in_bytes == 0, "ChainedStructOut.next has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ChainedStructOut.next has unexpected size % instead of 8", it.type.runtime_size);
                case "sType";
                    assert(it.offset_in_bytes == 8, "ChainedStructOut.sType has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ChainedStructOut.sType has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ChainedStructOut) == 16, "ChainedStructOut has size % instead of 16", size_of(ChainedStructOut));
    }

    {
        info := type_info(BufferMapCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "BufferMapCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferMapCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "BufferMapCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BufferMapCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "BufferMapCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferMapCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "BufferMapCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferMapCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "BufferMapCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferMapCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(BufferMapCallbackInfo) == 40, "BufferMapCallbackInfo has size % instead of 40", size_of(BufferMapCallbackInfo));
    }

    {
        info := type_info(CompilationInfoCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "CompilationInfoCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationInfoCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "CompilationInfoCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "CompilationInfoCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "CompilationInfoCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationInfoCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "CompilationInfoCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationInfoCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "CompilationInfoCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationInfoCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(CompilationInfoCallbackInfo) == 40, "CompilationInfoCallbackInfo has size % instead of 40", size_of(CompilationInfoCallbackInfo));
    }

    {
        info := type_info(CreateComputePipelineAsyncCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "CreateComputePipelineAsyncCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateComputePipelineAsyncCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "CreateComputePipelineAsyncCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "CreateComputePipelineAsyncCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "CreateComputePipelineAsyncCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateComputePipelineAsyncCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "CreateComputePipelineAsyncCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateComputePipelineAsyncCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "CreateComputePipelineAsyncCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateComputePipelineAsyncCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(CreateComputePipelineAsyncCallbackInfo) == 40, "CreateComputePipelineAsyncCallbackInfo has size % instead of 40", size_of(CreateComputePipelineAsyncCallbackInfo));
    }

    {
        info := type_info(CreateRenderPipelineAsyncCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "CreateRenderPipelineAsyncCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateRenderPipelineAsyncCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "CreateRenderPipelineAsyncCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "CreateRenderPipelineAsyncCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "CreateRenderPipelineAsyncCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateRenderPipelineAsyncCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "CreateRenderPipelineAsyncCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateRenderPipelineAsyncCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "CreateRenderPipelineAsyncCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CreateRenderPipelineAsyncCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(CreateRenderPipelineAsyncCallbackInfo) == 40, "CreateRenderPipelineAsyncCallbackInfo has size % instead of 40", size_of(CreateRenderPipelineAsyncCallbackInfo));
    }

    {
        info := type_info(DeviceLostCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "DeviceLostCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceLostCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "DeviceLostCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DeviceLostCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "DeviceLostCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceLostCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "DeviceLostCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceLostCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "DeviceLostCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceLostCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(DeviceLostCallbackInfo) == 40, "DeviceLostCallbackInfo has size % instead of 40", size_of(DeviceLostCallbackInfo));
    }

    {
        info := type_info(PopErrorScopeCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "PopErrorScopeCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PopErrorScopeCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "PopErrorScopeCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PopErrorScopeCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "PopErrorScopeCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PopErrorScopeCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "PopErrorScopeCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PopErrorScopeCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "PopErrorScopeCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PopErrorScopeCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(PopErrorScopeCallbackInfo) == 40, "PopErrorScopeCallbackInfo has size % instead of 40", size_of(PopErrorScopeCallbackInfo));
    }

    {
        info := type_info(QueueWorkDoneCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "QueueWorkDoneCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QueueWorkDoneCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "QueueWorkDoneCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "QueueWorkDoneCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "QueueWorkDoneCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QueueWorkDoneCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "QueueWorkDoneCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QueueWorkDoneCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "QueueWorkDoneCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QueueWorkDoneCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(QueueWorkDoneCallbackInfo) == 40, "QueueWorkDoneCallbackInfo has size % instead of 40", size_of(QueueWorkDoneCallbackInfo));
    }

    {
        info := type_info(RequestAdapterCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RequestAdapterCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestAdapterCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "RequestAdapterCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RequestAdapterCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "RequestAdapterCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestAdapterCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "RequestAdapterCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestAdapterCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "RequestAdapterCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestAdapterCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RequestAdapterCallbackInfo) == 40, "RequestAdapterCallbackInfo has size % instead of 40", size_of(RequestAdapterCallbackInfo));
    }

    {
        info := type_info(RequestDeviceCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RequestDeviceCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestDeviceCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "mode";
                    assert(it.offset_in_bytes == 8, "RequestDeviceCallbackInfo.mode has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RequestDeviceCallbackInfo.mode has unexpected size % instead of 4", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 16, "RequestDeviceCallbackInfo.callback has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestDeviceCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 24, "RequestDeviceCallbackInfo.userdata1 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestDeviceCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 32, "RequestDeviceCallbackInfo.userdata2 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestDeviceCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RequestDeviceCallbackInfo) == 40, "RequestDeviceCallbackInfo has size % instead of 40", size_of(RequestDeviceCallbackInfo));
    }

    {
        info := type_info(UncapturedErrorCallbackInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "UncapturedErrorCallbackInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "UncapturedErrorCallbackInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "callback";
                    assert(it.offset_in_bytes == 8, "UncapturedErrorCallbackInfo.callback has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "UncapturedErrorCallbackInfo.callback has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata1";
                    assert(it.offset_in_bytes == 16, "UncapturedErrorCallbackInfo.userdata1 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "UncapturedErrorCallbackInfo.userdata1 has unexpected size % instead of 8", it.type.runtime_size);
                case "userdata2";
                    assert(it.offset_in_bytes == 24, "UncapturedErrorCallbackInfo.userdata2 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "UncapturedErrorCallbackInfo.userdata2 has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(UncapturedErrorCallbackInfo) == 32, "UncapturedErrorCallbackInfo has size % instead of 32", size_of(UncapturedErrorCallbackInfo));
    }

    {
        info := type_info(AdapterInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "AdapterInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "AdapterInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "vendor";
                    assert(it.offset_in_bytes == 8, "AdapterInfo.vendor has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "AdapterInfo.vendor has unexpected size % instead of 16", it.type.runtime_size);
                case "architecture";
                    assert(it.offset_in_bytes == 24, "AdapterInfo.architecture has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "AdapterInfo.architecture has unexpected size % instead of 16", it.type.runtime_size);
                case "device";
                    assert(it.offset_in_bytes == 40, "AdapterInfo.device has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "AdapterInfo.device has unexpected size % instead of 16", it.type.runtime_size);
                case "description";
                    assert(it.offset_in_bytes == 56, "AdapterInfo.description has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "AdapterInfo.description has unexpected size % instead of 16", it.type.runtime_size);
                case "backendType";
                    assert(it.offset_in_bytes == 72, "AdapterInfo.backendType has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "AdapterInfo.backendType has unexpected size % instead of 4", it.type.runtime_size);
                case "adapterType";
                    assert(it.offset_in_bytes == 76, "AdapterInfo.adapterType has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "AdapterInfo.adapterType has unexpected size % instead of 4", it.type.runtime_size);
                case "vendorID";
                    assert(it.offset_in_bytes == 80, "AdapterInfo.vendorID has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "AdapterInfo.vendorID has unexpected size % instead of 4", it.type.runtime_size);
                case "deviceID";
                    assert(it.offset_in_bytes == 84, "AdapterInfo.deviceID has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "AdapterInfo.deviceID has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(AdapterInfo) == 88, "AdapterInfo has size % instead of 88", size_of(AdapterInfo));
    }

    {
        info := type_info(BindGroupEntry);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "BindGroupEntry.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntry.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "binding";
                    assert(it.offset_in_bytes == 8, "BindGroupEntry.binding has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BindGroupEntry.binding has unexpected size % instead of 4", it.type.runtime_size);
                case "buffer";
                    assert(it.offset_in_bytes == 16, "BindGroupEntry.buffer has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntry.buffer has unexpected size % instead of 8", it.type.runtime_size);
                case "offset";
                    assert(it.offset_in_bytes == 24, "BindGroupEntry.offset has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntry.offset has unexpected size % instead of 8", it.type.runtime_size);
                case "size";
                    assert(it.offset_in_bytes == 32, "BindGroupEntry.size has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntry.size has unexpected size % instead of 8", it.type.runtime_size);
                case "sampler";
                    assert(it.offset_in_bytes == 40, "BindGroupEntry.sampler has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntry.sampler has unexpected size % instead of 8", it.type.runtime_size);
                case "textureView";
                    assert(it.offset_in_bytes == 48, "BindGroupEntry.textureView has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntry.textureView has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(BindGroupEntry) == 56, "BindGroupEntry has size % instead of 56", size_of(BindGroupEntry));
    }

    {
        info := type_info(BlendComponent);
        for info.members {
            if it.name == {
                case "operation";
                    assert(it.offset_in_bytes == 0, "BlendComponent.operation has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BlendComponent.operation has unexpected size % instead of 4", it.type.runtime_size);
                case "srcFactor";
                    assert(it.offset_in_bytes == 4, "BlendComponent.srcFactor has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BlendComponent.srcFactor has unexpected size % instead of 4", it.type.runtime_size);
                case "dstFactor";
                    assert(it.offset_in_bytes == 8, "BlendComponent.dstFactor has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BlendComponent.dstFactor has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(BlendComponent) == 12, "BlendComponent has size % instead of 12", size_of(BlendComponent));
    }

    {
        info := type_info(BufferBindingLayout);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "BufferBindingLayout.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferBindingLayout.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 8, "BufferBindingLayout.type has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BufferBindingLayout.type has unexpected size % instead of 4", it.type.runtime_size);
                case "hasDynamicOffset";
                    assert(it.offset_in_bytes == 12, "BufferBindingLayout.hasDynamicOffset has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BufferBindingLayout.hasDynamicOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "minBindingSize";
                    assert(it.offset_in_bytes == 16, "BufferBindingLayout.minBindingSize has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferBindingLayout.minBindingSize has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(BufferBindingLayout) == 24, "BufferBindingLayout has size % instead of 24", size_of(BufferBindingLayout));
    }

    {
        info := type_info(BufferDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "BufferDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "BufferDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "BufferDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "usage";
                    assert(it.offset_in_bytes == 24, "BufferDescriptor.usage has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferDescriptor.usage has unexpected size % instead of 8", it.type.runtime_size);
                case "size";
                    assert(it.offset_in_bytes == 32, "BufferDescriptor.size has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BufferDescriptor.size has unexpected size % instead of 8", it.type.runtime_size);
                case "mappedAtCreation";
                    assert(it.offset_in_bytes == 40, "BufferDescriptor.mappedAtCreation has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BufferDescriptor.mappedAtCreation has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(BufferDescriptor) == 48, "BufferDescriptor has size % instead of 48", size_of(BufferDescriptor));
    }

    {
        info := type_info(Color);
        for info.members {
            if it.name == {
                case "r";
                    assert(it.offset_in_bytes == 0, "Color.r has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Color.r has unexpected size % instead of 8", it.type.runtime_size);
                case "g";
                    assert(it.offset_in_bytes == 8, "Color.g has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Color.g has unexpected size % instead of 8", it.type.runtime_size);
                case "b";
                    assert(it.offset_in_bytes == 16, "Color.b has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Color.b has unexpected size % instead of 8", it.type.runtime_size);
                case "a";
                    assert(it.offset_in_bytes == 24, "Color.a has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Color.a has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(Color) == 32, "Color has size % instead of 32", size_of(Color));
    }

    {
        info := type_info(CommandBufferDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "CommandBufferDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CommandBufferDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "CommandBufferDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "CommandBufferDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(CommandBufferDescriptor) == 24, "CommandBufferDescriptor has size % instead of 24", size_of(CommandBufferDescriptor));
    }

    {
        info := type_info(CommandEncoderDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "CommandEncoderDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CommandEncoderDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "CommandEncoderDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "CommandEncoderDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(CommandEncoderDescriptor) == 24, "CommandEncoderDescriptor has size % instead of 24", size_of(CommandEncoderDescriptor));
    }

    {
        info := type_info(CompilationMessage);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "CompilationMessage.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationMessage.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "message";
                    assert(it.offset_in_bytes == 8, "CompilationMessage.message has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "CompilationMessage.message has unexpected size % instead of 16", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 24, "CompilationMessage.type has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "CompilationMessage.type has unexpected size % instead of 4", it.type.runtime_size);
                case "lineNum";
                    assert(it.offset_in_bytes == 32, "CompilationMessage.lineNum has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationMessage.lineNum has unexpected size % instead of 8", it.type.runtime_size);
                case "linePos";
                    assert(it.offset_in_bytes == 40, "CompilationMessage.linePos has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationMessage.linePos has unexpected size % instead of 8", it.type.runtime_size);
                case "offset";
                    assert(it.offset_in_bytes == 48, "CompilationMessage.offset has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationMessage.offset has unexpected size % instead of 8", it.type.runtime_size);
                case "length";
                    assert(it.offset_in_bytes == 56, "CompilationMessage.length has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationMessage.length has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(CompilationMessage) == 64, "CompilationMessage has size % instead of 64", size_of(CompilationMessage));
    }

    {
        info := type_info(ComputePassTimestampWrites);
        for info.members {
            if it.name == {
                case "querySet";
                    assert(it.offset_in_bytes == 0, "ComputePassTimestampWrites.querySet has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ComputePassTimestampWrites.querySet has unexpected size % instead of 8", it.type.runtime_size);
                case "beginningOfPassWriteIndex";
                    assert(it.offset_in_bytes == 8, "ComputePassTimestampWrites.beginningOfPassWriteIndex has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ComputePassTimestampWrites.beginningOfPassWriteIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "endOfPassWriteIndex";
                    assert(it.offset_in_bytes == 12, "ComputePassTimestampWrites.endOfPassWriteIndex has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ComputePassTimestampWrites.endOfPassWriteIndex has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(ComputePassTimestampWrites) == 16, "ComputePassTimestampWrites has size % instead of 16", size_of(ComputePassTimestampWrites));
    }

    {
        info := type_info(ConstantEntry);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "ConstantEntry.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ConstantEntry.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "key";
                    assert(it.offset_in_bytes == 8, "ConstantEntry.key has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ConstantEntry.key has unexpected size % instead of 16", it.type.runtime_size);
                case "value";
                    assert(it.offset_in_bytes == 24, "ConstantEntry.value has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ConstantEntry.value has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ConstantEntry) == 32, "ConstantEntry has size % instead of 32", size_of(ConstantEntry));
    }

    {
        info := type_info(Extent3D);
        for info.members {
            if it.name == {
                case "width";
                    assert(it.offset_in_bytes == 0, "Extent3D.width has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Extent3D.width has unexpected size % instead of 4", it.type.runtime_size);
                case "height";
                    assert(it.offset_in_bytes == 4, "Extent3D.height has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Extent3D.height has unexpected size % instead of 4", it.type.runtime_size);
                case "depthOrArrayLayers";
                    assert(it.offset_in_bytes == 8, "Extent3D.depthOrArrayLayers has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Extent3D.depthOrArrayLayers has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(Extent3D) == 12, "Extent3D has size % instead of 12", size_of(Extent3D));
    }

    {
        info := type_info(Future);
        for info.members {
            if it.name == {
                case "id";
                    assert(it.offset_in_bytes == 0, "Future.id has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Future.id has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(Future) == 8, "Future has size % instead of 8", size_of(Future));
    }

    {
        info := type_info(InstanceCapabilities);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "InstanceCapabilities.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceCapabilities.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "timedWaitAnyEnable";
                    assert(it.offset_in_bytes == 8, "InstanceCapabilities.timedWaitAnyEnable has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "InstanceCapabilities.timedWaitAnyEnable has unexpected size % instead of 4", it.type.runtime_size);
                case "timedWaitAnyMaxCount";
                    assert(it.offset_in_bytes == 16, "InstanceCapabilities.timedWaitAnyMaxCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceCapabilities.timedWaitAnyMaxCount has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(InstanceCapabilities) == 24, "InstanceCapabilities has size % instead of 24", size_of(InstanceCapabilities));
    }

    {
        info := type_info(Limits);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "Limits.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Limits.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "maxTextureDimension1D";
                    assert(it.offset_in_bytes == 8, "Limits.maxTextureDimension1D has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxTextureDimension1D has unexpected size % instead of 4", it.type.runtime_size);
                case "maxTextureDimension2D";
                    assert(it.offset_in_bytes == 12, "Limits.maxTextureDimension2D has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxTextureDimension2D has unexpected size % instead of 4", it.type.runtime_size);
                case "maxTextureDimension3D";
                    assert(it.offset_in_bytes == 16, "Limits.maxTextureDimension3D has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxTextureDimension3D has unexpected size % instead of 4", it.type.runtime_size);
                case "maxTextureArrayLayers";
                    assert(it.offset_in_bytes == 20, "Limits.maxTextureArrayLayers has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxTextureArrayLayers has unexpected size % instead of 4", it.type.runtime_size);
                case "maxBindGroups";
                    assert(it.offset_in_bytes == 24, "Limits.maxBindGroups has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxBindGroups has unexpected size % instead of 4", it.type.runtime_size);
                case "maxBindGroupsPlusVertexBuffers";
                    assert(it.offset_in_bytes == 28, "Limits.maxBindGroupsPlusVertexBuffers has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxBindGroupsPlusVertexBuffers has unexpected size % instead of 4", it.type.runtime_size);
                case "maxBindingsPerBindGroup";
                    assert(it.offset_in_bytes == 32, "Limits.maxBindingsPerBindGroup has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxBindingsPerBindGroup has unexpected size % instead of 4", it.type.runtime_size);
                case "maxDynamicUniformBuffersPerPipelineLayout";
                    assert(it.offset_in_bytes == 36, "Limits.maxDynamicUniformBuffersPerPipelineLayout has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxDynamicUniformBuffersPerPipelineLayout has unexpected size % instead of 4", it.type.runtime_size);
                case "maxDynamicStorageBuffersPerPipelineLayout";
                    assert(it.offset_in_bytes == 40, "Limits.maxDynamicStorageBuffersPerPipelineLayout has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxDynamicStorageBuffersPerPipelineLayout has unexpected size % instead of 4", it.type.runtime_size);
                case "maxSampledTexturesPerShaderStage";
                    assert(it.offset_in_bytes == 44, "Limits.maxSampledTexturesPerShaderStage has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxSampledTexturesPerShaderStage has unexpected size % instead of 4", it.type.runtime_size);
                case "maxSamplersPerShaderStage";
                    assert(it.offset_in_bytes == 48, "Limits.maxSamplersPerShaderStage has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxSamplersPerShaderStage has unexpected size % instead of 4", it.type.runtime_size);
                case "maxStorageBuffersPerShaderStage";
                    assert(it.offset_in_bytes == 52, "Limits.maxStorageBuffersPerShaderStage has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxStorageBuffersPerShaderStage has unexpected size % instead of 4", it.type.runtime_size);
                case "maxStorageTexturesPerShaderStage";
                    assert(it.offset_in_bytes == 56, "Limits.maxStorageTexturesPerShaderStage has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxStorageTexturesPerShaderStage has unexpected size % instead of 4", it.type.runtime_size);
                case "maxUniformBuffersPerShaderStage";
                    assert(it.offset_in_bytes == 60, "Limits.maxUniformBuffersPerShaderStage has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxUniformBuffersPerShaderStage has unexpected size % instead of 4", it.type.runtime_size);
                case "maxUniformBufferBindingSize";
                    assert(it.offset_in_bytes == 64, "Limits.maxUniformBufferBindingSize has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Limits.maxUniformBufferBindingSize has unexpected size % instead of 8", it.type.runtime_size);
                case "maxStorageBufferBindingSize";
                    assert(it.offset_in_bytes == 72, "Limits.maxStorageBufferBindingSize has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Limits.maxStorageBufferBindingSize has unexpected size % instead of 8", it.type.runtime_size);
                case "minUniformBufferOffsetAlignment";
                    assert(it.offset_in_bytes == 80, "Limits.minUniformBufferOffsetAlignment has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.minUniformBufferOffsetAlignment has unexpected size % instead of 4", it.type.runtime_size);
                case "minStorageBufferOffsetAlignment";
                    assert(it.offset_in_bytes == 84, "Limits.minStorageBufferOffsetAlignment has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.minStorageBufferOffsetAlignment has unexpected size % instead of 4", it.type.runtime_size);
                case "maxVertexBuffers";
                    assert(it.offset_in_bytes == 88, "Limits.maxVertexBuffers has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxVertexBuffers has unexpected size % instead of 4", it.type.runtime_size);
                case "maxBufferSize";
                    assert(it.offset_in_bytes == 96, "Limits.maxBufferSize has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "Limits.maxBufferSize has unexpected size % instead of 8", it.type.runtime_size);
                case "maxVertexAttributes";
                    assert(it.offset_in_bytes == 104, "Limits.maxVertexAttributes has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxVertexAttributes has unexpected size % instead of 4", it.type.runtime_size);
                case "maxVertexBufferArrayStride";
                    assert(it.offset_in_bytes == 108, "Limits.maxVertexBufferArrayStride has unexpected offset % instead of 108", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxVertexBufferArrayStride has unexpected size % instead of 4", it.type.runtime_size);
                case "maxInterStageShaderVariables";
                    assert(it.offset_in_bytes == 112, "Limits.maxInterStageShaderVariables has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxInterStageShaderVariables has unexpected size % instead of 4", it.type.runtime_size);
                case "maxColorAttachments";
                    assert(it.offset_in_bytes == 116, "Limits.maxColorAttachments has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxColorAttachments has unexpected size % instead of 4", it.type.runtime_size);
                case "maxColorAttachmentBytesPerSample";
                    assert(it.offset_in_bytes == 120, "Limits.maxColorAttachmentBytesPerSample has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxColorAttachmentBytesPerSample has unexpected size % instead of 4", it.type.runtime_size);
                case "maxComputeWorkgroupStorageSize";
                    assert(it.offset_in_bytes == 124, "Limits.maxComputeWorkgroupStorageSize has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxComputeWorkgroupStorageSize has unexpected size % instead of 4", it.type.runtime_size);
                case "maxComputeInvocationsPerWorkgroup";
                    assert(it.offset_in_bytes == 128, "Limits.maxComputeInvocationsPerWorkgroup has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxComputeInvocationsPerWorkgroup has unexpected size % instead of 4", it.type.runtime_size);
                case "maxComputeWorkgroupSizeX";
                    assert(it.offset_in_bytes == 132, "Limits.maxComputeWorkgroupSizeX has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxComputeWorkgroupSizeX has unexpected size % instead of 4", it.type.runtime_size);
                case "maxComputeWorkgroupSizeY";
                    assert(it.offset_in_bytes == 136, "Limits.maxComputeWorkgroupSizeY has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxComputeWorkgroupSizeY has unexpected size % instead of 4", it.type.runtime_size);
                case "maxComputeWorkgroupSizeZ";
                    assert(it.offset_in_bytes == 140, "Limits.maxComputeWorkgroupSizeZ has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxComputeWorkgroupSizeZ has unexpected size % instead of 4", it.type.runtime_size);
                case "maxComputeWorkgroupsPerDimension";
                    assert(it.offset_in_bytes == 144, "Limits.maxComputeWorkgroupsPerDimension has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Limits.maxComputeWorkgroupsPerDimension has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(Limits) == 152, "Limits has size % instead of 152", size_of(Limits));
    }

    {
        info := type_info(MultisampleState);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "MultisampleState.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "MultisampleState.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 8, "MultisampleState.count has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "MultisampleState.count has unexpected size % instead of 4", it.type.runtime_size);
                case "mask";
                    assert(it.offset_in_bytes == 12, "MultisampleState.mask has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "MultisampleState.mask has unexpected size % instead of 4", it.type.runtime_size);
                case "alphaToCoverageEnabled";
                    assert(it.offset_in_bytes == 16, "MultisampleState.alphaToCoverageEnabled has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "MultisampleState.alphaToCoverageEnabled has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(MultisampleState) == 24, "MultisampleState has size % instead of 24", size_of(MultisampleState));
    }

    {
        info := type_info(Origin3D);
        for info.members {
            if it.name == {
                case "x";
                    assert(it.offset_in_bytes == 0, "Origin3D.x has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Origin3D.x has unexpected size % instead of 4", it.type.runtime_size);
                case "y";
                    assert(it.offset_in_bytes == 4, "Origin3D.y has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Origin3D.y has unexpected size % instead of 4", it.type.runtime_size);
                case "z";
                    assert(it.offset_in_bytes == 8, "Origin3D.z has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "Origin3D.z has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(Origin3D) == 12, "Origin3D has size % instead of 12", size_of(Origin3D));
    }

    {
        info := type_info(PipelineLayoutDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "PipelineLayoutDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PipelineLayoutDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "PipelineLayoutDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "PipelineLayoutDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "bindGroupLayoutCount";
                    assert(it.offset_in_bytes == 24, "PipelineLayoutDescriptor.bindGroupLayoutCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PipelineLayoutDescriptor.bindGroupLayoutCount has unexpected size % instead of 8", it.type.runtime_size);
                case "bindGroupLayouts";
                    assert(it.offset_in_bytes == 32, "PipelineLayoutDescriptor.bindGroupLayouts has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PipelineLayoutDescriptor.bindGroupLayouts has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(PipelineLayoutDescriptor) == 40, "PipelineLayoutDescriptor has size % instead of 40", size_of(PipelineLayoutDescriptor));
    }

    {
        info := type_info(PrimitiveState);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "PrimitiveState.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PrimitiveState.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "topology";
                    assert(it.offset_in_bytes == 8, "PrimitiveState.topology has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PrimitiveState.topology has unexpected size % instead of 4", it.type.runtime_size);
                case "stripIndexFormat";
                    assert(it.offset_in_bytes == 12, "PrimitiveState.stripIndexFormat has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PrimitiveState.stripIndexFormat has unexpected size % instead of 4", it.type.runtime_size);
                case "frontFace";
                    assert(it.offset_in_bytes == 16, "PrimitiveState.frontFace has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PrimitiveState.frontFace has unexpected size % instead of 4", it.type.runtime_size);
                case "cullMode";
                    assert(it.offset_in_bytes == 20, "PrimitiveState.cullMode has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PrimitiveState.cullMode has unexpected size % instead of 4", it.type.runtime_size);
                case "unclippedDepth";
                    assert(it.offset_in_bytes == 24, "PrimitiveState.unclippedDepth has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PrimitiveState.unclippedDepth has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(PrimitiveState) == 32, "PrimitiveState has size % instead of 32", size_of(PrimitiveState));
    }

    {
        info := type_info(QuerySetDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "QuerySetDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QuerySetDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "QuerySetDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "QuerySetDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 24, "QuerySetDescriptor.type has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "QuerySetDescriptor.type has unexpected size % instead of 4", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 28, "QuerySetDescriptor.count has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "QuerySetDescriptor.count has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(QuerySetDescriptor) == 32, "QuerySetDescriptor has size % instead of 32", size_of(QuerySetDescriptor));
    }

    {
        info := type_info(QueueDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "QueueDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QueueDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "QueueDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "QueueDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(QueueDescriptor) == 24, "QueueDescriptor has size % instead of 24", size_of(QueueDescriptor));
    }

    {
        info := type_info(RenderBundleDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RenderBundleDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderBundleDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "RenderBundleDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "RenderBundleDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(RenderBundleDescriptor) == 24, "RenderBundleDescriptor has size % instead of 24", size_of(RenderBundleDescriptor));
    }

    {
        info := type_info(RenderBundleEncoderDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RenderBundleEncoderDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderBundleEncoderDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "RenderBundleEncoderDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "RenderBundleEncoderDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "colorFormatCount";
                    assert(it.offset_in_bytes == 24, "RenderBundleEncoderDescriptor.colorFormatCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderBundleEncoderDescriptor.colorFormatCount has unexpected size % instead of 8", it.type.runtime_size);
                case "colorFormats";
                    assert(it.offset_in_bytes == 32, "RenderBundleEncoderDescriptor.colorFormats has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderBundleEncoderDescriptor.colorFormats has unexpected size % instead of 8", it.type.runtime_size);
                case "depthStencilFormat";
                    assert(it.offset_in_bytes == 40, "RenderBundleEncoderDescriptor.depthStencilFormat has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderBundleEncoderDescriptor.depthStencilFormat has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleCount";
                    assert(it.offset_in_bytes == 44, "RenderBundleEncoderDescriptor.sampleCount has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderBundleEncoderDescriptor.sampleCount has unexpected size % instead of 4", it.type.runtime_size);
                case "depthReadOnly";
                    assert(it.offset_in_bytes == 48, "RenderBundleEncoderDescriptor.depthReadOnly has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderBundleEncoderDescriptor.depthReadOnly has unexpected size % instead of 4", it.type.runtime_size);
                case "stencilReadOnly";
                    assert(it.offset_in_bytes == 52, "RenderBundleEncoderDescriptor.stencilReadOnly has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderBundleEncoderDescriptor.stencilReadOnly has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(RenderBundleEncoderDescriptor) == 56, "RenderBundleEncoderDescriptor has size % instead of 56", size_of(RenderBundleEncoderDescriptor));
    }

    {
        info := type_info(RenderPassDepthStencilAttachment);
        for info.members {
            if it.name == {
                case "view";
                    assert(it.offset_in_bytes == 0, "RenderPassDepthStencilAttachment.view has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassDepthStencilAttachment.view has unexpected size % instead of 8", it.type.runtime_size);
                case "depthLoadOp";
                    assert(it.offset_in_bytes == 8, "RenderPassDepthStencilAttachment.depthLoadOp has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.depthLoadOp has unexpected size % instead of 4", it.type.runtime_size);
                case "depthStoreOp";
                    assert(it.offset_in_bytes == 12, "RenderPassDepthStencilAttachment.depthStoreOp has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.depthStoreOp has unexpected size % instead of 4", it.type.runtime_size);
                case "depthClearValue";
                    assert(it.offset_in_bytes == 16, "RenderPassDepthStencilAttachment.depthClearValue has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.depthClearValue has unexpected size % instead of 4", it.type.runtime_size);
                case "depthReadOnly";
                    assert(it.offset_in_bytes == 20, "RenderPassDepthStencilAttachment.depthReadOnly has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.depthReadOnly has unexpected size % instead of 4", it.type.runtime_size);
                case "stencilLoadOp";
                    assert(it.offset_in_bytes == 24, "RenderPassDepthStencilAttachment.stencilLoadOp has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.stencilLoadOp has unexpected size % instead of 4", it.type.runtime_size);
                case "stencilStoreOp";
                    assert(it.offset_in_bytes == 28, "RenderPassDepthStencilAttachment.stencilStoreOp has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.stencilStoreOp has unexpected size % instead of 4", it.type.runtime_size);
                case "stencilClearValue";
                    assert(it.offset_in_bytes == 32, "RenderPassDepthStencilAttachment.stencilClearValue has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.stencilClearValue has unexpected size % instead of 4", it.type.runtime_size);
                case "stencilReadOnly";
                    assert(it.offset_in_bytes == 36, "RenderPassDepthStencilAttachment.stencilReadOnly has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassDepthStencilAttachment.stencilReadOnly has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(RenderPassDepthStencilAttachment) == 40, "RenderPassDepthStencilAttachment has size % instead of 40", size_of(RenderPassDepthStencilAttachment));
    }

    {
        info := type_info(RenderPassMaxDrawCount);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "RenderPassMaxDrawCount.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "RenderPassMaxDrawCount.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "maxDrawCount";
                    assert(it.offset_in_bytes == 16, "RenderPassMaxDrawCount.maxDrawCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassMaxDrawCount.maxDrawCount has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RenderPassMaxDrawCount) == 24, "RenderPassMaxDrawCount has size % instead of 24", size_of(RenderPassMaxDrawCount));
    }

    {
        info := type_info(RenderPassTimestampWrites);
        for info.members {
            if it.name == {
                case "querySet";
                    assert(it.offset_in_bytes == 0, "RenderPassTimestampWrites.querySet has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassTimestampWrites.querySet has unexpected size % instead of 8", it.type.runtime_size);
                case "beginningOfPassWriteIndex";
                    assert(it.offset_in_bytes == 8, "RenderPassTimestampWrites.beginningOfPassWriteIndex has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassTimestampWrites.beginningOfPassWriteIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "endOfPassWriteIndex";
                    assert(it.offset_in_bytes == 12, "RenderPassTimestampWrites.endOfPassWriteIndex has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassTimestampWrites.endOfPassWriteIndex has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(RenderPassTimestampWrites) == 16, "RenderPassTimestampWrites has size % instead of 16", size_of(RenderPassTimestampWrites));
    }

    {
        info := type_info(RequestAdapterOptions);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RequestAdapterOptions.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestAdapterOptions.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "featureLevel";
                    assert(it.offset_in_bytes == 8, "RequestAdapterOptions.featureLevel has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RequestAdapterOptions.featureLevel has unexpected size % instead of 4", it.type.runtime_size);
                case "powerPreference";
                    assert(it.offset_in_bytes == 12, "RequestAdapterOptions.powerPreference has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RequestAdapterOptions.powerPreference has unexpected size % instead of 4", it.type.runtime_size);
                case "forceFallbackAdapter";
                    assert(it.offset_in_bytes == 16, "RequestAdapterOptions.forceFallbackAdapter has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RequestAdapterOptions.forceFallbackAdapter has unexpected size % instead of 4", it.type.runtime_size);
                case "backendType";
                    assert(it.offset_in_bytes == 20, "RequestAdapterOptions.backendType has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RequestAdapterOptions.backendType has unexpected size % instead of 4", it.type.runtime_size);
                case "compatibleSurface";
                    assert(it.offset_in_bytes == 24, "RequestAdapterOptions.compatibleSurface has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RequestAdapterOptions.compatibleSurface has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RequestAdapterOptions) == 32, "RequestAdapterOptions has size % instead of 32", size_of(RequestAdapterOptions));
    }

    {
        info := type_info(SamplerBindingLayout);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "SamplerBindingLayout.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SamplerBindingLayout.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 8, "SamplerBindingLayout.type has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerBindingLayout.type has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SamplerBindingLayout) == 16, "SamplerBindingLayout has size % instead of 16", size_of(SamplerBindingLayout));
    }

    {
        info := type_info(SamplerDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "SamplerDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SamplerDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "SamplerDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SamplerDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "addressModeU";
                    assert(it.offset_in_bytes == 24, "SamplerDescriptor.addressModeU has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.addressModeU has unexpected size % instead of 4", it.type.runtime_size);
                case "addressModeV";
                    assert(it.offset_in_bytes == 28, "SamplerDescriptor.addressModeV has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.addressModeV has unexpected size % instead of 4", it.type.runtime_size);
                case "addressModeW";
                    assert(it.offset_in_bytes == 32, "SamplerDescriptor.addressModeW has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.addressModeW has unexpected size % instead of 4", it.type.runtime_size);
                case "magFilter";
                    assert(it.offset_in_bytes == 36, "SamplerDescriptor.magFilter has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.magFilter has unexpected size % instead of 4", it.type.runtime_size);
                case "minFilter";
                    assert(it.offset_in_bytes == 40, "SamplerDescriptor.minFilter has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.minFilter has unexpected size % instead of 4", it.type.runtime_size);
                case "mipmapFilter";
                    assert(it.offset_in_bytes == 44, "SamplerDescriptor.mipmapFilter has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.mipmapFilter has unexpected size % instead of 4", it.type.runtime_size);
                case "lodMinClamp";
                    assert(it.offset_in_bytes == 48, "SamplerDescriptor.lodMinClamp has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.lodMinClamp has unexpected size % instead of 4", it.type.runtime_size);
                case "lodMaxClamp";
                    assert(it.offset_in_bytes == 52, "SamplerDescriptor.lodMaxClamp has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.lodMaxClamp has unexpected size % instead of 4", it.type.runtime_size);
                case "compare";
                    assert(it.offset_in_bytes == 56, "SamplerDescriptor.compare has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SamplerDescriptor.compare has unexpected size % instead of 4", it.type.runtime_size);
                case "maxAnisotropy";
                    assert(it.offset_in_bytes == 60, "SamplerDescriptor.maxAnisotropy has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "SamplerDescriptor.maxAnisotropy has unexpected size % instead of 2", it.type.runtime_size);
            }
        }
        assert(size_of(SamplerDescriptor) == 64, "SamplerDescriptor has size % instead of 64", size_of(SamplerDescriptor));
    }

    {
        info := type_info(ShaderModuleDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "ShaderModuleDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ShaderModuleDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "ShaderModuleDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderModuleDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(ShaderModuleDescriptor) == 24, "ShaderModuleDescriptor has size % instead of 24", size_of(ShaderModuleDescriptor));
    }

    {
        info := type_info(ShaderSourceSPIRV);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "ShaderSourceSPIRV.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderSourceSPIRV.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "codeSize";
                    assert(it.offset_in_bytes == 16, "ShaderSourceSPIRV.codeSize has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ShaderSourceSPIRV.codeSize has unexpected size % instead of 4", it.type.runtime_size);
                case "code";
                    assert(it.offset_in_bytes == 24, "ShaderSourceSPIRV.code has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ShaderSourceSPIRV.code has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ShaderSourceSPIRV) == 32, "ShaderSourceSPIRV has size % instead of 32", size_of(ShaderSourceSPIRV));
    }

    {
        info := type_info(ShaderSourceWGSL);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "ShaderSourceWGSL.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderSourceWGSL.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "code";
                    assert(it.offset_in_bytes == 16, "ShaderSourceWGSL.code has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderSourceWGSL.code has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(ShaderSourceWGSL) == 32, "ShaderSourceWGSL has size % instead of 32", size_of(ShaderSourceWGSL));
    }

    {
        info := type_info(StencilFaceState);
        for info.members {
            if it.name == {
                case "compare";
                    assert(it.offset_in_bytes == 0, "StencilFaceState.compare has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "StencilFaceState.compare has unexpected size % instead of 4", it.type.runtime_size);
                case "failOp";
                    assert(it.offset_in_bytes == 4, "StencilFaceState.failOp has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "StencilFaceState.failOp has unexpected size % instead of 4", it.type.runtime_size);
                case "depthFailOp";
                    assert(it.offset_in_bytes == 8, "StencilFaceState.depthFailOp has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "StencilFaceState.depthFailOp has unexpected size % instead of 4", it.type.runtime_size);
                case "passOp";
                    assert(it.offset_in_bytes == 12, "StencilFaceState.passOp has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "StencilFaceState.passOp has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(StencilFaceState) == 16, "StencilFaceState has size % instead of 16", size_of(StencilFaceState));
    }

    {
        info := type_info(StorageTextureBindingLayout);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "StorageTextureBindingLayout.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "StorageTextureBindingLayout.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "access";
                    assert(it.offset_in_bytes == 8, "StorageTextureBindingLayout.access has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "StorageTextureBindingLayout.access has unexpected size % instead of 4", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 12, "StorageTextureBindingLayout.format has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "StorageTextureBindingLayout.format has unexpected size % instead of 4", it.type.runtime_size);
                case "viewDimension";
                    assert(it.offset_in_bytes == 16, "StorageTextureBindingLayout.viewDimension has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "StorageTextureBindingLayout.viewDimension has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(StorageTextureBindingLayout) == 24, "StorageTextureBindingLayout has size % instead of 24", size_of(StorageTextureBindingLayout));
    }

    {
        info := type_info(SupportedFeatures);
        for info.members {
            if it.name == {
                case "featureCount";
                    assert(it.offset_in_bytes == 0, "SupportedFeatures.featureCount has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SupportedFeatures.featureCount has unexpected size % instead of 8", it.type.runtime_size);
                case "features";
                    assert(it.offset_in_bytes == 8, "SupportedFeatures.features has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SupportedFeatures.features has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SupportedFeatures) == 16, "SupportedFeatures has size % instead of 16", size_of(SupportedFeatures));
    }

    {
        info := type_info(SupportedWGSLLanguageFeatures);
        for info.members {
            if it.name == {
                case "featureCount";
                    assert(it.offset_in_bytes == 0, "SupportedWGSLLanguageFeatures.featureCount has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SupportedWGSLLanguageFeatures.featureCount has unexpected size % instead of 8", it.type.runtime_size);
                case "features";
                    assert(it.offset_in_bytes == 8, "SupportedWGSLLanguageFeatures.features has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SupportedWGSLLanguageFeatures.features has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SupportedWGSLLanguageFeatures) == 16, "SupportedWGSLLanguageFeatures has size % instead of 16", size_of(SupportedWGSLLanguageFeatures));
    }

    {
        info := type_info(SurfaceCapabilities);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "SurfaceCapabilities.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "usages";
                    assert(it.offset_in_bytes == 8, "SurfaceCapabilities.usages has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.usages has unexpected size % instead of 8", it.type.runtime_size);
                case "formatCount";
                    assert(it.offset_in_bytes == 16, "SurfaceCapabilities.formatCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.formatCount has unexpected size % instead of 8", it.type.runtime_size);
                case "formats";
                    assert(it.offset_in_bytes == 24, "SurfaceCapabilities.formats has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.formats has unexpected size % instead of 8", it.type.runtime_size);
                case "presentModeCount";
                    assert(it.offset_in_bytes == 32, "SurfaceCapabilities.presentModeCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.presentModeCount has unexpected size % instead of 8", it.type.runtime_size);
                case "presentModes";
                    assert(it.offset_in_bytes == 40, "SurfaceCapabilities.presentModes has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.presentModes has unexpected size % instead of 8", it.type.runtime_size);
                case "alphaModeCount";
                    assert(it.offset_in_bytes == 48, "SurfaceCapabilities.alphaModeCount has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.alphaModeCount has unexpected size % instead of 8", it.type.runtime_size);
                case "alphaModes";
                    assert(it.offset_in_bytes == 56, "SurfaceCapabilities.alphaModes has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceCapabilities.alphaModes has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceCapabilities) == 64, "SurfaceCapabilities has size % instead of 64", size_of(SurfaceCapabilities));
    }

    {
        info := type_info(SurfaceConfiguration);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "SurfaceConfiguration.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceConfiguration.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "device";
                    assert(it.offset_in_bytes == 8, "SurfaceConfiguration.device has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceConfiguration.device has unexpected size % instead of 8", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 16, "SurfaceConfiguration.format has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceConfiguration.format has unexpected size % instead of 4", it.type.runtime_size);
                case "usage";
                    assert(it.offset_in_bytes == 24, "SurfaceConfiguration.usage has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceConfiguration.usage has unexpected size % instead of 8", it.type.runtime_size);
                case "width";
                    assert(it.offset_in_bytes == 32, "SurfaceConfiguration.width has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceConfiguration.width has unexpected size % instead of 4", it.type.runtime_size);
                case "height";
                    assert(it.offset_in_bytes == 36, "SurfaceConfiguration.height has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceConfiguration.height has unexpected size % instead of 4", it.type.runtime_size);
                case "viewFormatCount";
                    assert(it.offset_in_bytes == 40, "SurfaceConfiguration.viewFormatCount has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceConfiguration.viewFormatCount has unexpected size % instead of 8", it.type.runtime_size);
                case "viewFormats";
                    assert(it.offset_in_bytes == 48, "SurfaceConfiguration.viewFormats has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceConfiguration.viewFormats has unexpected size % instead of 8", it.type.runtime_size);
                case "alphaMode";
                    assert(it.offset_in_bytes == 56, "SurfaceConfiguration.alphaMode has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceConfiguration.alphaMode has unexpected size % instead of 4", it.type.runtime_size);
                case "presentMode";
                    assert(it.offset_in_bytes == 60, "SurfaceConfiguration.presentMode has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceConfiguration.presentMode has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceConfiguration) == 64, "SurfaceConfiguration has size % instead of 64", size_of(SurfaceConfiguration));
    }

    {
        info := type_info(SurfaceDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "SurfaceDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "SurfaceDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceDescriptor) == 24, "SurfaceDescriptor has size % instead of 24", size_of(SurfaceDescriptor));
    }

    {
        info := type_info(SurfaceSourceAndroidNativeWindow);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceSourceAndroidNativeWindow.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceSourceAndroidNativeWindow.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "window";
                    assert(it.offset_in_bytes == 16, "SurfaceSourceAndroidNativeWindow.window has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceAndroidNativeWindow.window has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceSourceAndroidNativeWindow) == 24, "SurfaceSourceAndroidNativeWindow has size % instead of 24", size_of(SurfaceSourceAndroidNativeWindow));
    }

    {
        info := type_info(SurfaceSourceMetalLayer);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceSourceMetalLayer.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceSourceMetalLayer.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "layer";
                    assert(it.offset_in_bytes == 16, "SurfaceSourceMetalLayer.layer has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceMetalLayer.layer has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceSourceMetalLayer) == 24, "SurfaceSourceMetalLayer has size % instead of 24", size_of(SurfaceSourceMetalLayer));
    }

    {
        info := type_info(SurfaceSourceWaylandSurface);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceSourceWaylandSurface.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceSourceWaylandSurface.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "display";
                    assert(it.offset_in_bytes == 16, "SurfaceSourceWaylandSurface.display has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceWaylandSurface.display has unexpected size % instead of 8", it.type.runtime_size);
                case "surface";
                    assert(it.offset_in_bytes == 24, "SurfaceSourceWaylandSurface.surface has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceWaylandSurface.surface has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceSourceWaylandSurface) == 32, "SurfaceSourceWaylandSurface has size % instead of 32", size_of(SurfaceSourceWaylandSurface));
    }

    {
        info := type_info(SurfaceSourceWindowsHWND);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceSourceWindowsHWND.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceSourceWindowsHWND.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "hinstance";
                    assert(it.offset_in_bytes == 16, "SurfaceSourceWindowsHWND.hinstance has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceWindowsHWND.hinstance has unexpected size % instead of 8", it.type.runtime_size);
                case "hwnd";
                    assert(it.offset_in_bytes == 24, "SurfaceSourceWindowsHWND.hwnd has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceWindowsHWND.hwnd has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceSourceWindowsHWND) == 32, "SurfaceSourceWindowsHWND has size % instead of 32", size_of(SurfaceSourceWindowsHWND));
    }

    {
        info := type_info(SurfaceSourceXCBWindow);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceSourceXCBWindow.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceSourceXCBWindow.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "connection";
                    assert(it.offset_in_bytes == 16, "SurfaceSourceXCBWindow.connection has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceXCBWindow.connection has unexpected size % instead of 8", it.type.runtime_size);
                case "window";
                    assert(it.offset_in_bytes == 24, "SurfaceSourceXCBWindow.window has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceSourceXCBWindow.window has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceSourceXCBWindow) == 32, "SurfaceSourceXCBWindow has size % instead of 32", size_of(SurfaceSourceXCBWindow));
    }

    {
        info := type_info(SurfaceSourceXlibWindow);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceSourceXlibWindow.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceSourceXlibWindow.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "display";
                    assert(it.offset_in_bytes == 16, "SurfaceSourceXlibWindow.display has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceXlibWindow.display has unexpected size % instead of 8", it.type.runtime_size);
                case "window";
                    assert(it.offset_in_bytes == 24, "SurfaceSourceXlibWindow.window has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceXlibWindow.window has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceSourceXlibWindow) == 32, "SurfaceSourceXlibWindow has size % instead of 32", size_of(SurfaceSourceXlibWindow));
    }

    {
        info := type_info(SurfaceTexture);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "SurfaceTexture.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceTexture.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "texture";
                    assert(it.offset_in_bytes == 8, "SurfaceTexture.texture has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceTexture.texture has unexpected size % instead of 8", it.type.runtime_size);
                case "status";
                    assert(it.offset_in_bytes == 16, "SurfaceTexture.status has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceTexture.status has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceTexture) == 24, "SurfaceTexture has size % instead of 24", size_of(SurfaceTexture));
    }

    {
        info := type_info(TexelCopyBufferLayout);
        for info.members {
            if it.name == {
                case "offset";
                    assert(it.offset_in_bytes == 0, "TexelCopyBufferLayout.offset has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TexelCopyBufferLayout.offset has unexpected size % instead of 8", it.type.runtime_size);
                case "bytesPerRow";
                    assert(it.offset_in_bytes == 8, "TexelCopyBufferLayout.bytesPerRow has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TexelCopyBufferLayout.bytesPerRow has unexpected size % instead of 4", it.type.runtime_size);
                case "rowsPerImage";
                    assert(it.offset_in_bytes == 12, "TexelCopyBufferLayout.rowsPerImage has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TexelCopyBufferLayout.rowsPerImage has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(TexelCopyBufferLayout) == 16, "TexelCopyBufferLayout has size % instead of 16", size_of(TexelCopyBufferLayout));
    }

    {
        info := type_info(TextureBindingLayout);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "TextureBindingLayout.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TextureBindingLayout.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "sampleType";
                    assert(it.offset_in_bytes == 8, "TextureBindingLayout.sampleType has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureBindingLayout.sampleType has unexpected size % instead of 4", it.type.runtime_size);
                case "viewDimension";
                    assert(it.offset_in_bytes == 12, "TextureBindingLayout.viewDimension has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureBindingLayout.viewDimension has unexpected size % instead of 4", it.type.runtime_size);
                case "multisampled";
                    assert(it.offset_in_bytes == 16, "TextureBindingLayout.multisampled has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureBindingLayout.multisampled has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(TextureBindingLayout) == 24, "TextureBindingLayout has size % instead of 24", size_of(TextureBindingLayout));
    }

    {
        info := type_info(TextureViewDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "TextureViewDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TextureViewDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "TextureViewDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "TextureViewDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 24, "TextureViewDescriptor.format has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureViewDescriptor.format has unexpected size % instead of 4", it.type.runtime_size);
                case "dimension";
                    assert(it.offset_in_bytes == 28, "TextureViewDescriptor.dimension has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureViewDescriptor.dimension has unexpected size % instead of 4", it.type.runtime_size);
                case "baseMipLevel";
                    assert(it.offset_in_bytes == 32, "TextureViewDescriptor.baseMipLevel has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureViewDescriptor.baseMipLevel has unexpected size % instead of 4", it.type.runtime_size);
                case "mipLevelCount";
                    assert(it.offset_in_bytes == 36, "TextureViewDescriptor.mipLevelCount has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureViewDescriptor.mipLevelCount has unexpected size % instead of 4", it.type.runtime_size);
                case "baseArrayLayer";
                    assert(it.offset_in_bytes == 40, "TextureViewDescriptor.baseArrayLayer has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureViewDescriptor.baseArrayLayer has unexpected size % instead of 4", it.type.runtime_size);
                case "arrayLayerCount";
                    assert(it.offset_in_bytes == 44, "TextureViewDescriptor.arrayLayerCount has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureViewDescriptor.arrayLayerCount has unexpected size % instead of 4", it.type.runtime_size);
                case "aspect";
                    assert(it.offset_in_bytes == 48, "TextureViewDescriptor.aspect has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureViewDescriptor.aspect has unexpected size % instead of 4", it.type.runtime_size);
                case "usage";
                    assert(it.offset_in_bytes == 56, "TextureViewDescriptor.usage has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TextureViewDescriptor.usage has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(TextureViewDescriptor) == 64, "TextureViewDescriptor has size % instead of 64", size_of(TextureViewDescriptor));
    }

    {
        info := type_info(VertexAttribute);
        for info.members {
            if it.name == {
                case "format";
                    assert(it.offset_in_bytes == 0, "VertexAttribute.format has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "VertexAttribute.format has unexpected size % instead of 4", it.type.runtime_size);
                case "offset";
                    assert(it.offset_in_bytes == 8, "VertexAttribute.offset has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexAttribute.offset has unexpected size % instead of 8", it.type.runtime_size);
                case "shaderLocation";
                    assert(it.offset_in_bytes == 16, "VertexAttribute.shaderLocation has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "VertexAttribute.shaderLocation has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(VertexAttribute) == 24, "VertexAttribute has size % instead of 24", size_of(VertexAttribute));
    }

    {
        info := type_info(BindGroupDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "BindGroupDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "BindGroupDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "BindGroupDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "layout";
                    assert(it.offset_in_bytes == 24, "BindGroupDescriptor.layout has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupDescriptor.layout has unexpected size % instead of 8", it.type.runtime_size);
                case "entryCount";
                    assert(it.offset_in_bytes == 32, "BindGroupDescriptor.entryCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupDescriptor.entryCount has unexpected size % instead of 8", it.type.runtime_size);
                case "entries";
                    assert(it.offset_in_bytes == 40, "BindGroupDescriptor.entries has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupDescriptor.entries has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(BindGroupDescriptor) == 48, "BindGroupDescriptor has size % instead of 48", size_of(BindGroupDescriptor));
    }

    {
        info := type_info(BindGroupLayoutEntry);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "BindGroupLayoutEntry.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupLayoutEntry.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "binding";
                    assert(it.offset_in_bytes == 8, "BindGroupLayoutEntry.binding has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BindGroupLayoutEntry.binding has unexpected size % instead of 4", it.type.runtime_size);
                case "visibility";
                    assert(it.offset_in_bytes == 16, "BindGroupLayoutEntry.visibility has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupLayoutEntry.visibility has unexpected size % instead of 8", it.type.runtime_size);
                case "buffer";
                    assert(it.offset_in_bytes == 24, "BindGroupLayoutEntry.buffer has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "BindGroupLayoutEntry.buffer has unexpected size % instead of 24", it.type.runtime_size);
                case "sampler";
                    assert(it.offset_in_bytes == 48, "BindGroupLayoutEntry.sampler has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "BindGroupLayoutEntry.sampler has unexpected size % instead of 16", it.type.runtime_size);
                case "texture";
                    assert(it.offset_in_bytes == 64, "BindGroupLayoutEntry.texture has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "BindGroupLayoutEntry.texture has unexpected size % instead of 24", it.type.runtime_size);
                case "storageTexture";
                    assert(it.offset_in_bytes == 88, "BindGroupLayoutEntry.storageTexture has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "BindGroupLayoutEntry.storageTexture has unexpected size % instead of 24", it.type.runtime_size);
            }
        }
        assert(size_of(BindGroupLayoutEntry) == 112, "BindGroupLayoutEntry has size % instead of 112", size_of(BindGroupLayoutEntry));
    }

    {
        info := type_info(BlendState);
        for info.members {
            if it.name == {
                case "color";
                    assert(it.offset_in_bytes == 0, "BlendState.color has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "BlendState.color has unexpected size % instead of 12", it.type.runtime_size);
                case "alpha";
                    assert(it.offset_in_bytes == 12, "BlendState.alpha has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "BlendState.alpha has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(BlendState) == 24, "BlendState has size % instead of 24", size_of(BlendState));
    }

    {
        info := type_info(CompilationInfo);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "CompilationInfo.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationInfo.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "messageCount";
                    assert(it.offset_in_bytes == 8, "CompilationInfo.messageCount has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationInfo.messageCount has unexpected size % instead of 8", it.type.runtime_size);
                case "messages";
                    assert(it.offset_in_bytes == 16, "CompilationInfo.messages has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "CompilationInfo.messages has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(CompilationInfo) == 24, "CompilationInfo has size % instead of 24", size_of(CompilationInfo));
    }

    {
        info := type_info(ComputePassDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "ComputePassDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ComputePassDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "ComputePassDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ComputePassDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "timestampWrites";
                    assert(it.offset_in_bytes == 24, "ComputePassDescriptor.timestampWrites has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ComputePassDescriptor.timestampWrites has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ComputePassDescriptor) == 32, "ComputePassDescriptor has size % instead of 32", size_of(ComputePassDescriptor));
    }

    {
        info := type_info(DepthStencilState);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "DepthStencilState.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DepthStencilState.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 8, "DepthStencilState.format has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.format has unexpected size % instead of 4", it.type.runtime_size);
                case "depthWriteEnabled";
                    assert(it.offset_in_bytes == 12, "DepthStencilState.depthWriteEnabled has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.depthWriteEnabled has unexpected size % instead of 4", it.type.runtime_size);
                case "depthCompare";
                    assert(it.offset_in_bytes == 16, "DepthStencilState.depthCompare has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.depthCompare has unexpected size % instead of 4", it.type.runtime_size);
                case "stencilFront";
                    assert(it.offset_in_bytes == 20, "DepthStencilState.stencilFront has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "DepthStencilState.stencilFront has unexpected size % instead of 16", it.type.runtime_size);
                case "stencilBack";
                    assert(it.offset_in_bytes == 36, "DepthStencilState.stencilBack has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "DepthStencilState.stencilBack has unexpected size % instead of 16", it.type.runtime_size);
                case "stencilReadMask";
                    assert(it.offset_in_bytes == 52, "DepthStencilState.stencilReadMask has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.stencilReadMask has unexpected size % instead of 4", it.type.runtime_size);
                case "stencilWriteMask";
                    assert(it.offset_in_bytes == 56, "DepthStencilState.stencilWriteMask has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.stencilWriteMask has unexpected size % instead of 4", it.type.runtime_size);
                case "depthBias";
                    assert(it.offset_in_bytes == 60, "DepthStencilState.depthBias has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.depthBias has unexpected size % instead of 4", it.type.runtime_size);
                case "depthBiasSlopeScale";
                    assert(it.offset_in_bytes == 64, "DepthStencilState.depthBiasSlopeScale has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.depthBiasSlopeScale has unexpected size % instead of 4", it.type.runtime_size);
                case "depthBiasClamp";
                    assert(it.offset_in_bytes == 68, "DepthStencilState.depthBiasClamp has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "DepthStencilState.depthBiasClamp has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(DepthStencilState) == 72, "DepthStencilState has size % instead of 72", size_of(DepthStencilState));
    }

    {
        info := type_info(DeviceDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "DeviceDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "DeviceDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "DeviceDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "requiredFeatureCount";
                    assert(it.offset_in_bytes == 24, "DeviceDescriptor.requiredFeatureCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceDescriptor.requiredFeatureCount has unexpected size % instead of 8", it.type.runtime_size);
                case "requiredFeatures";
                    assert(it.offset_in_bytes == 32, "DeviceDescriptor.requiredFeatures has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceDescriptor.requiredFeatures has unexpected size % instead of 8", it.type.runtime_size);
                case "requiredLimits";
                    assert(it.offset_in_bytes == 40, "DeviceDescriptor.requiredLimits has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "DeviceDescriptor.requiredLimits has unexpected size % instead of 8", it.type.runtime_size);
                case "defaultQueue";
                    assert(it.offset_in_bytes == 48, "DeviceDescriptor.defaultQueue has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "DeviceDescriptor.defaultQueue has unexpected size % instead of 24", it.type.runtime_size);
                case "deviceLostCallbackInfo";
                    assert(it.offset_in_bytes == 72, "DeviceDescriptor.deviceLostCallbackInfo has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "DeviceDescriptor.deviceLostCallbackInfo has unexpected size % instead of 40", it.type.runtime_size);
                case "uncapturedErrorCallbackInfo";
                    assert(it.offset_in_bytes == 112, "DeviceDescriptor.uncapturedErrorCallbackInfo has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "DeviceDescriptor.uncapturedErrorCallbackInfo has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(DeviceDescriptor) == 144, "DeviceDescriptor has size % instead of 144", size_of(DeviceDescriptor));
    }

    {
        info := type_info(FutureWaitInfo);
        for info.members {
            if it.name == {
                case "future";
                    assert(it.offset_in_bytes == 0, "FutureWaitInfo.future has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "FutureWaitInfo.future has unexpected size % instead of 8", it.type.runtime_size);
                case "completed";
                    assert(it.offset_in_bytes == 8, "FutureWaitInfo.completed has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "FutureWaitInfo.completed has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(FutureWaitInfo) == 16, "FutureWaitInfo has size % instead of 16", size_of(FutureWaitInfo));
    }

    {
        info := type_info(InstanceDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "InstanceDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "features";
                    assert(it.offset_in_bytes == 8, "InstanceDescriptor.features has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "InstanceDescriptor.features has unexpected size % instead of 24", it.type.runtime_size);
            }
        }
        assert(size_of(InstanceDescriptor) == 32, "InstanceDescriptor has size % instead of 32", size_of(InstanceDescriptor));
    }

    {
        info := type_info(ProgrammableStageDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "ProgrammableStageDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ProgrammableStageDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "module";
                    assert(it.offset_in_bytes == 8, "ProgrammableStageDescriptor.module has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ProgrammableStageDescriptor.module has unexpected size % instead of 8", it.type.runtime_size);
                case "entryPoint";
                    assert(it.offset_in_bytes == 16, "ProgrammableStageDescriptor.entryPoint has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ProgrammableStageDescriptor.entryPoint has unexpected size % instead of 16", it.type.runtime_size);
                case "constantCount";
                    assert(it.offset_in_bytes == 32, "ProgrammableStageDescriptor.constantCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ProgrammableStageDescriptor.constantCount has unexpected size % instead of 8", it.type.runtime_size);
                case "constants";
                    assert(it.offset_in_bytes == 40, "ProgrammableStageDescriptor.constants has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ProgrammableStageDescriptor.constants has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ProgrammableStageDescriptor) == 48, "ProgrammableStageDescriptor has size % instead of 48", size_of(ProgrammableStageDescriptor));
    }

    {
        info := type_info(RenderPassColorAttachment);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RenderPassColorAttachment.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassColorAttachment.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "view";
                    assert(it.offset_in_bytes == 8, "RenderPassColorAttachment.view has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassColorAttachment.view has unexpected size % instead of 8", it.type.runtime_size);
                case "depthSlice";
                    assert(it.offset_in_bytes == 16, "RenderPassColorAttachment.depthSlice has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassColorAttachment.depthSlice has unexpected size % instead of 4", it.type.runtime_size);
                case "resolveTarget";
                    assert(it.offset_in_bytes == 24, "RenderPassColorAttachment.resolveTarget has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassColorAttachment.resolveTarget has unexpected size % instead of 8", it.type.runtime_size);
                case "loadOp";
                    assert(it.offset_in_bytes == 32, "RenderPassColorAttachment.loadOp has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassColorAttachment.loadOp has unexpected size % instead of 4", it.type.runtime_size);
                case "storeOp";
                    assert(it.offset_in_bytes == 36, "RenderPassColorAttachment.storeOp has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "RenderPassColorAttachment.storeOp has unexpected size % instead of 4", it.type.runtime_size);
                case "clearValue";
                    assert(it.offset_in_bytes == 40, "RenderPassColorAttachment.clearValue has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "RenderPassColorAttachment.clearValue has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(RenderPassColorAttachment) == 72, "RenderPassColorAttachment has size % instead of 72", size_of(RenderPassColorAttachment));
    }

    {
        info := type_info(TexelCopyBufferInfo);
        for info.members {
            if it.name == {
                case "layout";
                    assert(it.offset_in_bytes == 0, "TexelCopyBufferInfo.layout has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "TexelCopyBufferInfo.layout has unexpected size % instead of 16", it.type.runtime_size);
                case "buffer";
                    assert(it.offset_in_bytes == 16, "TexelCopyBufferInfo.buffer has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TexelCopyBufferInfo.buffer has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(TexelCopyBufferInfo) == 24, "TexelCopyBufferInfo has size % instead of 24", size_of(TexelCopyBufferInfo));
    }

    {
        info := type_info(TexelCopyTextureInfo);
        for info.members {
            if it.name == {
                case "texture";
                    assert(it.offset_in_bytes == 0, "TexelCopyTextureInfo.texture has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TexelCopyTextureInfo.texture has unexpected size % instead of 8", it.type.runtime_size);
                case "mipLevel";
                    assert(it.offset_in_bytes == 8, "TexelCopyTextureInfo.mipLevel has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TexelCopyTextureInfo.mipLevel has unexpected size % instead of 4", it.type.runtime_size);
                case "origin";
                    assert(it.offset_in_bytes == 12, "TexelCopyTextureInfo.origin has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "TexelCopyTextureInfo.origin has unexpected size % instead of 12", it.type.runtime_size);
                case "aspect";
                    assert(it.offset_in_bytes == 24, "TexelCopyTextureInfo.aspect has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TexelCopyTextureInfo.aspect has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(TexelCopyTextureInfo) == 32, "TexelCopyTextureInfo has size % instead of 32", size_of(TexelCopyTextureInfo));
    }

    {
        info := type_info(TextureDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "TextureDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TextureDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "TextureDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "TextureDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "usage";
                    assert(it.offset_in_bytes == 24, "TextureDescriptor.usage has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TextureDescriptor.usage has unexpected size % instead of 8", it.type.runtime_size);
                case "dimension";
                    assert(it.offset_in_bytes == 32, "TextureDescriptor.dimension has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureDescriptor.dimension has unexpected size % instead of 4", it.type.runtime_size);
                case "size";
                    assert(it.offset_in_bytes == 36, "TextureDescriptor.size has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "TextureDescriptor.size has unexpected size % instead of 12", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 48, "TextureDescriptor.format has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureDescriptor.format has unexpected size % instead of 4", it.type.runtime_size);
                case "mipLevelCount";
                    assert(it.offset_in_bytes == 52, "TextureDescriptor.mipLevelCount has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureDescriptor.mipLevelCount has unexpected size % instead of 4", it.type.runtime_size);
                case "sampleCount";
                    assert(it.offset_in_bytes == 56, "TextureDescriptor.sampleCount has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "TextureDescriptor.sampleCount has unexpected size % instead of 4", it.type.runtime_size);
                case "viewFormatCount";
                    assert(it.offset_in_bytes == 64, "TextureDescriptor.viewFormatCount has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TextureDescriptor.viewFormatCount has unexpected size % instead of 8", it.type.runtime_size);
                case "viewFormats";
                    assert(it.offset_in_bytes == 72, "TextureDescriptor.viewFormats has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "TextureDescriptor.viewFormats has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(TextureDescriptor) == 80, "TextureDescriptor has size % instead of 80", size_of(TextureDescriptor));
    }

    {
        info := type_info(VertexBufferLayout);
        for info.members {
            if it.name == {
                case "stepMode";
                    assert(it.offset_in_bytes == 0, "VertexBufferLayout.stepMode has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "VertexBufferLayout.stepMode has unexpected size % instead of 4", it.type.runtime_size);
                case "arrayStride";
                    assert(it.offset_in_bytes == 8, "VertexBufferLayout.arrayStride has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexBufferLayout.arrayStride has unexpected size % instead of 8", it.type.runtime_size);
                case "attributeCount";
                    assert(it.offset_in_bytes == 16, "VertexBufferLayout.attributeCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexBufferLayout.attributeCount has unexpected size % instead of 8", it.type.runtime_size);
                case "attributes";
                    assert(it.offset_in_bytes == 24, "VertexBufferLayout.attributes has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexBufferLayout.attributes has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(VertexBufferLayout) == 32, "VertexBufferLayout has size % instead of 32", size_of(VertexBufferLayout));
    }

    {
        info := type_info(BindGroupLayoutDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "BindGroupLayoutDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupLayoutDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "BindGroupLayoutDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "BindGroupLayoutDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "entryCount";
                    assert(it.offset_in_bytes == 24, "BindGroupLayoutDescriptor.entryCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupLayoutDescriptor.entryCount has unexpected size % instead of 8", it.type.runtime_size);
                case "entries";
                    assert(it.offset_in_bytes == 32, "BindGroupLayoutDescriptor.entries has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupLayoutDescriptor.entries has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(BindGroupLayoutDescriptor) == 40, "BindGroupLayoutDescriptor has size % instead of 40", size_of(BindGroupLayoutDescriptor));
    }

    {
        info := type_info(ColorTargetState);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "ColorTargetState.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ColorTargetState.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "format";
                    assert(it.offset_in_bytes == 8, "ColorTargetState.format has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ColorTargetState.format has unexpected size % instead of 4", it.type.runtime_size);
                case "blend";
                    assert(it.offset_in_bytes == 16, "ColorTargetState.blend has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ColorTargetState.blend has unexpected size % instead of 8", it.type.runtime_size);
                case "writeMask";
                    assert(it.offset_in_bytes == 24, "ColorTargetState.writeMask has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ColorTargetState.writeMask has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ColorTargetState) == 32, "ColorTargetState has size % instead of 32", size_of(ColorTargetState));
    }

    {
        info := type_info(ComputePipelineDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "ComputePipelineDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ComputePipelineDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "ComputePipelineDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ComputePipelineDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "layout";
                    assert(it.offset_in_bytes == 24, "ComputePipelineDescriptor.layout has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ComputePipelineDescriptor.layout has unexpected size % instead of 8", it.type.runtime_size);
                case "compute";
                    assert(it.offset_in_bytes == 32, "ComputePipelineDescriptor.compute has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 48, "ComputePipelineDescriptor.compute has unexpected size % instead of 48", it.type.runtime_size);
            }
        }
        assert(size_of(ComputePipelineDescriptor) == 80, "ComputePipelineDescriptor has size % instead of 80", size_of(ComputePipelineDescriptor));
    }

    {
        info := type_info(RenderPassDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RenderPassDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "RenderPassDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "RenderPassDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "colorAttachmentCount";
                    assert(it.offset_in_bytes == 24, "RenderPassDescriptor.colorAttachmentCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassDescriptor.colorAttachmentCount has unexpected size % instead of 8", it.type.runtime_size);
                case "colorAttachments";
                    assert(it.offset_in_bytes == 32, "RenderPassDescriptor.colorAttachments has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassDescriptor.colorAttachments has unexpected size % instead of 8", it.type.runtime_size);
                case "depthStencilAttachment";
                    assert(it.offset_in_bytes == 40, "RenderPassDescriptor.depthStencilAttachment has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassDescriptor.depthStencilAttachment has unexpected size % instead of 8", it.type.runtime_size);
                case "occlusionQuerySet";
                    assert(it.offset_in_bytes == 48, "RenderPassDescriptor.occlusionQuerySet has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassDescriptor.occlusionQuerySet has unexpected size % instead of 8", it.type.runtime_size);
                case "timestampWrites";
                    assert(it.offset_in_bytes == 56, "RenderPassDescriptor.timestampWrites has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPassDescriptor.timestampWrites has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RenderPassDescriptor) == 64, "RenderPassDescriptor has size % instead of 64", size_of(RenderPassDescriptor));
    }

    {
        info := type_info(VertexState);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "VertexState.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexState.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "module";
                    assert(it.offset_in_bytes == 8, "VertexState.module has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexState.module has unexpected size % instead of 8", it.type.runtime_size);
                case "entryPoint";
                    assert(it.offset_in_bytes == 16, "VertexState.entryPoint has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "VertexState.entryPoint has unexpected size % instead of 16", it.type.runtime_size);
                case "constantCount";
                    assert(it.offset_in_bytes == 32, "VertexState.constantCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexState.constantCount has unexpected size % instead of 8", it.type.runtime_size);
                case "constants";
                    assert(it.offset_in_bytes == 40, "VertexState.constants has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexState.constants has unexpected size % instead of 8", it.type.runtime_size);
                case "bufferCount";
                    assert(it.offset_in_bytes == 48, "VertexState.bufferCount has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexState.bufferCount has unexpected size % instead of 8", it.type.runtime_size);
                case "buffers";
                    assert(it.offset_in_bytes == 56, "VertexState.buffers has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "VertexState.buffers has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(VertexState) == 64, "VertexState has size % instead of 64", size_of(VertexState));
    }

    {
        info := type_info(FragmentState);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "FragmentState.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "FragmentState.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "module";
                    assert(it.offset_in_bytes == 8, "FragmentState.module has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "FragmentState.module has unexpected size % instead of 8", it.type.runtime_size);
                case "entryPoint";
                    assert(it.offset_in_bytes == 16, "FragmentState.entryPoint has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "FragmentState.entryPoint has unexpected size % instead of 16", it.type.runtime_size);
                case "constantCount";
                    assert(it.offset_in_bytes == 32, "FragmentState.constantCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "FragmentState.constantCount has unexpected size % instead of 8", it.type.runtime_size);
                case "constants";
                    assert(it.offset_in_bytes == 40, "FragmentState.constants has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "FragmentState.constants has unexpected size % instead of 8", it.type.runtime_size);
                case "targetCount";
                    assert(it.offset_in_bytes == 48, "FragmentState.targetCount has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "FragmentState.targetCount has unexpected size % instead of 8", it.type.runtime_size);
                case "targets";
                    assert(it.offset_in_bytes == 56, "FragmentState.targets has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "FragmentState.targets has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(FragmentState) == 64, "FragmentState has size % instead of 64", size_of(FragmentState));
    }

    {
        info := type_info(RenderPipelineDescriptor);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "RenderPipelineDescriptor.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPipelineDescriptor.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "label";
                    assert(it.offset_in_bytes == 8, "RenderPipelineDescriptor.label has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "RenderPipelineDescriptor.label has unexpected size % instead of 16", it.type.runtime_size);
                case "layout";
                    assert(it.offset_in_bytes == 24, "RenderPipelineDescriptor.layout has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPipelineDescriptor.layout has unexpected size % instead of 8", it.type.runtime_size);
                case "vertex";
                    assert(it.offset_in_bytes == 32, "RenderPipelineDescriptor.vertex has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 64, "RenderPipelineDescriptor.vertex has unexpected size % instead of 64", it.type.runtime_size);
                case "primitive";
                    assert(it.offset_in_bytes == 96, "RenderPipelineDescriptor.primitive has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "RenderPipelineDescriptor.primitive has unexpected size % instead of 32", it.type.runtime_size);
                case "depthStencil";
                    assert(it.offset_in_bytes == 128, "RenderPipelineDescriptor.depthStencil has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPipelineDescriptor.depthStencil has unexpected size % instead of 8", it.type.runtime_size);
                case "multisample";
                    assert(it.offset_in_bytes == 136, "RenderPipelineDescriptor.multisample has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "RenderPipelineDescriptor.multisample has unexpected size % instead of 24", it.type.runtime_size);
                case "fragment";
                    assert(it.offset_in_bytes == 160, "RenderPipelineDescriptor.fragment has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RenderPipelineDescriptor.fragment has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RenderPipelineDescriptor) == 168, "RenderPipelineDescriptor has size % instead of 168", size_of(RenderPipelineDescriptor));
    }

    {
        info := type_info(InstanceExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "InstanceExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "InstanceExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "backends";
                    assert(it.offset_in_bytes == 16, "InstanceExtras.backends has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceExtras.backends has unexpected size % instead of 8", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 24, "InstanceExtras.flags has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceExtras.flags has unexpected size % instead of 8", it.type.runtime_size);
                case "dx12ShaderCompiler";
                    assert(it.offset_in_bytes == 32, "InstanceExtras.dx12ShaderCompiler has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "InstanceExtras.dx12ShaderCompiler has unexpected size % instead of 4", it.type.runtime_size);
                case "gles3MinorVersion";
                    assert(it.offset_in_bytes == 36, "InstanceExtras.gles3MinorVersion has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "InstanceExtras.gles3MinorVersion has unexpected size % instead of 4", it.type.runtime_size);
                case "glFenceBehaviour";
                    assert(it.offset_in_bytes == 40, "InstanceExtras.glFenceBehaviour has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "InstanceExtras.glFenceBehaviour has unexpected size % instead of 4", it.type.runtime_size);
                case "dxcPath";
                    assert(it.offset_in_bytes == 48, "InstanceExtras.dxcPath has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "InstanceExtras.dxcPath has unexpected size % instead of 16", it.type.runtime_size);
                case "dxcMaxShaderModel";
                    assert(it.offset_in_bytes == 64, "InstanceExtras.dxcMaxShaderModel has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "InstanceExtras.dxcMaxShaderModel has unexpected size % instead of 4", it.type.runtime_size);
                case "dx12PresentationSystem";
                    assert(it.offset_in_bytes == 68, "InstanceExtras.dx12PresentationSystem has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "InstanceExtras.dx12PresentationSystem has unexpected size % instead of 4", it.type.runtime_size);
                case "budgetForDeviceCreation";
                    assert(it.offset_in_bytes == 72, "InstanceExtras.budgetForDeviceCreation has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceExtras.budgetForDeviceCreation has unexpected size % instead of 8", it.type.runtime_size);
                case "budgetForDeviceLoss";
                    assert(it.offset_in_bytes == 80, "InstanceExtras.budgetForDeviceLoss has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceExtras.budgetForDeviceLoss has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(InstanceExtras) == 88, "InstanceExtras has size % instead of 88", size_of(InstanceExtras));
    }

    {
        info := type_info(DeviceExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "DeviceExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "DeviceExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "tracePath";
                    assert(it.offset_in_bytes == 16, "DeviceExtras.tracePath has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "DeviceExtras.tracePath has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(DeviceExtras) == 32, "DeviceExtras has size % instead of 32", size_of(DeviceExtras));
    }

    {
        info := type_info(NativeLimits);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "NativeLimits.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "NativeLimits.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "maxPushConstantSize";
                    assert(it.offset_in_bytes == 16, "NativeLimits.maxPushConstantSize has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "NativeLimits.maxPushConstantSize has unexpected size % instead of 4", it.type.runtime_size);
                case "maxNonSamplerBindings";
                    assert(it.offset_in_bytes == 20, "NativeLimits.maxNonSamplerBindings has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "NativeLimits.maxNonSamplerBindings has unexpected size % instead of 4", it.type.runtime_size);
                case "maxBindingArrayElementsPerShaderStage";
                    assert(it.offset_in_bytes == 24, "NativeLimits.maxBindingArrayElementsPerShaderStage has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "NativeLimits.maxBindingArrayElementsPerShaderStage has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(NativeLimits) == 32, "NativeLimits has size % instead of 32", size_of(NativeLimits));
    }

    {
        info := type_info(PushConstantRange);
        for info.members {
            if it.name == {
                case "stages";
                    assert(it.offset_in_bytes == 0, "PushConstantRange.stages has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PushConstantRange.stages has unexpected size % instead of 8", it.type.runtime_size);
                case "start";
                    assert(it.offset_in_bytes == 8, "PushConstantRange.start has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PushConstantRange.start has unexpected size % instead of 4", it.type.runtime_size);
                case "end";
                    assert(it.offset_in_bytes == 12, "PushConstantRange.end has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PushConstantRange.end has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(PushConstantRange) == 16, "PushConstantRange has size % instead of 16", size_of(PushConstantRange));
    }

    {
        info := type_info(PipelineLayoutExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "PipelineLayoutExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "PipelineLayoutExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "pushConstantRangeCount";
                    assert(it.offset_in_bytes == 16, "PipelineLayoutExtras.pushConstantRangeCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PipelineLayoutExtras.pushConstantRangeCount has unexpected size % instead of 8", it.type.runtime_size);
                case "pushConstantRanges";
                    assert(it.offset_in_bytes == 24, "PipelineLayoutExtras.pushConstantRanges has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "PipelineLayoutExtras.pushConstantRanges has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(PipelineLayoutExtras) == 32, "PipelineLayoutExtras has size % instead of 32", size_of(PipelineLayoutExtras));
    }

    {
        info := type_info(ShaderDefine);
        for info.members {
            if it.name == {
                case "name";
                    assert(it.offset_in_bytes == 0, "ShaderDefine.name has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderDefine.name has unexpected size % instead of 16", it.type.runtime_size);
                case "value";
                    assert(it.offset_in_bytes == 16, "ShaderDefine.value has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderDefine.value has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(ShaderDefine) == 32, "ShaderDefine has size % instead of 32", size_of(ShaderDefine));
    }

    {
        info := type_info(ShaderSourceGLSL);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "ShaderSourceGLSL.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderSourceGLSL.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "stage";
                    assert(it.offset_in_bytes == 16, "ShaderSourceGLSL.stage has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ShaderSourceGLSL.stage has unexpected size % instead of 8", it.type.runtime_size);
                case "code";
                    assert(it.offset_in_bytes == 24, "ShaderSourceGLSL.code has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderSourceGLSL.code has unexpected size % instead of 16", it.type.runtime_size);
                case "defineCount";
                    assert(it.offset_in_bytes == 40, "ShaderSourceGLSL.defineCount has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ShaderSourceGLSL.defineCount has unexpected size % instead of 4", it.type.runtime_size);
                case "defines";
                    assert(it.offset_in_bytes == 48, "ShaderSourceGLSL.defines has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ShaderSourceGLSL.defines has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ShaderSourceGLSL) == 56, "ShaderSourceGLSL has size % instead of 56", size_of(ShaderSourceGLSL));
    }

    {
        info := type_info(ShaderModuleDescriptorSpirV);
        for info.members {
            if it.name == {
                case "label";
                    assert(it.offset_in_bytes == 0, "ShaderModuleDescriptorSpirV.label has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "ShaderModuleDescriptorSpirV.label has unexpected size % instead of 16", it.type.runtime_size);
                case "sourceSize";
                    assert(it.offset_in_bytes == 16, "ShaderModuleDescriptorSpirV.sourceSize has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "ShaderModuleDescriptorSpirV.sourceSize has unexpected size % instead of 4", it.type.runtime_size);
                case "source";
                    assert(it.offset_in_bytes == 24, "ShaderModuleDescriptorSpirV.source has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "ShaderModuleDescriptorSpirV.source has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(ShaderModuleDescriptorSpirV) == 32, "ShaderModuleDescriptorSpirV has size % instead of 32", size_of(ShaderModuleDescriptorSpirV));
    }

    {
        info := type_info(RegistryReport);
        for info.members {
            if it.name == {
                case "numAllocated";
                    assert(it.offset_in_bytes == 0, "RegistryReport.numAllocated has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RegistryReport.numAllocated has unexpected size % instead of 8", it.type.runtime_size);
                case "numKeptFromUser";
                    assert(it.offset_in_bytes == 8, "RegistryReport.numKeptFromUser has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RegistryReport.numKeptFromUser has unexpected size % instead of 8", it.type.runtime_size);
                case "numReleasedFromUser";
                    assert(it.offset_in_bytes == 16, "RegistryReport.numReleasedFromUser has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RegistryReport.numReleasedFromUser has unexpected size % instead of 8", it.type.runtime_size);
                case "elementSize";
                    assert(it.offset_in_bytes == 24, "RegistryReport.elementSize has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RegistryReport.elementSize has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RegistryReport) == 32, "RegistryReport has size % instead of 32", size_of(RegistryReport));
    }

    {
        info := type_info(HubReport);
        for info.members {
            if it.name == {
                case "adapters";
                    assert(it.offset_in_bytes == 0, "HubReport.adapters has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.adapters has unexpected size % instead of 32", it.type.runtime_size);
                case "devices";
                    assert(it.offset_in_bytes == 32, "HubReport.devices has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.devices has unexpected size % instead of 32", it.type.runtime_size);
                case "queues";
                    assert(it.offset_in_bytes == 64, "HubReport.queues has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.queues has unexpected size % instead of 32", it.type.runtime_size);
                case "pipelineLayouts";
                    assert(it.offset_in_bytes == 96, "HubReport.pipelineLayouts has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.pipelineLayouts has unexpected size % instead of 32", it.type.runtime_size);
                case "shaderModules";
                    assert(it.offset_in_bytes == 128, "HubReport.shaderModules has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.shaderModules has unexpected size % instead of 32", it.type.runtime_size);
                case "bindGroupLayouts";
                    assert(it.offset_in_bytes == 160, "HubReport.bindGroupLayouts has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.bindGroupLayouts has unexpected size % instead of 32", it.type.runtime_size);
                case "bindGroups";
                    assert(it.offset_in_bytes == 192, "HubReport.bindGroups has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.bindGroups has unexpected size % instead of 32", it.type.runtime_size);
                case "commandBuffers";
                    assert(it.offset_in_bytes == 224, "HubReport.commandBuffers has unexpected offset % instead of 224", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.commandBuffers has unexpected size % instead of 32", it.type.runtime_size);
                case "renderBundles";
                    assert(it.offset_in_bytes == 256, "HubReport.renderBundles has unexpected offset % instead of 256", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.renderBundles has unexpected size % instead of 32", it.type.runtime_size);
                case "renderPipelines";
                    assert(it.offset_in_bytes == 288, "HubReport.renderPipelines has unexpected offset % instead of 288", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.renderPipelines has unexpected size % instead of 32", it.type.runtime_size);
                case "computePipelines";
                    assert(it.offset_in_bytes == 320, "HubReport.computePipelines has unexpected offset % instead of 320", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.computePipelines has unexpected size % instead of 32", it.type.runtime_size);
                case "pipelineCaches";
                    assert(it.offset_in_bytes == 352, "HubReport.pipelineCaches has unexpected offset % instead of 352", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.pipelineCaches has unexpected size % instead of 32", it.type.runtime_size);
                case "querySets";
                    assert(it.offset_in_bytes == 384, "HubReport.querySets has unexpected offset % instead of 384", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.querySets has unexpected size % instead of 32", it.type.runtime_size);
                case "buffers";
                    assert(it.offset_in_bytes == 416, "HubReport.buffers has unexpected offset % instead of 416", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.buffers has unexpected size % instead of 32", it.type.runtime_size);
                case "textures";
                    assert(it.offset_in_bytes == 448, "HubReport.textures has unexpected offset % instead of 448", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.textures has unexpected size % instead of 32", it.type.runtime_size);
                case "textureViews";
                    assert(it.offset_in_bytes == 480, "HubReport.textureViews has unexpected offset % instead of 480", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.textureViews has unexpected size % instead of 32", it.type.runtime_size);
                case "samplers";
                    assert(it.offset_in_bytes == 512, "HubReport.samplers has unexpected offset % instead of 512", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "HubReport.samplers has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(HubReport) == 544, "HubReport has size % instead of 544", size_of(HubReport));
    }

    {
        info := type_info(GlobalReport);
        for info.members {
            if it.name == {
                case "surfaces";
                    assert(it.offset_in_bytes == 0, "GlobalReport.surfaces has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "GlobalReport.surfaces has unexpected size % instead of 32", it.type.runtime_size);
                case "hub";
                    assert(it.offset_in_bytes == 32, "GlobalReport.hub has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 544, "GlobalReport.hub has unexpected size % instead of 544", it.type.runtime_size);
            }
        }
        assert(size_of(GlobalReport) == 576, "GlobalReport has size % instead of 576", size_of(GlobalReport));
    }

    {
        info := type_info(InstanceEnumerateAdapterOptions);
        for info.members {
            if it.name == {
                case "nextInChain";
                    assert(it.offset_in_bytes == 0, "InstanceEnumerateAdapterOptions.nextInChain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceEnumerateAdapterOptions.nextInChain has unexpected size % instead of 8", it.type.runtime_size);
                case "backends";
                    assert(it.offset_in_bytes == 8, "InstanceEnumerateAdapterOptions.backends has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "InstanceEnumerateAdapterOptions.backends has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(InstanceEnumerateAdapterOptions) == 16, "InstanceEnumerateAdapterOptions has size % instead of 16", size_of(InstanceEnumerateAdapterOptions));
    }

    {
        info := type_info(BindGroupEntryExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "BindGroupEntryExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "BindGroupEntryExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "buffers";
                    assert(it.offset_in_bytes == 16, "BindGroupEntryExtras.buffers has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntryExtras.buffers has unexpected size % instead of 8", it.type.runtime_size);
                case "bufferCount";
                    assert(it.offset_in_bytes == 24, "BindGroupEntryExtras.bufferCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntryExtras.bufferCount has unexpected size % instead of 8", it.type.runtime_size);
                case "samplers";
                    assert(it.offset_in_bytes == 32, "BindGroupEntryExtras.samplers has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntryExtras.samplers has unexpected size % instead of 8", it.type.runtime_size);
                case "samplerCount";
                    assert(it.offset_in_bytes == 40, "BindGroupEntryExtras.samplerCount has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntryExtras.samplerCount has unexpected size % instead of 8", it.type.runtime_size);
                case "textureViews";
                    assert(it.offset_in_bytes == 48, "BindGroupEntryExtras.textureViews has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntryExtras.textureViews has unexpected size % instead of 8", it.type.runtime_size);
                case "textureViewCount";
                    assert(it.offset_in_bytes == 56, "BindGroupEntryExtras.textureViewCount has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "BindGroupEntryExtras.textureViewCount has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(BindGroupEntryExtras) == 64, "BindGroupEntryExtras has size % instead of 64", size_of(BindGroupEntryExtras));
    }

    {
        info := type_info(BindGroupLayoutEntryExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "BindGroupLayoutEntryExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "BindGroupLayoutEntryExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 16, "BindGroupLayoutEntryExtras.count has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "BindGroupLayoutEntryExtras.count has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(BindGroupLayoutEntryExtras) == 24, "BindGroupLayoutEntryExtras has size % instead of 24", size_of(BindGroupLayoutEntryExtras));
    }

    {
        info := type_info(QuerySetDescriptorExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "QuerySetDescriptorExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "QuerySetDescriptorExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "pipelineStatistics";
                    assert(it.offset_in_bytes == 16, "QuerySetDescriptorExtras.pipelineStatistics has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QuerySetDescriptorExtras.pipelineStatistics has unexpected size % instead of 8", it.type.runtime_size);
                case "pipelineStatisticCount";
                    assert(it.offset_in_bytes == 24, "QuerySetDescriptorExtras.pipelineStatisticCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "QuerySetDescriptorExtras.pipelineStatisticCount has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(QuerySetDescriptorExtras) == 32, "QuerySetDescriptorExtras has size % instead of 32", size_of(QuerySetDescriptorExtras));
    }

    {
        info := type_info(SurfaceConfigurationExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceConfigurationExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceConfigurationExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "desiredMaximumFrameLatency";
                    assert(it.offset_in_bytes == 16, "SurfaceConfigurationExtras.desiredMaximumFrameLatency has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "SurfaceConfigurationExtras.desiredMaximumFrameLatency has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceConfigurationExtras) == 24, "SurfaceConfigurationExtras has size % instead of 24", size_of(SurfaceConfigurationExtras));
    }

    {
        info := type_info(SurfaceSourceSwapChainPanel);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "SurfaceSourceSwapChainPanel.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "SurfaceSourceSwapChainPanel.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "panelNative";
                    assert(it.offset_in_bytes == 16, "SurfaceSourceSwapChainPanel.panelNative has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "SurfaceSourceSwapChainPanel.panelNative has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(SurfaceSourceSwapChainPanel) == 24, "SurfaceSourceSwapChainPanel has size % instead of 24", size_of(SurfaceSourceSwapChainPanel));
    }

    {
        info := type_info(PrimitiveStateExtras);
        for info.members {
            if it.name == {
                case "chain";
                    assert(it.offset_in_bytes == 0, "PrimitiveStateExtras.chain has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "PrimitiveStateExtras.chain has unexpected size % instead of 16", it.type.runtime_size);
                case "polygonMode";
                    assert(it.offset_in_bytes == 16, "PrimitiveStateExtras.polygonMode has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PrimitiveStateExtras.polygonMode has unexpected size % instead of 4", it.type.runtime_size);
                case "conservative";
                    assert(it.offset_in_bytes == 20, "PrimitiveStateExtras.conservative has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "PrimitiveStateExtras.conservative has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(PrimitiveStateExtras) == 24, "PrimitiveStateExtras has size % instead of 24", size_of(PrimitiveStateExtras));
    }
}

