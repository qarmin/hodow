OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %UnusedBufferType 0 Offset 0
OpMemberDecorate %UnusedBufferType 1 Offset 4
OpDecorate %UnusedBufferType BufferBlock
OpDecorate %unused_buffer DescriptorSet 0
OpDecorate %unused_buffer Binding 5
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
%c_f32_101 = OpConstant %f32 101
%c_i32_201 = OpConstant %i32 201
%UnusedBufferType = OpTypeStruct %f32 %i32
%unused_ptr_Uniform_UnusedBufferType = OpTypePointer Uniform %UnusedBufferType
%unused_ptr_Uniform_float = OpTypePointer Uniform %f32
%unused_ptr_Uniform_int = OpTypePointer Uniform %i32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%unused_buffer = OpVariable %unused_ptr_Uniform_UnusedBufferType Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %x
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpEntryPoint Vertex %unused_func "unused_func"
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %UnusedBufferType 0 Offset 0
OpMemberDecorate %UnusedBufferType 1 Offset 4
OpDecorate %UnusedBufferType BufferBlock
OpDecorate %unused_buffer DescriptorSet 0
OpDecorate %unused_buffer Binding 5
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
%c_f32_101 = OpConstant %f32 101
%c_i32_201 = OpConstant %i32 201
%UnusedBufferType = OpTypeStruct %f32 %i32
%unused_ptr_Uniform_UnusedBufferType = OpTypePointer Uniform %UnusedBufferType
%unused_ptr_Uniform_float = OpTypePointer Uniform %f32
%unused_ptr_Uniform_int = OpTypePointer Uniform %i32
%c_i32_0 = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%unused_buffer = OpVariable %unused_ptr_Uniform_UnusedBufferType Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %x
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
%unused_func = OpFunction %void None %voidf
%unused_func_label = OpLabel
%unused_out_float_ptr = OpAccessChain %unused_ptr_Uniform_float %unused_buffer %c_i32_0
OpStore %unused_out_float_ptr %c_f32_101
%unused_out_int_ptr = OpAccessChain %unused_ptr_Uniform_int %unused_buffer %c_i32_1
OpStore %unused_out_int_ptr %c_i32_201
OpReturn
OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %UnusedBufferType 0 Offset 0
OpMemberDecorate %UnusedBufferType 1 Offset 4
OpDecorate %UnusedBufferType BufferBlock
OpDecorate %unused_buffer DescriptorSet 5
OpDecorate %unused_buffer Binding 5
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
%c_f32_101 = OpConstant %f32 101
%c_i32_201 = OpConstant %i32 201
%UnusedBufferType = OpTypeStruct %f32 %i32
%unused_ptr_Uniform_UnusedBufferType = OpTypePointer Uniform %UnusedBufferType
%unused_ptr_Uniform_float = OpTypePointer Uniform %f32
%unused_ptr_Uniform_int = OpTypePointer Uniform %i32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%unused_buffer = OpVariable %unused_ptr_Uniform_UnusedBufferType Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %x
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpEntryPoint Vertex %unused_func "unused_func"
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %UnusedBufferType 0 Offset 0
OpMemberDecorate %UnusedBufferType 1 Offset 4
OpDecorate %UnusedBufferType BufferBlock
OpDecorate %unused_buffer DescriptorSet 5
OpDecorate %unused_buffer Binding 5
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
%c_f32_101 = OpConstant %f32 101
%c_i32_201 = OpConstant %i32 201
%UnusedBufferType = OpTypeStruct %f32 %i32
%unused_ptr_Uniform_UnusedBufferType = OpTypePointer Uniform %UnusedBufferType
%unused_ptr_Uniform_float = OpTypePointer Uniform %f32
%unused_ptr_Uniform_int = OpTypePointer Uniform %i32
%c_i32_0 = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%unused_buffer = OpVariable %unused_ptr_Uniform_UnusedBufferType Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %x
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
%unused_func = OpFunction %void None %voidf
%unused_func_label = OpLabel
%unused_out_float_ptr = OpAccessChain %unused_ptr_Uniform_float %unused_buffer %c_i32_0
OpStore %unused_out_float_ptr %c_f32_101
%unused_out_int_ptr = OpAccessChain %unused_ptr_Uniform_int %unused_buffer %c_i32_1
OpStore %unused_out_int_ptr %c_i32_201
OpReturn
OpFunctionEnd
