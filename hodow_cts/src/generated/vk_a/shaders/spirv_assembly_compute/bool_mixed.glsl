OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval32 %c25f32
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpFOrdGreaterThanEqual %bool %inval16 %c25f16
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval32 %c50f32
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpFOrdLessThan %bool %inval16 %c50f16
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval32 %c10f32
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpFOrdLessThan %bool %inval16 %c10f16
%cmp4      = OpSGreaterThanEqual %bool %inval8 %c90i8
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%c10f32    = OpConstant %f32 10.0
%c25f32    = OpConstant %f32 25.0
%c50f32    = OpConstant %f32 50.0
%c90f32    = OpConstant %f32 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval32 %c90f32
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int8

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
%id        = OpVariable %uvec3ptr Input
%c0i32     = OpConstant %i32 0
%c1f32     = OpConstant %f32 1.0
%c0f32     = OpConstant %f32 0.0
%f16       = OpTypeFloat 16
%c10f16    = OpConstant %f16 10.0
%c25f16    = OpConstant %f16 25.0
%c50f16    = OpConstant %f16 50.0
%c90f16    = OpConstant %f16 90.0
%i8        = OpTypeInt 8 1
%c10i8     = OpConstant %i8 10
%c25i8     = OpConstant %i8 25
%c50i8     = OpConstant %i8 50
%c90i8     = OpConstant %i8 90

%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %c0i32 %x
%inval32   = OpLoad %f32 %inloc
%inval16   = OpFConvert %f16 %inval32
%inval8    = OpConvertFToS %i8 %inval32
%cmp1      = OpSGreaterThanEqual %bool %inval8 %c25i8
%cmp2      = OpSLessThan %bool %inval8 %c50i8
%cmp3      = OpSLessThan %bool %inval8 %c10i8
%cmp4      = OpFOrdGreaterThanEqual %bool %inval16 %c90f16
%and1      = OpLogicalAnd %bool %cmp1 %cmp2
%or1       = OpLogicalOr %bool %cmp3 %cmp4
%or2       = OpLogicalOr %bool %and1 %or1
%not1      = OpLogicalNot %bool %or2
%res       = OpSelect %f32 %not1 %c1f32 %c0f32

%outloc    = OpAccessChain %f32ptr %outdata %c0i32 %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
