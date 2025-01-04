OpCapability Shader
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
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%f32ptr_f  = OpTypePointer Function %f32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%four      = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%copy      = OpVariable %f32ptr_f Function
%idval     = OpLoad %uvec3 %id 
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata  %zero %x
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpCopyMemory %copy %inloc 
%val1      = OpLoad %f32 %copy
%val2      = OpLoad %f32 %inloc
%add       = OpFAdd %f32 %val1 %val2
             OpStore %outloc %add 
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
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%f32ptr_f  = OpTypePointer Function %f32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%four      = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%copy      = OpVariable %f32ptr_f Function
%idval     = OpLoad %uvec3 %id None
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata  %zero %x
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpCopyMemory %copy %inloc None
%val1      = OpLoad %f32 %copy
%val2      = OpLoad %f32 %inloc
%add       = OpFAdd %f32 %val1 %val2
             OpStore %outloc %add None
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
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%f32ptr_f  = OpTypePointer Function %f32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%four      = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%copy      = OpVariable %f32ptr_f Function
%idval     = OpLoad %uvec3 %id Volatile
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata  %zero %x
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpCopyMemory %copy %inloc Volatile
%val1      = OpLoad %f32 %copy
%val2      = OpLoad %f32 %inloc
%add       = OpFAdd %f32 %val1 %val2
             OpStore %outloc %add Volatile
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
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%f32ptr_f  = OpTypePointer Function %f32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%four      = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%copy      = OpVariable %f32ptr_f Function
%idval     = OpLoad %uvec3 %id Aligned 4
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata  %zero %x
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpCopyMemory %copy %inloc Aligned 4
%val1      = OpLoad %f32 %copy
%val2      = OpLoad %f32 %inloc
%add       = OpFAdd %f32 %val1 %val2
             OpStore %outloc %add Aligned 4
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
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%f32ptr_f  = OpTypePointer Function %f32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%four      = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%copy      = OpVariable %f32ptr_f Function
%idval     = OpLoad %uvec3 %id Nontemporal
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata  %zero %x
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpCopyMemory %copy %inloc Nontemporal
%val1      = OpLoad %f32 %copy
%val2      = OpLoad %f32 %inloc
%add       = OpFAdd %f32 %val1 %val2
             OpStore %outloc %add Nontemporal
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
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%f32ptr_f  = OpTypePointer Function %f32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%four      = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%copy      = OpVariable %f32ptr_f Function
%idval     = OpLoad %uvec3 %id Aligned|Nontemporal 4
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata  %zero %x
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpCopyMemory %copy %inloc Aligned|Nontemporal 4
%val1      = OpLoad %f32 %copy
%val2      = OpLoad %f32 %inloc
%add       = OpFAdd %f32 %val1 %val2
             OpStore %outloc %add Aligned|Nontemporal 4
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
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%f32ptr_f  = OpTypePointer Function %f32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%four      = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%copy      = OpVariable %f32ptr_f Function
%idval     = OpLoad %uvec3 %id Volatile|Aligned 4
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata  %zero %x
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpCopyMemory %copy %inloc Volatile|Aligned 4
%val1      = OpLoad %f32 %copy
%val2      = OpLoad %f32 %inloc
%add       = OpFAdd %f32 %val1 %val2
             OpStore %outloc %add Volatile|Aligned 4
             OpReturn
             OpFunctionEnd
