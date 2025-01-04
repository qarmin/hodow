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
%id = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%three      = OpConstant %u32 3
%constf5p5  = OpConstant %f32 5.5
%constf20p5 = OpConstant %f32 20.5
%constf1p75 = OpConstant %f32 1.75
%constf8p5  = OpConstant %f32 8.5
%constf6p5  = OpConstant %f32 6.5
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%selector = OpUMod %u32 %x %three
            OpSelectionMerge %phi None
            OpSwitch %selector %default 0 %case0 1 %case1 2 %case2
%case1    = OpLabel
            OpBranch %phi
%default  = OpLabel
            OpUnreachable
%phi      = OpLabel
%operand  = OpPhi %f32   %constf1p75 %case2   %constf20p5 %case1   %constf5p5 %case0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%add      = OpFAdd %f32 %inval %operand
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
            OpStore %outloc %add
            OpReturn
%case0    = OpLabel
            OpBranch %phi
%case2    = OpLabel
            OpBranch %phi
            OpFunctionEnd
