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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 2
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 -2070878846
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 1
%out_val   = OpCompositeExtract %i32 %instance2 1
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 3
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 687459915
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 1
%out_val   = OpCompositeExtract %i32 %instance2 1
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 4
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 2012875474
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 0
%out_val   = OpCompositeExtract %i32 %instance2 0
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 5
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 1934031437
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 1
%out_val   = OpCompositeExtract %i32 %instance2 1
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 6
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 -1918831537
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 5
%out_val   = OpCompositeExtract %i32 %instance2 5
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 7
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 1853456707
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 0
%out_val   = OpCompositeExtract %i32 %instance2 0
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 8
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 2045191623
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 6
%out_val   = OpCompositeExtract %i32 %instance2 6
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 9
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 -1462687817
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 2
%out_val   = OpCompositeExtract %i32 %instance2 2
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 10
%composite = OpTypeArray %i32 %arraywidth
%filler    = OpConstant %i32 -120230763
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler %filler %filler %filler
%instance2 = OpCompositeInsert %composite %inval %instance 3
%out_val   = OpCompositeExtract %i32 %instance2 3
             OpStore %outloc %out_val
             OpReturn
             OpFunctionEnd
