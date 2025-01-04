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
%vectype   = OpTypeVector %f32 2
%composite = OpTypeMatrix %vectype 2
%filler    = OpConstant %f32 0.224402
%fillerVec = OpConstantComposite %vectype %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 0 0
%out_val   = OpCompositeExtract %f32 %instance2 0 0
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
%vectype   = OpTypeVector %f32 2
%composite = OpTypeMatrix %vectype 3
%filler    = OpConstant %f32 0.28543
%fillerVec = OpConstantComposite %vectype %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 0 0
%out_val   = OpCompositeExtract %f32 %instance2 0 0
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
%vectype   = OpTypeVector %f32 2
%composite = OpTypeMatrix %vectype 4
%filler    = OpConstant %f32 0.869291
%fillerVec = OpConstantComposite %vectype %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 0 1
%out_val   = OpCompositeExtract %f32 %instance2 0 1
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
%vectype   = OpTypeVector %f32 3
%composite = OpTypeMatrix %vectype 2
%filler    = OpConstant %f32 0.205335
%fillerVec = OpConstantComposite %vectype %filler %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 0 2
%out_val   = OpCompositeExtract %f32 %instance2 0 2
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
%vectype   = OpTypeVector %f32 3
%composite = OpTypeMatrix %vectype 3
%filler    = OpConstant %f32 0.566546
%fillerVec = OpConstantComposite %vectype %filler %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 2 2
%out_val   = OpCompositeExtract %f32 %instance2 2 2
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
%vectype   = OpTypeVector %f32 3
%composite = OpTypeMatrix %vectype 4
%filler    = OpConstant %f32 0.782008
%fillerVec = OpConstantComposite %vectype %filler %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 1 0
%out_val   = OpCompositeExtract %f32 %instance2 1 0
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
%vectype   = OpTypeVector %f32 4
%composite = OpTypeMatrix %vectype 2
%filler    = OpConstant %f32 0.776444
%fillerVec = OpConstantComposite %vectype %filler %filler %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 0 1
%out_val   = OpCompositeExtract %f32 %instance2 0 1
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
%vectype   = OpTypeVector %f32 4
%composite = OpTypeMatrix %vectype 3
%filler    = OpConstant %f32 0.248061
%fillerVec = OpConstantComposite %vectype %filler %filler %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 1 1
%out_val   = OpCompositeExtract %f32 %instance2 1 1
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
%vectype   = OpTypeVector %f32 4
%composite = OpTypeMatrix %vectype 4
%filler    = OpConstant %f32 0.0964564
%fillerVec = OpConstantComposite %vectype %filler %filler %filler %filler
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
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
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec %fillerVec
%instance2 = OpCompositeInsert %composite %inval %instance 0 0
%out_val   = OpCompositeExtract %f32 %instance2 0 0
             OpStore %outloc %out_val
             OpReturn
             OpFunctionEnd
