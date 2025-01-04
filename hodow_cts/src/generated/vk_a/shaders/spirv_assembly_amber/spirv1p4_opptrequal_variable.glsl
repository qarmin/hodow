; Tests pointer comparisons with variable pointers
; Stores an array of pointers in Function storage class that point into input
; SSBO. Each iteration produces an OpPtrEqual comparison. Pointers evolve by
; incrementing or decrementing by 1 each iteration (overall ratio is 2:1).
OpCapability Shader
OpCapability VariablePointers
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %int_rta ArrayStride 4
OpDecorate %in_struct Block
OpMemberDecorate %in_struct 0 Offset 0
OpMemberDecorate %in_struct 1 Offset 4
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
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
%int_rta = OpTypeRuntimeArray %int
%in_struct = OpTypeStruct %int %int_rta
%ptr_ssbo_in_struct = OpTypePointer StorageBuffer %in_struct
%in_var = OpVariable %ptr_ssbo_in_struct StorageBuffer
%out_struct = OpTypeStruct %int_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%array_ptr = OpTypeArray %ptr_ssbo_int %int_2
%ptr_ptr = OpTypePointer Function %array_ptr
%ptr_func_ptr = OpTypePointer Function %ptr_ssbo_int
%ptr_ssbo_n = OpTypePointer StorageBuffer %int
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
%equal = OpPtrEqual %bool %gep_0 %gep_1
%equal_int = OpSelect %int %equal %int_1 %int_0
%out_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %i
OpStore %out_gep %equal_int
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
; This test generates four results per iteration of the loop. The loop is executed %n times.
; Each iteration generates a result for OpPtrEqual. One
; pointer is an iterator through the input SSBO (%in_var) and the other is a
; selection between the iterator, null or the 0'th index pointer depending on
; the value of the iterator mod 3.
OpCapability Shader
OpCapability VariablePointersStorageBuffer
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %int_rta ArrayStride 4
OpDecorate %ptr_ssbo_int ArrayStride 4
OpDecorate %in_struct Block
OpMemberDecorate %in_struct 0 Offset 0
OpMemberDecorate %in_struct 1 Offset 4
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_struct Block
OpMemberDecorate %out_struct 0 Offset 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
%void = OpTypeVoid
%bool = OpTypeBool
%int = OpTypeInt 32 1
%int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
%int2 = OpTypeVector %int 2
%int_rta = OpTypeRuntimeArray %int
%int2_rta = OpTypeRuntimeArray %int2
%in_struct = OpTypeStruct %int %int_rta
%ptr_ssbo_in_struct = OpTypePointer StorageBuffer %in_struct
%in_var = OpVariable %ptr_ssbo_in_struct StorageBuffer
%out_struct = OpTypeStruct %int_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%ptr_ssbo_int_null = OpConstantNull %ptr_ssbo_int
%ptr_ssbo_n = OpTypePointer StorageBuffer %int
%ptr_ssbo_int2 = OpTypePointer StorageBuffer %int2
%void_fn = OpTypeFunction %void
%ptr_return_fn = OpTypeFunction %ptr_ssbo_int %ptr_ssbo_int %ptr_ssbo_int %int
%main = OpFunction %void None %void_fn
%entry = OpLabel
%n_gep = OpAccessChain %ptr_ssbo_n %in_var %int_0
%n = OpLoad %int %n_gep
%base_ssbo_gep = OpAccessChain %ptr_ssbo_int %in_var %int_1 %int_0
%n_leq_0 = OpSLessThanEqual %bool %n %int_0
OpSelectionMerge %exit None
OpBranchConditional %n_leq_0 %exit %loop
%loop = OpLabel
%i = OpPhi %int %int_0 %entry %inc_i %loop
%ssbo_gep = OpPhi %ptr_ssbo_int %base_ssbo_gep %entry %next_ssbo_gep %loop
%inc_i = OpIAdd %int %i %int_1
%next_ssbo_gep = OpPtrAccessChain %ptr_ssbo_int %ssbo_gep %int_1
%ptr_call = OpFunctionCall %ptr_ssbo_int %gep_func %ssbo_gep %base_ssbo_gep %i
%equal = OpPtrEqual %bool %ssbo_gep %ptr_call
%equal_int = OpSelect %int %equal %int_1 %int_0
%out_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %i
OpStore %out_gep %equal_int
%cmp = OpSGreaterThanEqual %bool %i %n
OpLoopMerge %loop_exit %loop None
OpBranchConditional %cmp %loop_exit %loop
%loop_exit = OpLabel
OpBranch %exit
%exit = OpLabel
OpReturn
OpFunctionEnd
%gep_func = OpFunction %ptr_ssbo_int None %ptr_return_fn
%param_ptr = OpFunctionParameter %ptr_ssbo_int
%param_alt_ptr = OpFunctionParameter %ptr_ssbo_int
%param_i = OpFunctionParameter %int
%1 = OpLabel
%i_mod_3 = OpSMod %int %param_i %int_3
%i_mod_3_is_0 = OpIEqual %bool %i_mod_3 %int_0
%i_mod_3_is_1 = OpIEqual %bool %i_mod_3 %int_1
%ssbo_gep1 = OpSelect %ptr_ssbo_int %i_mod_3_is_0 %param_alt_ptr %ptr_ssbo_int_null
%ssbo_gep2 = OpSelect %ptr_ssbo_int %i_mod_3_is_1 %param_ptr %ssbo_gep1
OpReturnValue %ssbo_gep2
OpFunctionEnd
; Tests use of private variables holding SSBO pointers and pointer comparisons.
; Two iterators are each stored in Private variables: one moves forward, one
; moves backward. In each iteration an OpPtrEqual comparison is written.
; Iterators are then moved forward (or backward respectively) one index.
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
%int_rta = OpTypeRuntimeArray %int
%in_struct = OpTypeStruct %int %int_rta
%ptr_ssbo_in_struct = OpTypePointer StorageBuffer %in_struct
%in_var = OpVariable %ptr_ssbo_in_struct StorageBuffer
%out_struct = OpTypeStruct %int_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%ptr_ptr = OpTypePointer Private %ptr_ssbo_int
%forward_var = OpVariable %ptr_ptr Private
%backward_var = OpVariable %ptr_ptr Private
%ptr_ssbo_n = OpTypePointer StorageBuffer %int
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
%equal = OpPtrEqual %bool %forward_gep %backward_gep
%equal_int = OpSelect %int %equal %int_1 %int_0
%out_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %i
OpStore %out_gep %equal_int
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
; moves backward. In each iteration an equal comparison is written. Iterators
; are then moved forward (or backward respectively) one index.
OpCapability Shader
OpCapability VariablePointers
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %wg_var %out_var %forward_var %backward_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %int_rta ArrayStride 4
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
%int_array_32 = OpTypeArray %int %int_32
%ptr_wg_array = OpTypePointer Workgroup %int_array_32
%wg_var = OpVariable %ptr_wg_array Workgroup
%int_rta = OpTypeRuntimeArray %int
%out_struct = OpTypeStruct %int_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_wg_int = OpTypePointer Workgroup %int
%ptr_ptr = OpTypePointer Private %ptr_wg_int
%forward_var = OpVariable %ptr_ptr Private
%backward_var = OpVariable %ptr_ptr Private
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
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
%equal = OpPtrEqual %bool %forward_gep %backward_gep
%equal_int = OpSelect %int %equal %int_1 %int_0
%out_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %i
OpStore %out_gep %equal_int
%cmp = OpSGreaterThan %bool %i %int_32
OpLoopMerge %exit %loop None
OpBranchConditional %cmp %exit %loop
%exit = OpLabel
OpReturn
OpFunctionEnd
; This test generates four results per iteration of the loop. The loop is executed 64 times.
; Each iteration generates results for OpPtrEqual. One pointer is an iterator
; through the workgroup variable (%wg_var) and the other is a selection between
; the iterator, null or the 0'th index pointer depending on the value of the
; iterator mod 3.
OpCapability Shader
OpCapability VariablePointers
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %wg_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %int_rta ArrayStride 4
OpDecorate %ptr_wg_int ArrayStride 4
OpDecorate %out_struct Block
OpMemberDecorate %out_struct 0 Offset 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 0
%void = OpTypeVoid
%bool = OpTypeBool
%int = OpTypeInt 32 1
%int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
%int_32 = OpConstant %int 32
%int_array = OpTypeArray %int %int_32
%int_rta = OpTypeRuntimeArray %int
%ptr_wg_int_array = OpTypePointer Workgroup %int_array
%wg_var = OpVariable %ptr_wg_int_array Workgroup
%out_struct = OpTypeStruct %int_rta
%ptr_ssbo_out_struct = OpTypePointer StorageBuffer %out_struct
%out_var = OpVariable %ptr_ssbo_out_struct StorageBuffer
%ptr_wg_int = OpTypePointer Workgroup %int
%ptr_wg_int_null = OpConstantNull %ptr_wg_int
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%void_fn = OpTypeFunction %void
%ptr_return_fn = OpTypeFunction %ptr_wg_int %ptr_wg_int %ptr_wg_int %int
%main = OpFunction %void None %void_fn
%entry = OpLabel
%base_wg_gep = OpAccessChain %ptr_wg_int %wg_var %int_0
OpBranch %loop
%loop = OpLabel
%i = OpPhi %int %int_0 %entry %inc_i %loop
%wg_gep = OpPhi %ptr_wg_int %base_wg_gep %entry %next_wg_gep %loop
%inc_i = OpIAdd %int %i %int_1
%next_wg_gep = OpPtrAccessChain %ptr_wg_int %wg_gep %int_1
%ptr_call = OpFunctionCall %ptr_wg_int %gep_func %wg_gep %base_wg_gep %i
%equal = OpPtrEqual %bool %wg_gep %ptr_call
%equal_int = OpSelect %int %equal %int_1 %int_0
%out_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %i
OpStore %out_gep %equal_int
%cmp = OpSGreaterThan %bool %i %int_32
OpLoopMerge %exit %loop None
OpBranchConditional %cmp %exit %loop
%exit = OpLabel
OpReturn
OpFunctionEnd
%gep_func = OpFunction %ptr_wg_int None %ptr_return_fn
%param_ptr = OpFunctionParameter %ptr_wg_int
%param_alt_ptr = OpFunctionParameter %ptr_wg_int
%param_i = OpFunctionParameter %int
%1 = OpLabel
%i_mod_3 = OpSMod %int %param_i %int_3
%i_mod_3_is_0 = OpIEqual %bool %i_mod_3 %int_0
%i_mod_3_is_1 = OpIEqual %bool %i_mod_3 %int_1
%wg_gep1 = OpSelect %ptr_wg_int %i_mod_3_is_0 %param_alt_ptr %ptr_wg_int_null
%wg_gep2 = OpSelect %ptr_wg_int %i_mod_3_is_1 %param_ptr %wg_gep1
OpReturnValue %wg_gep2
OpFunctionEnd
