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
%i32vec2 = OpTypeVector %i32 2
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %i32vec2
%struct_t  = OpTypeStruct %i32vec2 %i32vec2
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %i32 -1914740081
%index_0   = OpConstant %u32 1
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %i32vec2 %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 1 0
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %i32vec2 %inner_ptr
%read_val  = OpCompositeExtract %i32 %read_obj 0
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
%i32vec3 = OpTypeVector %i32 3
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %i32vec3
%struct_t  = OpTypeStruct %i32vec3 %i32vec3
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %i32 -2126951091
%index_0   = OpConstant %u32 1
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %i32vec3 %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 1 2
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %i32vec3 %inner_ptr
%read_val  = OpCompositeExtract %i32 %read_obj 2
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
%i32vec4 = OpTypeVector %i32 4
%u32vec3   = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %u32vec3
%composite_p = OpTypePointer Function %i32vec4
%struct_t  = OpTypeStruct %i32vec4 %i32vec4 %i32vec4 %i32vec4 %i32vec4 %i32vec4
%struct_p  = OpTypePointer Function %struct_t
%filler    = OpConstant %i32 2020603807
%index_0   = OpConstant %u32 1
%customptr = OpTypePointer Uniform %i32
%customarr = OpTypeRuntimeArray %i32
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
%inval     = OpLoad %i32 %inloc
%instance  = OpCompositeConstruct %i32vec4 %filler %filler %filler %filler
%struct    = OpCompositeConstruct %struct_t %instance %instance %instance %instance %instance %instance
%comp_obj  = OpCompositeInsert %struct_t %inval %struct 1 2
             OpStore %struct_v %comp_obj
%inner_ptr = OpInBoundsAccessChain %composite_p %struct_v %index_0
%read_obj  = OpLoad %i32vec4 %inner_ptr
%read_val  = OpCompositeExtract %i32 %read_obj 2
             OpStore %outloc %read_val
             OpReturn
             OpFunctionEnd
