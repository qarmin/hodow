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
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 2
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.103337
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
%instance  = OpCompositeConstruct %composite %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 1 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 0
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 3
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.0892199
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 2 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 0
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 4
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.0250136
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 3 3
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 3
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 5
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.228903
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 1 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 0
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 6
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.563921
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 5 2
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 2
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 7
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.747486
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 0 4
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 4
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 8
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.124387
%index_0   = OpConstant %u32 4
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 4 5
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 5
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 9
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.515177
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 0 2
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 2
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
OpDecorate %composite ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%f32       = OpTypeFloat 32
%arraywidth = OpConstant %u32 10
%composite = OpTypeArray %f32 %arraywidth
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %composite
%struct_t  = OpTypeStruct %composite %composite %composite %composite %composite %composite %composite
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %f32 0.597336
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
%instance  = OpCompositeConstruct %composite %filler %filler %filler %filler %filler %filler %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 0 2
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %composite %inner_ptr
%read_val  = OpCompositeExtract %f32 %read_obj 2
             OpStore %outloc %read_val
             OpReturn
             OpFunctionEnd
