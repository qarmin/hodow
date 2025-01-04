OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %fvec4_array ArrayStride 16
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%fvec4       = OpTypeVector %f32 4
%fvec4_array = OpTypeRuntimeArray %fvec4
%fvec4ptr    = OpTypePointer Uniform %fvec4
%buf         = OpTypeStruct %fvec4_array
%bufptr      = OpTypePointer Uniform %buf
%indata      = OpVariable %bufptr Uniform
%outdata     = OpVariable %bufptr Uniform
%id          = OpVariable %uvec3ptr Input
%zero        = OpConstant %i32 0
%main        = OpFunction %void None %voidf
%label       = OpLabel
%idval       = OpLoad %uvec3 %id
%x           = OpCompositeExtract %u32 %idval 0
%inloc       = OpAccessChain %fvec4ptr %indata %zero %x
%inval       = OpLoad %fvec4 %inloc
%quant       = OpQuantizeToF16 %fvec4 %inval
%outloc      = OpAccessChain %fvec4ptr %outdata %zero %x
               OpStore %outloc %quant
               OpReturn
               OpFunctionEnd
