OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_arr ArrayStride 4
OpDecorate %in_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%uvec3      = OpTypeVector %u32 3
%uvec3ptr   = OpTypePointer Input %uvec3
%const      = OpConstant %i32 -1869502353
%in_ptr     = OpTypePointer Uniform %i32
%in_arr     = OpTypeRuntimeArray %i32
%in_buf     = OpTypeStruct %in_arr
%in_bufptr  = OpTypePointer Uniform %in_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %in_bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%var_ptr    = OpTypePointer Function %i32
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%out_var    = OpVariable %var_ptr Function %const
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %in_ptr %indata %zero %x
%outloc     = OpAccessChain %in_ptr %outdata %zero %x
%outval     = OpLoad %i32 %out_var
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_arr ArrayStride 4
OpDecorate %in_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%uvec3      = OpTypeVector %u32 3
%uvec3ptr   = OpTypePointer Input %uvec3
;%const      = OpConstant %i32 
%in_ptr     = OpTypePointer Uniform %i32
%in_arr     = OpTypeRuntimeArray %i32
%in_buf     = OpTypeStruct %in_arr
%in_bufptr  = OpTypePointer Uniform %in_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %in_bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%var_ptr    = OpTypePointer Function %i32
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%out_var    = OpVariable %var_ptr Function
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %in_ptr %indata %zero %x
%outloc     = OpAccessChain %in_ptr %outdata %zero %x
%outval     = OpLoad %i32 %out_var
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_arr ArrayStride 4
OpDecorate %in_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%uvec3      = OpTypeVector %u32 3
%uvec3ptr   = OpTypePointer Input %uvec3
%const      = OpConstant %u32 218842427
%in_ptr     = OpTypePointer Uniform %u32
%in_arr     = OpTypeRuntimeArray %u32
%in_buf     = OpTypeStruct %in_arr
%in_bufptr  = OpTypePointer Uniform %in_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %in_bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%var_ptr    = OpTypePointer Function %u32
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%out_var    = OpVariable %var_ptr Function %const
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %in_ptr %indata %zero %x
%outloc     = OpAccessChain %in_ptr %outdata %zero %x
%outval     = OpLoad %u32 %out_var
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_arr ArrayStride 4
OpDecorate %in_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%uvec3      = OpTypeVector %u32 3
%uvec3ptr   = OpTypePointer Input %uvec3
;%const      = OpConstant %u32 
%in_ptr     = OpTypePointer Uniform %u32
%in_arr     = OpTypeRuntimeArray %u32
%in_buf     = OpTypeStruct %in_arr
%in_bufptr  = OpTypePointer Uniform %in_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %in_bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%var_ptr    = OpTypePointer Function %u32
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%out_var    = OpVariable %var_ptr Function
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %in_ptr %indata %zero %x
%outloc     = OpAccessChain %in_ptr %outdata %zero %x
%outval     = OpLoad %u32 %out_var
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_arr ArrayStride 4
OpDecorate %in_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%uvec3      = OpTypeVector %u32 3
%uvec3ptr   = OpTypePointer Input %uvec3
%const      = OpConstant %f32 0.144846
%in_ptr     = OpTypePointer Uniform %f32
%in_arr     = OpTypeRuntimeArray %f32
%in_buf     = OpTypeStruct %in_arr
%in_bufptr  = OpTypePointer Uniform %in_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %in_bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%var_ptr    = OpTypePointer Function %f32
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%out_var    = OpVariable %var_ptr Function %const
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %in_ptr %indata %zero %x
%outloc     = OpAccessChain %in_ptr %outdata %zero %x
%outval     = OpLoad %f32 %out_var
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_arr ArrayStride 4
OpDecorate %in_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%uvec3      = OpTypeVector %u32 3
%uvec3ptr   = OpTypePointer Input %uvec3
;%const      = OpConstant %f32 
%in_ptr     = OpTypePointer Uniform %f32
%in_arr     = OpTypeRuntimeArray %f32
%in_buf     = OpTypeStruct %in_arr
%in_bufptr  = OpTypePointer Uniform %in_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %in_bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%var_ptr    = OpTypePointer Function %f32
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%out_var    = OpVariable %var_ptr Function
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %in_ptr %indata %zero %x
%outloc     = OpAccessChain %in_ptr %outdata %zero %x
%outval     = OpLoad %f32 %out_var
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
