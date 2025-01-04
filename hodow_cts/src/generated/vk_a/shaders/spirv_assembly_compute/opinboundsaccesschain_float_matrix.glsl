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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 2
%composite = OpTypeMatrix %vectype 2
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.779221
%fillerVec = OpConstantComposite %vectype %filler %filler
%index_0   = OpConstant %u32 6
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 6 1 1
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 1 1
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 2
%composite = OpTypeMatrix %vectype 3
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.46176
%fillerVec = OpConstantComposite %vectype %filler %filler
%index_0   = OpConstant %u32 2
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 2 2 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 2 0
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 2
%composite = OpTypeMatrix %vectype 4
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.545113
%fillerVec = OpConstantComposite %vectype %filler %filler
%index_0   = OpConstant %u32 7
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 7 3 1
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 3 1
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 3
%composite = OpTypeMatrix %vectype 2
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.190062
%fillerVec = OpConstantComposite %vectype %filler %filler %filler
%index_0   = OpConstant %u32 5
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 5 0 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 0 0
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 3
%composite = OpTypeMatrix %vectype 3
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.402136
%fillerVec = OpConstantComposite %vectype %filler %filler %filler
%index_0   = OpConstant %u32 3
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 3 2 2
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 2 2
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 3
%composite = OpTypeMatrix %vectype 4
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.527647
%fillerVec = OpConstantComposite %vectype %filler %filler %filler
%index_0   = OpConstant %u32 5
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 5 0 1
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 0 1
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 4
%composite = OpTypeMatrix %vectype 2
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.565674
%fillerVec = OpConstantComposite %vectype %filler %filler %filler %filler
%index_0   = OpConstant %u32 1
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 1 0 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 0 0
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 4
%composite = OpTypeMatrix %vectype 3
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.848579
%fillerVec = OpConstantComposite %vectype %filler %filler %filler %filler
%index_0   = OpConstant %u32 0
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 0 2 2
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 2 2
             OpStore %outloc %read_val
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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%vectype   = OpTypeVector %f32 4
%composite = OpTypeMatrix %vectype 4
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.37493
%fillerVec = OpConstantComposite %vectype %filler %filler %filler %filler
%index_0   = OpConstant %u32 1
%customptr = OpTypePointer Uniform %f32
%customarr = OpTypeRuntimeArray %f32
%buf       = OpTypeStruct %customarr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%struct_v  = OpVariable %struct_p Function
%idval     = OpLoad %u32vec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpInBoundsAccessChain %customptr %indata %zero %x
%outloc    = OpInBoundsAccessChain %customptr %outdata %zero %x
%inval     = OpLoad %f32 %inloc
%instance  = OpCompositeConstruct %composite %fillerVec %fillerVec %fillerVec %fillerVec
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 1 2 1
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 2 1
             OpStore %outloc %read_val
             OpReturn
             OpFunctionEnd
