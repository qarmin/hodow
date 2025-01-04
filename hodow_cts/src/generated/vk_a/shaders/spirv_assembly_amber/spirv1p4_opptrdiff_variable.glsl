; Tests pointer comparisons with variable pointers
; Stores an array of pointers in Function storage class that point into input
; SSBO. Each iteration produces an int2 result containing two OpPtrDiffs
; Pointers evolve by incrementing or decrementing by 1 each iteration (overall
; ratio is 2:1).
; All uses of OpPtrDiff are within %in_var, so we only need
; VariablePointersStorageBuffer capability and the corresponding Vulkan
; feature bit.
OpCapability Shader
OpCapability VariablePointersStorageBuffer
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %int_rta ArrayStride 4
OpDecorate %in_struct Block
OpMemberDecorate %in_struct 0 Offset 0
OpMemberDecorate %in_struct 1 Offset 4
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %int2_rta ArrayStride 8
OpDecorate %out_struct Block
OpMemberDecorate %out_struct 0 Offset 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorate %ptr_ssbo_int ArrayStride 4
%void = OpTypeVoid
%bool = OpTypeBool
%uint = OpTypeInt 32 0
%int = OpTypeInt 32 1
%int_n1 = OpConstant %int -1
%int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
%int2 = OpTypeVector %int 2
%int_rta = OpTypeRuntimeArray %int
%in_struct = OpTypeStruct %int %int_rta
%ptr_ssbo_in_struct = OpTypePointer StorageBuffer %in_struct
%in_var = OpVariable %ptr_ssbo_in_struct StorageBuffer
%int2_rta = OpTypeRuntimeArray %int2
%out_struct = OpTypeStruct %int2_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%array_ptr = OpTypeArray %ptr_ssbo_int %int_2
%ptr_ptr = OpTypePointer Function %array_ptr
%ptr_func_ptr = OpTypePointer Function %ptr_ssbo_int
%ptr_ssbo_n = OpTypePointer StorageBuffer %int
%ptr_ssbo_int2 = OpTypePointer StorageBuffer %int2
%void_fn = OpTypeFunction %void
%main = OpFunction %void None %void_fn
%entry = OpLabel
%var = OpVariable %ptr_ptr Function
%n_gep = OpAccessChain %ptr_ssbo_n %in_var %int_0
%n = OpLoad %int %n_gep
%length = OpArrayLength %uint %in_var 1
%length_div_2 = OpSDiv %int %length %int_2
%mid_gep = OpAccessChain %ptr_ssbo_int %in_var %int_1 %length_div_2
%func_gep_0 = OpAccessChain %ptr_func_ptr %var %int_0
%func_gep_1 = OpAccessChain %ptr_func_ptr %var %int_1
OpStore %func_gep_0 %mid_gep
OpStore %func_gep_1 %mid_gep
%cmp_n = OpSLessThanEqual %bool %n %int_0
OpSelectionMerge %exit None
OpBranchConditional %cmp_n %exit %loop
%loop = OpLabel
%i = OpPhi %int %int_0 %entry %inc_i %continue
%gep_0 = OpLoad %ptr_ssbo_int %func_gep_0
%gep_1 = OpLoad %ptr_ssbo_int %func_gep_1
%inc_i = OpIAdd %int %i %int_1
%diff1 = OpPtrDiff %int %gep_0 %gep_1
%diff2 = OpPtrDiff %int %gep_1 %gep_0
%result = OpCompositeConstruct %int2 %diff1 %diff2
%out_gep = OpAccessChain %ptr_ssbo_int2 %out_var %int_0 %i
OpStore %out_gep %result
OpLoopMerge %loop_exit %continue None
OpBranch %body
%body = OpLabel
%i_mod_3 = OpSMod %int %i %int_3
%cmp_vs_0 = OpIEqual %bool %i_mod_3 %int_0
OpSelectionMerge %if_merge None
OpBranchConditional %cmp_vs_0 %then %else
%then = OpLabel
%then_0_next = OpPtrAccessChain %ptr_ssbo_int %gep_0 %int_n1
%then_1_next = OpPtrAccessChain %ptr_ssbo_int %gep_1 %int_1
OpBranch %if_merge
%else = OpLabel
%else_0_next = OpPtrAccessChain %ptr_ssbo_int %gep_0 %int_1
%else_1_next = OpPtrAccessChain %ptr_ssbo_int %gep_1 %int_n1
OpBranch %if_merge
%if_merge = OpLabel
%next_0 = OpPhi %ptr_ssbo_int %then_0_next %then %else_0_next %else
%next_1 = OpPhi %ptr_ssbo_int %then_1_next %then %else_1_next %else
OpBranch %continue
%continue = OpLabel
OpStore %func_gep_0 %next_0
OpStore %func_gep_1 %next_1
%cmp = OpSGreaterThanEqual %bool %i %n
OpBranchConditional %cmp %loop_exit %loop
%loop_exit = OpLabel
OpBranch %exit
%exit = OpLabel
OpReturn
OpFunctionEnd
; Tests use of private variables holding SSBO pointers and pointer comparisons.
; Two iterators are each stored in Private variables: one moves forward, one
; moves backward. In each iteration an int2 result is written that contains two
; diffs. Iterators are then moved forward (or backward respectively) one index.
OpCapability Shader
OpCapability VariablePointersStorageBuffer
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var %forward_var %backward_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %int_rta ArrayStride 4
OpDecorate %in_struct Block
OpMemberDecorate %in_struct 0 Offset 0
OpMemberDecorate %in_struct 1 Offset 4
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %int2_rta ArrayStride 8
OpDecorate %out_struct Block
OpMemberDecorate %out_struct 0 Offset 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorate %ptr_ssbo_int ArrayStride 4
%void = OpTypeVoid
%bool = OpTypeBool
%int = OpTypeInt 32 1
%int_n1 = OpConstant %int -1
%int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
%int2 = OpTypeVector %int 2
%int_rta = OpTypeRuntimeArray %int
%in_struct = OpTypeStruct %int %int_rta
%ptr_ssbo_in_struct = OpTypePointer StorageBuffer %in_struct
%in_var = OpVariable %ptr_ssbo_in_struct StorageBuffer
%int2_rta = OpTypeRuntimeArray %int2
%out_struct = OpTypeStruct %int2_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%ptr_ptr = OpTypePointer Private %ptr_ssbo_int
%forward_var = OpVariable %ptr_ptr Private
%backward_var = OpVariable %ptr_ptr Private
%ptr_ssbo_n = OpTypePointer StorageBuffer %int
%ptr_ssbo_int2 = OpTypePointer StorageBuffer %int2
%void_fn = OpTypeFunction %void
%main = OpFunction %void None %void_fn
%entry = OpLabel
%n_gep = OpAccessChain %ptr_ssbo_n %in_var %int_0
%n = OpLoad %int %n_gep
%first_gep = OpAccessChain %ptr_ssbo_int %in_var %int_1 %int_0
OpStore %forward_var %first_gep
%last_gep = OpPtrAccessChain %ptr_ssbo_int %first_gep %n
OpStore %backward_var %last_gep
%cmp_n = OpSLessThanEqual %bool %n %int_0
OpSelectionMerge %exit None
OpBranchConditional %cmp_n %exit %loop
%loop = OpLabel
%i = OpPhi %int %int_0 %entry %inc_i %loop
%forward_gep = OpLoad %ptr_ssbo_int %forward_var
%backward_gep = OpLoad %ptr_ssbo_int %backward_var
%forward_next = OpPtrAccessChain %ptr_ssbo_int %forward_gep %int_1
%backward_next = OpPtrAccessChain %ptr_ssbo_int %backward_gep %int_n1
%inc_i = OpIAdd %int %i %int_1
OpStore %forward_var %forward_next
OpStore %backward_var %backward_next
%diff1 = OpPtrDiff %int %forward_gep %backward_gep
%diff2 = OpPtrDiff %int %backward_gep %forward_gep
%result = OpCompositeConstruct %int2 %diff1 %diff2
%out_gep = OpAccessChain %ptr_ssbo_int2 %out_var %int_0 %i
OpStore %out_gep %result
%cmp = OpSGreaterThanEqual %bool %i %n
OpLoopMerge %loop_exit %loop None
OpBranchConditional %cmp %loop_exit %loop
%loop_exit = OpLabel
OpBranch %exit
%exit = OpLabel
OpReturn
OpFunctionEnd
; Tests use of private variables holding workgroup pointers and pointer comparisons.
; Two iterators are each stored in Private variables: one moves forward, one
; moves backward. In each iteration an int2 result is written that contains
; two diffs (operands swapped). Iterators are then moved forward (or backward
; respectively) one index.
OpCapability Shader
OpCapability VariablePointers
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %wg_var %out_var %forward_var %backward_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %int2_rta ArrayStride 8
OpDecorate %out_struct Block
OpMemberDecorate %out_struct 0 Offset 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 0
OpDecorate %ptr_wg_int ArrayStride 4
%void = OpTypeVoid
%bool = OpTypeBool
%int = OpTypeInt 32 1
%int_n1 = OpConstant %int -1
%int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
%int_32 = OpConstant %int 32
%int2 = OpTypeVector %int 2
%int_array_32 = OpTypeArray %int %int_32
%ptr_wg_array = OpTypePointer Workgroup %int_array_32
%wg_var = OpVariable %ptr_wg_array Workgroup
%int2_rta = OpTypeRuntimeArray %int2
%out_struct = OpTypeStruct %int2_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_wg_int = OpTypePointer Workgroup %int
%ptr_ptr = OpTypePointer Private %ptr_wg_int
%forward_var = OpVariable %ptr_ptr Private
%backward_var = OpVariable %ptr_ptr Private
%ptr_ssbo_int2 = OpTypePointer StorageBuffer %int2
%void_fn = OpTypeFunction %void
%main = OpFunction %void None %void_fn
%entry = OpLabel
%first_gep = OpAccessChain %ptr_wg_int %wg_var %int_0
OpStore %forward_var %first_gep
%last_gep = OpPtrAccessChain %ptr_wg_int %first_gep %int_32
OpStore %backward_var %last_gep
OpBranch %loop
%loop = OpLabel
%i = OpPhi %int %int_0 %entry %inc_i %loop
%forward_gep = OpLoad %ptr_wg_int %forward_var
%backward_gep = OpLoad %ptr_wg_int %backward_var
%forward_next = OpPtrAccessChain %ptr_wg_int %forward_gep %int_1
%backward_next = OpPtrAccessChain %ptr_wg_int %backward_gep %int_n1
%inc_i = OpIAdd %int %i %int_1
OpStore %forward_var %forward_next
OpStore %backward_var %backward_next
%diff1 = OpPtrDiff %int %forward_gep %backward_gep
%diff2 = OpPtrDiff %int %backward_gep %forward_gep
%result = OpCompositeConstruct %int2 %diff1 %diff2
%out_gep = OpAccessChain %ptr_ssbo_int2 %out_var %int_0 %i
OpStore %out_gep %result
%cmp = OpSGreaterThan %bool %i %int_32
OpLoopMerge %exit %loop None
OpBranchConditional %cmp %exit %loop
%exit = OpLabel
OpReturn
OpFunctionEnd
