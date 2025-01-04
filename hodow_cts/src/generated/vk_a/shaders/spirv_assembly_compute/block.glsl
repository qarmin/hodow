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
%u32ptr       = OpTypePointer Function %u32
%u32ptr_input = OpTypePointer Input %u32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%const3    = OpConstant %u32 3
%const50   = OpConstant %u32 50
%constf1p5 = OpConstant %f32 1.5
%constf27  = OpConstant %f32 27.0
%constf42  = OpConstant %f32 42.0
%main = OpFunction %void None %voidf
%entry    = OpLabel
%xvar     = OpVariable %u32ptr Function
%xptr     = OpAccessChain %u32ptr_input %id %zero
%x        = OpLoad %u32 %xptr
            OpStore %xvar %x
%cmp      = OpUGreaterThan %bool %x %const50
            OpSelectionMerge %if_merge None
            OpBranchConditional %cmp %if_true %if_false
%if_false = OpLabel
%x_f      = OpLoad %u32 %xvar
%inloc_f  = OpAccessChain %f32ptr %indata %zero %x_f
%inval_f  = OpLoad %f32 %inloc_f
%negate   = OpFNegate %f32 %inval_f
%outloc_f = OpAccessChain %f32ptr %outdata %zero %x_f
            OpStore %outloc_f %negate
            OpBranch %if_merge
%if_merge = OpLabel
            OpReturn
%if_true  = OpLabel
%xval_t   = OpLoad %u32 %xvar
%mod      = OpUMod %u32 %xval_t %const3
            OpSelectionMerge %switch_merge None
            OpSwitch %mod %default 0 %case0 1 %case1 2 %case2
%switch_merge = OpLabel
                OpBranch %if_merge
%case1    = OpLabel
%x_1      = OpLoad %u32 %xvar
%inloc_1  = OpAccessChain %f32ptr %indata %zero %x_1
%inval_1  = OpLoad %f32 %inloc_1
%addf42   = OpFAdd %f32 %inval_1 %constf42
%outloc_1 = OpAccessChain %f32ptr %outdata %zero %x_1
            OpStore %outloc_1 %addf42
            OpBranch %switch_merge
%case2    = OpLabel
%x_2      = OpLoad %u32 %xvar
%inloc_2  = OpAccessChain %f32ptr %indata %zero %x_2
%inval_2  = OpLoad %f32 %inloc_2
%subf27   = OpFSub %f32 %inval_2 %constf27
%outloc_2 = OpAccessChain %f32ptr %outdata %zero %x_2
            OpStore %outloc_2 %subf27
            OpBranch %switch_merge
%default = OpLabel
           OpBranch %switch_merge
%case0    = OpLabel
%x_0      = OpLoad %u32 %xvar
%inloc_0  = OpAccessChain %f32ptr %indata %zero %x_0
%inval_0  = OpLoad %f32 %inloc_0
%addf1p5  = OpFAdd %f32 %inval_0 %constf1p5
%outloc_0 = OpAccessChain %f32ptr %outdata %zero %x_0
            OpStore %outloc_0 %addf1p5
            OpBranch %switch_merge
            OpFunctionEnd
