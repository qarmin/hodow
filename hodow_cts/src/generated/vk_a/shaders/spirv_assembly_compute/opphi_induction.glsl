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
%id         = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%one        = OpConstant %i32 1
%three      = OpConstant %i32 3
%constf6p5  = OpConstant %f32 6.5
%main       = OpFunction %void None %voidf
%entry      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
              OpBranch %phi
%phi        = OpLabel
%step       = OpPhi %i32 %zero  %entry %step_next  %phi
%accum      = OpPhi %f32 %inval %entry %accum_next %phi
%step_next  = OpIAdd %i32 %step %one
%accum_next = OpFAdd %f32 %accum %constf6p5
%still_loop = OpSLessThan %bool %step %three
              OpLoopMerge %exit %phi None
              OpBranchConditional %still_loop %phi %exit
%exit       = OpLabel
              OpStore %outloc %accum
              OpReturn
              OpFunctionEnd
