OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
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
%f32ptr_f   = OpTypePointer Function %f32
%id         = OpVariable %uvec3ptr Input
%true       = OpConstantTrue %bool
%false      = OpConstantFalse %bool
%zero       = OpConstant %i32 0
%constf8p5  = OpConstant %f32 8.5
%main       = OpFunction %void None %voidf
%entry      = OpLabel
%b          = OpVariable %f32ptr_f Function %constf8p5
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%a_init     = OpLoad %f32 %inloc
%b_init     = OpLoad %f32 %b
              OpBranch %phi
%phi        = OpLabel
%still_loop = OpPhi %bool %true   %entry %false  %phi
%a_next     = OpPhi %f32  %a_init %entry %b_next %phi
%b_next     = OpPhi %f32  %b_init %entry %a_next %phi
              OpLoopMerge %exit %phi None
              OpBranchConditional %still_loop %phi %exit
%exit       = OpLabel
%sub        = OpFSub %f32 %a_next %b_next
              OpStore %outloc %sub
              OpReturn
              OpFunctionEnd
