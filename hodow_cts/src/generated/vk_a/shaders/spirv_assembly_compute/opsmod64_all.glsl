OpCapability Int64
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %i64arr ArrayStride 8
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
%i64       = OpTypeInt 64 1
%i64ptr    = OpTypePointer Uniform %i64
%i64arr    = OpTypeRuntimeArray %i64
%buf        = OpTypeStruct %i64arr
%bufptr     = OpTypePointer Uniform %buf
%indata1    = OpVariable %bufptr Uniform
%indata2    = OpVariable %bufptr Uniform
%outdata    = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i64 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc1    = OpAccessChain %i64ptr %indata1 %zero %x
%inval1    = OpLoad %i64 %inloc1
%inloc2    = OpAccessChain %i64ptr %indata2 %zero %x
%inval2    = OpLoad %i64 %inloc2
%rem       = OpSMod %i64 %inval1 %inval2
%outloc    = OpAccessChain %i64ptr %outdata %zero %x
             OpStore %outloc %rem
             OpReturn
             OpFunctionEnd
