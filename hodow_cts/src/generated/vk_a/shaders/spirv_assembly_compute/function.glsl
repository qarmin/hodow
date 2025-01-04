OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 None %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 Inline %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 DontInline %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 Pure %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 Const %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 Inline|Pure %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 Const|DontInline %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 Inline|DontInline %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %func_const10 "const10("
OpName %id "gl_GlobalInvocationID"
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
%f32f = OpTypeFunction %f32
%id = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%constf10 = OpConstant %f32 10.0
%main         = OpFunction %void None %voidf
%entry        = OpLabel
%idval        = OpLoad %uvec3 %id
%x            = OpCompositeExtract %u32 %idval 0
%inloc        = OpAccessChain %f32ptr %indata %zero %x
%inval        = OpLoad %f32 %inloc
%ret_10       = OpFunctionCall %f32 %func_const10
%fadd         = OpFAdd %f32 %inval %ret_10
%outloc       = OpAccessChain %f32ptr %outdata %zero %x
                OpStore %outloc %fadd
                OpReturn
                OpFunctionEnd
%func_const10 = OpFunction %f32 Pure|Inline|DontInline %f32f
%label        = OpLabel
                OpReturnValue %constf10
                OpFunctionEnd
