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
%u32vec2 = OpTypeVector %u32 2
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %u32vec2
%struct_t  = OpTypeStruct %u32vec2 %u32vec2 %u32vec2
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %u32 2648217681
%index_0   = OpConstant %u32 2
%customptr = OpTypePointer Uniform %u32
%customarr = OpTypeRuntimeArray %u32
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
%inval     = OpLoad %u32 %inloc
%instance  = OpCompositeConstruct %u32vec2 %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 2 1
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %u32vec2 %inner_ptr
%read_val  = OpCompositeExtract %u32 %read_obj 1
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
%u32vec3 = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %u32vec3
%struct_t  = OpTypeStruct %u32vec3 %u32vec3 %u32vec3
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %u32 3066471078
%index_0   = OpConstant %u32 2
%customptr = OpTypePointer Uniform %u32
%customarr = OpTypeRuntimeArray %u32
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
%inval     = OpLoad %u32 %inloc
%instance  = OpCompositeConstruct %u32vec3 %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 2 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %u32vec3 %inner_ptr
%read_val  = OpCompositeExtract %u32 %read_obj 0
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
%u32vec4 = OpTypeVector %u32 4
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %u32vec4
%struct_t  = OpTypeStruct %u32vec4 %u32vec4 %u32vec4 %u32vec4 %u32vec4 %u32vec4
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %u32 2212960036
%index_0   = OpConstant %u32 4
%customptr = OpTypePointer Uniform %u32
%customarr = OpTypeRuntimeArray %u32
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
%inval     = OpLoad %u32 %inloc
%instance  = OpCompositeConstruct %u32vec4 %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 4 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %u32vec4 %inner_ptr
%read_val  = OpCompositeExtract %u32 %read_obj 0
             OpStore %outloc %read_val
             OpReturn
             OpFunctionEnd
