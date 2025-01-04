OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
%fname1 = OpString "negateInputs.comp"
%fname2 = OpString "negateInputs"
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
OpLine %fname1 0 0
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
OpLine %fname1 0 1
OpLine %fname2 1 0
OpLine %fname1 1000 100000
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
OpLine %fname1 1 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
OpLine %fname1 1 1
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %x
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
