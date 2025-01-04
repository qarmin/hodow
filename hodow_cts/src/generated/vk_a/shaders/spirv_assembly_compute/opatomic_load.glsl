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
OpDecorate %i32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
OpDecorate %sumbuf BufferBlock
OpDecorate %sum DescriptorSet 0
OpDecorate %sum Binding 1
OpMemberDecorate %sumbuf 0 Offset 0
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
%buf       = OpTypeStruct %i32arr
%bufptr    = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%sumbuf    = OpTypeStruct %i32arr
%sumbufptr = OpTypePointer Uniform %sumbuf
%sum       = OpVariable %sumbufptr Uniform
%id        = OpVariable %uvec3ptr Input
%minusone  = OpConstant %i32 -1
%zero      = OpConstant %i32 0
%one       = OpConstant %u32 1
%two       = OpConstant %i32 2
%five      = OpConstant %i32 5
%volbit    = OpConstant %i32 32768
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %i32ptr %indata %zero %x
%inval     = OpLoad %i32 %inloc
%outloc    = OpAccessChain %i32ptr %sum %zero %x
%inval2    = OpAtomicLoad %i32 %inloc %one %zero
             OpStore %outloc %inval2
             OpReturn
             OpFunctionEnd
