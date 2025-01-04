OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %vec4arr ArrayStride 16
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
%vec4       = OpTypeVector %f32 4
%vec4ptr_u  = OpTypePointer Uniform %vec4
%vec4ptr_f  = OpTypePointer Function %vec4
%vec4arr    = OpTypeRuntimeArray %vec4
%buf        = OpTypeStruct %vec4arr
%bufptr     = OpTypePointer Uniform %buf
%indata     = OpVariable %bufptr Uniform
%outdata    = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%c_f_0      = OpConstant %f32 0.
%c_f_0_5    = OpConstant %f32 0.5
%c_f_1_5    = OpConstant %f32 1.5
%c_f_2_5    = OpConstant %f32 2.5
%c_vec4     = OpConstantComposite %vec4 %c_f_0 %c_f_0_5 %c_f_1_5 %c_f_2_5
%main       = OpFunction %void None %voidf
%label      = OpLabel
%v_vec4     = OpVariable %vec4ptr_f Function
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %vec4ptr_u %indata %zero %x
%outloc     = OpAccessChain %vec4ptr_u %outdata %zero %x
              OpCopyMemory %v_vec4 %inloc
%v_vec4_val = OpLoad %vec4 %v_vec4
%add        = OpFAdd %vec4 %v_vec4_val %c_vec4
              OpStore %outloc %add
              OpReturn
              OpFunctionEnd
