OpCapability Shader
OpCapability Matrix
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %customarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%u32vec2 = OpTypeVector %u32 2
%filler    = OpConstant %u32 1934020158
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %u32
%customarr = OpTypeRuntimeArray %u32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %customptr %indata %zero %x
%outloc    = OpAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %u32 %inloc
%instance  = OpCompositeConstruct %u32vec2 %filler %filler
%instance2 = OpCompositeInsert %u32vec2 %inval %instance 1
%out_val   = OpCompositeExtract %u32 %instance2 1
             OpStore %outloc %out_val
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Matrix
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %customarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%u32vec3 = OpTypeVector %u32 3
%filler    = OpConstant %u32 4140144827
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %u32
%customarr = OpTypeRuntimeArray %u32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %customptr %indata %zero %x
%outloc    = OpAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %u32 %inloc
%instance  = OpCompositeConstruct %u32vec3 %filler %filler %filler
%instance2 = OpCompositeInsert %u32vec3 %inval %instance 2
%out_val   = OpCompositeExtract %u32 %instance2 2
             OpStore %outloc %out_val
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Matrix
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %customarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%u32vec4 = OpTypeVector %u32 4
%filler    = OpConstant %u32 1959092118
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %u32
%customarr = OpTypeRuntimeArray %u32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %customptr %indata %zero %x
%outloc    = OpAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %u32 %inloc
%instance  = OpCompositeConstruct %u32vec4 %filler %filler %filler %filler
%instance2 = OpCompositeInsert %u32vec4 %inval %instance 0
%out_val   = OpCompositeExtract %u32 %instance2 0
             OpStore %outloc %out_val
             OpReturn
             OpFunctionEnd
