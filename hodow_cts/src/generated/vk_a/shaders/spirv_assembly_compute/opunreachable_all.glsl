OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main            "main"
OpName %func_not_called_func "not_called_func("
OpName %func_modulo4         "modulo4(u1;"
OpName %func_const5          "const5("
OpName %id                   "gl_GlobalInvocationID"
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
%u32ptr    = OpTypePointer Function %u32
%uintfuint = OpTypeFunction %u32 %u32ptr
%unitf     = OpTypeFunction %u32
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %u32 0
%one       = OpConstant %u32 1
%two       = OpConstant %u32 2
%three     = OpConstant %u32 3
%four      = OpConstant %u32 4
%five      = OpConstant %u32 5
%hundred   = OpConstant %u32 100
%thousand  = OpConstant %u32 1000
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%main   = OpFunction %void None %voidf
%main_entry  = OpLabel
%v_thousand  = OpVariable %u32ptr Function %thousand
%idval       = OpLoad %uvec3 %id
%x           = OpCompositeExtract %u32 %idval 0
%inloc       = OpAccessChain %f32ptr %indata %zero %x
%inval       = OpLoad %f32 %inloc
%outloc      = OpAccessChain %f32ptr %outdata %zero %x
%ret_const5  = OpFunctionCall %u32 %func_const5
%ret_modulo4 = OpFunctionCall %u32 %func_modulo4 %v_thousand
%cmp_gt      = OpUGreaterThan %bool %ret_const5 %ret_modulo4
               OpSelectionMerge %if_end None
               OpBranchConditional %cmp_gt %if_true %if_false
%if_true     = OpLabel
%negate      = OpFNegate %f32 %inval
               OpStore %outloc %negate
               OpBranch %if_end
%if_false    = OpLabel
               OpUnreachable
%if_end      = OpLabel
               OpReturn
               OpFunctionEnd
%func_not_called_func  = OpFunction %void None %voidf
%not_called_func_entry = OpLabel
                         OpUnreachable
                         OpFunctionEnd
%func_modulo4  = OpFunction %u32 None %uintfuint
%valptr        = OpFunctionParameter %u32ptr
%modulo4_entry = OpLabel
%val           = OpLoad %u32 %valptr
%modulo        = OpUMod %u32 %val %four
                 OpSelectionMerge %switch_merge None
                 OpSwitch %modulo %default 0 %case0 1 %case1 2 %case2 3 %case3
%case0         = OpLabel
                 OpReturnValue %three
%case1         = OpLabel
                 OpReturnValue %two
%case2         = OpLabel
                 OpReturnValue %one
%case3         = OpLabel
                 OpReturnValue %zero
%default       = OpLabel
                 OpUnreachable
%switch_merge  = OpLabel
                 OpUnreachable
                 OpFunctionEnd
%func_const5  = OpFunction %u32 None %unitf
%const5_entry = OpLabel
                OpReturnValue %five
%unreachable  = OpLabel
                OpUnreachable
                OpFunctionEnd
