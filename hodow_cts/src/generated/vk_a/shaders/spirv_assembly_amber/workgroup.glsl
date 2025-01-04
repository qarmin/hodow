
OpCapability Shader
OpCapability WorkgroupMemoryExplicitLayoutKHR
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %input_buffer_0 %input_buffer_1 %output_buffer %wg %half_wg_0 %half_wg_1
OpExecutionMode %main LocalSize 1 1 1

OpDecorate %buffer_type Block
OpDecorate %half_buffer_type Block
OpDecorate %other_half_buffer_type Block
OpMemberDecorate %buffer_type 0 Offset 0
OpDecorate %array ArrayStride 4
OpMemberDecorate %half_buffer_type 0 Offset 0
OpMemberDecorate %other_half_buffer_type 0 Offset 64
OpDecorate %half_array ArrayStride 4
OpDecorate %input_buffer_0 DescriptorSet 0
OpDecorate %input_buffer_0 Binding 0
OpDecorate %input_buffer_1 DescriptorSet 0
OpDecorate %input_buffer_1 Binding 1
OpDecorate %output_buffer DescriptorSet 0
OpDecorate %output_buffer Binding 2
OpDecorate %wg Aliased
OpDecorate %half_wg_0 Aliased
OpDecorate %half_wg_1 Aliased

%uint = OpTypeInt 32 0
%const_uint_0 = OpConstant %uint 0
%const_uint_16 = OpConstant %uint 16
%const_uint_32 = OpConstant %uint 32
%const_uint_64 = OpConstant %uint 64

%void = OpTypeVoid
%main_type = OpTypeFunction %void
%array = OpTypeArray %uint %const_uint_32
%half_array = OpTypeArray %uint %const_uint_16
%half_array_wg_ptr = OpTypePointer Workgroup %half_array
%half_array_sb_ptr = OpTypePointer StorageBuffer %half_array
%buffer_type = OpTypeStruct %array
%half_buffer_type = OpTypeStruct %half_array
%other_half_buffer_type = OpTypeStruct %half_array
%input_buffer_0_ptr = OpTypePointer StorageBuffer %half_buffer_type
%input_buffer_1_ptr = OpTypePointer StorageBuffer %half_buffer_type
%output_buffer_ptr = OpTypePointer StorageBuffer %buffer_type
%wg_ptr = OpTypePointer Workgroup %buffer_type
%half_wg_0_ptr = OpTypePointer Workgroup %half_buffer_type
%half_wg_1_ptr = OpTypePointer Workgroup %other_half_buffer_type

;;; Workgroup has a block covering the entire memory and another two
;;; blocks covering each half of the former.

%wg = OpVariable %wg_ptr Workgroup
%half_wg_0 = OpVariable %half_wg_0_ptr Workgroup
%half_wg_1 = OpVariable %half_wg_1_ptr Workgroup

%input_buffer_0 = OpVariable %input_buffer_0_ptr StorageBuffer
%input_buffer_1 = OpVariable %input_buffer_1_ptr StorageBuffer
%output_buffer = OpVariable %output_buffer_ptr StorageBuffer

%main = OpFunction %void None %main_type
%entry = OpLabel

;;; Copy first input into half of the workgroup memory.  Because the
;;; whole types match here, we can afford to copy the Variables
;;; directly.

OpCopyMemory %half_wg_0 %input_buffer_0

;;; Then copy the second input into the other half of Workgroup
;;; memory, use OpAccessChain to extract the array pointers (what we
;;; are copying), since the whole types don't match (different Offsets
;;; in the block struct).

%a = OpAccessChain %half_array_wg_ptr %half_wg_1 %const_uint_0
%b = OpAccessChain %half_array_sb_ptr %input_buffer_1 %const_uint_0
OpCopyMemory %a %b

;;; The two halves of Workgroup memory were filled, now copy the large
;;; Workgroup block that alias the halves into the output.

OpCopyMemory %output_buffer %wg

OpReturn
OpFunctionEnd


OpCapability Shader
OpCapability WorkgroupMemoryExplicitLayoutKHR
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %index %push_constants %input_buffer_0 %input_buffer_1 %output_buffer %wg %half_wg_0 %half_wg_1
OpExecutionMode %main LocalSize 32 4 1

OpDecorate %index BuiltIn LocalInvocationIndex
OpDecorate %buffer_type Block
OpDecorate %half_buffer_type Block
OpDecorate %other_half_buffer_type Block
OpMemberDecorate %buffer_type 0 Offset 0
OpDecorate %array ArrayStride 4
OpMemberDecorate %half_buffer_type 0 Offset 0
OpMemberDecorate %other_half_buffer_type 0 Offset 64
OpDecorate %half_array ArrayStride 4
OpDecorate %input_buffer_0 DescriptorSet 0
OpDecorate %input_buffer_0 Binding 0
OpDecorate %input_buffer_1 DescriptorSet 0
OpDecorate %input_buffer_1 Binding 1
OpDecorate %output_buffer DescriptorSet 0
OpDecorate %output_buffer Binding 2
OpDecorate %wg Aliased
OpDecorate %half_wg_0 Aliased
OpDecorate %half_wg_1 Aliased
OpMemberDecorate %push_constants_type 0 Offset 0
OpMemberDecorate %push_constants_type 1 Offset 4
OpDecorate %push_constants_type Block

%uint = OpTypeInt 32 0
%const_uint_0 = OpConstant %uint 0
%const_uint_1 = OpConstant %uint 1
%const_uint_2 = OpConstant %uint 2
%const_uint_16 = OpConstant %uint 16
%const_uint_32 = OpConstant %uint 32
%const_uint_64 = OpConstant %uint 64
%const_uint_128 = OpConstant %uint 128
%uint_input_ptr = OpTypePointer Input %uint
%uint_pc_ptr = OpTypePointer PushConstant %uint

%bool = OpTypeBool
%void = OpTypeVoid
%main_type = OpTypeFunction %void
%array = OpTypeArray %uint %const_uint_32
%half_array = OpTypeArray %uint %const_uint_16
%half_array_wg_ptr = OpTypePointer Workgroup %half_array
%half_array_sb_ptr = OpTypePointer StorageBuffer %half_array
%buffer_type = OpTypeStruct %array
%half_buffer_type = OpTypeStruct %half_array
%other_half_buffer_type = OpTypeStruct %half_array
%input_buffer_0_ptr = OpTypePointer StorageBuffer %half_buffer_type
%input_buffer_1_ptr = OpTypePointer StorageBuffer %half_buffer_type
%output_buffer_ptr = OpTypePointer StorageBuffer %buffer_type
%wg_ptr = OpTypePointer Workgroup %buffer_type
%half_wg_0_ptr = OpTypePointer Workgroup %half_buffer_type
%half_wg_1_ptr = OpTypePointer Workgroup %other_half_buffer_type
%push_constants_type = OpTypeStruct %uint %uint
%push_constants_type_ptr = OpTypePointer PushConstant %push_constants_type

;;; Workgroup has a block covering the entire memory and another two
;;; blocks covering each half of the former.

%wg = OpVariable %wg_ptr Workgroup
%half_wg_0 = OpVariable %half_wg_0_ptr Workgroup
%half_wg_1 = OpVariable %half_wg_1_ptr Workgroup

%input_buffer_0 = OpVariable %input_buffer_0_ptr StorageBuffer
%input_buffer_1 = OpVariable %input_buffer_1_ptr StorageBuffer
%output_buffer = OpVariable %output_buffer_ptr StorageBuffer

%index = OpVariable %uint_input_ptr Input
%push_constants = OpVariable %push_constants_type_ptr PushConstant

%main = OpFunction %void None %main_type
%entry = OpLabel

;;; Look up in the push constants values a and b that will be use to select
;;; which invocation will do the work.

%index_val = OpLoad %uint %index
%first_ptr = OpAccessChain %uint_pc_ptr %push_constants %const_uint_0
%second_ptr = OpAccessChain %uint_pc_ptr %push_constants %const_uint_1
%first = OpLoad %uint %first_ptr
%second = OpLoad %uint %second_ptr
%is_first = OpIEqual %bool %index_val %first
%is_second = OpIEqual %bool %index_val %second

;;; Copy first input into half of the workgroup memory.  Because the
;;; whole types match here, we can afford to copy the Variables
;;; directly.  Only the first invocation specified will do that.

OpSelectionMerge %after_first_copy None
OpBranchConditional %is_first %first_copy %after_first_copy
%first_copy = OpLabel

OpCopyMemory %half_wg_0 %input_buffer_0

OpBranch %after_first_copy
%after_first_copy = OpLabel

;;; Then copy the second input into the other half of Workgroup
;;; memory, use OpAccessChain to extract the array pointers (what we
;;; are copying), since the whole types don't match (different Offsets
;;; in the block struct).  Only the second invocation specified will
;;; do that.

OpSelectionMerge %after_second_copy None
OpBranchConditional %is_second %second_copy %after_second_copy
%second_copy = OpLabel

%a = OpAccessChain %half_array_wg_ptr %half_wg_1 %const_uint_0
%b = OpAccessChain %half_array_sb_ptr %input_buffer_1 %const_uint_0
OpCopyMemory %a %b

OpBranch %after_second_copy
%after_second_copy = OpLabel

OpControlBarrier %const_uint_2 %const_uint_2 %const_uint_0

;;; The two halves of Workgroup memory were filled, now copy the large
;;; Workgroup block that alias the halves into the output.  Only the first
;;; invocation specified will do that.

OpSelectionMerge %after_third_copy None
OpBranchConditional %is_first %third_copy %after_third_copy
%third_copy = OpLabel

OpCopyMemory %output_buffer %wg

OpBranch %after_third_copy
%after_third_copy = OpLabel

OpReturn
OpFunctionEnd


OpCapability Shader
OpCapability WorkgroupMemoryExplicitLayoutKHR
OpCapability VariablePointers
OpCapability ShaderNonUniform
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
OpExtension "SPV_EXT_descriptor_indexing"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %index %push_constants %input_buffer_0 %input_buffer_1 %output_buffer %wg %half_wg_0 %half_wg_1
OpExecutionMode %main LocalSize 32 4 1

OpDecorate %index BuiltIn LocalInvocationIndex
OpDecorate %buffer_type Block
OpDecorate %half_buffer_type Block
OpDecorate %other_half_buffer_type Block
OpMemberDecorate %buffer_type 0 Offset 0
OpDecorate %array ArrayStride 4
OpMemberDecorate %half_buffer_type 0 Offset 0
OpMemberDecorate %other_half_buffer_type 0 Offset 64
OpDecorate %half_array ArrayStride 4
OpDecorate %input_buffer_0 DescriptorSet 0
OpDecorate %input_buffer_0 Binding 0
OpDecorate %input_buffer_1 DescriptorSet 0
OpDecorate %input_buffer_1 Binding 1
OpDecorate %output_buffer DescriptorSet 0
OpDecorate %output_buffer Binding 2
OpDecorate %wg Aliased
OpDecorate %half_wg_0 Aliased
OpDecorate %half_wg_1 Aliased
OpMemberDecorate %push_constants_type 0 Offset 0
OpMemberDecorate %push_constants_type 1 Offset 4
OpDecorate %push_constants_type Block
OpDecorate %src NonUniform

%uint = OpTypeInt 32 0
%const_uint_0 = OpConstant %uint 0
%const_uint_1 = OpConstant %uint 1
%const_uint_2 = OpConstant %uint 2
%const_uint_16 = OpConstant %uint 16
%const_uint_32 = OpConstant %uint 32
%const_uint_64 = OpConstant %uint 64
%const_uint_128 = OpConstant %uint 128
%uint_input_ptr = OpTypePointer Input %uint
%uint_pc_ptr = OpTypePointer PushConstant %uint

%bool = OpTypeBool
%void = OpTypeVoid
%main_type = OpTypeFunction %void
%array = OpTypeArray %uint %const_uint_32
%half_array = OpTypeArray %uint %const_uint_16
%half_array_wg_ptr = OpTypePointer Workgroup %half_array
%half_array_sb_ptr = OpTypePointer StorageBuffer %half_array
%buffer_type = OpTypeStruct %array
%half_buffer_type = OpTypeStruct %half_array
%other_half_buffer_type = OpTypeStruct %half_array
%input_buffer_0_ptr = OpTypePointer StorageBuffer %half_buffer_type
%input_buffer_1_ptr = OpTypePointer StorageBuffer %half_buffer_type
%output_buffer_ptr = OpTypePointer StorageBuffer %buffer_type
%wg_ptr = OpTypePointer Workgroup %buffer_type
%half_wg_0_ptr = OpTypePointer Workgroup %half_buffer_type
%half_wg_1_ptr = OpTypePointer Workgroup %other_half_buffer_type
%push_constants_type = OpTypeStruct %uint %uint
%push_constants_type_ptr = OpTypePointer PushConstant %push_constants_type
%null_src = OpConstantNull %half_array_sb_ptr

;;; Workgroup has a block covering the entire memory and another two
;;; blocks covering each half of the former.

%wg = OpVariable %wg_ptr Workgroup
%half_wg_0 = OpVariable %half_wg_0_ptr Workgroup
%half_wg_1 = OpVariable %half_wg_1_ptr Workgroup

%input_buffer_0 = OpVariable %input_buffer_0_ptr StorageBuffer
%input_buffer_1 = OpVariable %input_buffer_1_ptr StorageBuffer
%output_buffer = OpVariable %output_buffer_ptr StorageBuffer

%index = OpVariable %uint_input_ptr Input
%push_constants = OpVariable %push_constants_type_ptr PushConstant

%main = OpFunction %void None %main_type
%entry = OpLabel

;;; Look up in the push constants values a and b that will be use to select
;;; which invocation will do the work.

%index_val = OpLoad %uint %index
%first_ptr = OpAccessChain %uint_pc_ptr %push_constants %const_uint_0
%second_ptr = OpAccessChain %uint_pc_ptr %push_constants %const_uint_1
%first = OpLoad %uint %first_ptr
%second = OpLoad %uint %second_ptr
%is_first = OpIEqual %bool %index_val %first
%is_second = OpIEqual %bool %index_val %second
%is_first_or_second = OpLogicalOr %bool %is_first %is_second

;;; Set the values for %dst using Select.

%ptr_to_array_wg_0 = OpAccessChain %half_array_wg_ptr %half_wg_0 %const_uint_0
%ptr_to_array_wg_1 = OpAccessChain %half_array_wg_ptr %half_wg_1 %const_uint_0
%dst = OpSelect %half_array_wg_ptr %is_first %ptr_to_array_wg_0 %ptr_to_array_wg_1

;;; Set the values for %src using OpPhi.

OpSelectionMerge %after_src_choice None
OpBranchConditional %is_first %src_for_first %next

%src_for_first = OpLabel
%first_src = OpAccessChain %half_array_sb_ptr %input_buffer_0 %const_uint_0
OpBranch %after_src_choice

%next = OpLabel
OpSelectionMerge %merge_inner None
OpBranchConditional %is_second %src_for_second %src_is_null

%src_for_second = OpLabel
%second_src = OpAccessChain %half_array_sb_ptr %input_buffer_1 %const_uint_0
OpBranch %merge_inner

%src_is_null = OpLabel
OpBranch %merge_inner

%merge_inner = OpLabel
%inner_src = OpPhi %half_array_sb_ptr %second_src %src_for_second %null_src %src_is_null
OpBranch %after_src_choice

%after_src_choice = OpLabel
%src = OpPhi %half_array_sb_ptr %first_src %src_for_first %inner_src %merge_inner

;;; The first and second invocations identified will copy from src to
;;; dst.

OpSelectionMerge %after_var_copy None
OpBranchConditional %is_first_or_second %var_copy %after_var_copy

%var_copy = OpLabel
OpCopyMemory %dst %src
OpBranch %after_var_copy

%after_var_copy = OpLabel

OpControlBarrier %const_uint_2 %const_uint_2 %const_uint_0

;;; The two halves of Workgroup memory were filled, now copy the large
;;; Workgroup block that alias the halves into the output.  Only the first
;;; invocation specified will do that.

OpSelectionMerge %after_output_copy None
OpBranchConditional %is_first %output_copy %after_output_copy

%output_copy = OpLabel
OpCopyMemory %output_buffer %wg
OpBranch %after_output_copy

%after_output_copy = OpLabel
OpReturn
OpFunctionEnd


OpCapability Shader
OpCapability WorkgroupMemoryExplicitLayoutKHR
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %index %push_constants %output_buffer %wg
OpExecutionMode %main LocalSize 32 4 1

OpDecorate %index BuiltIn LocalInvocationIndex
OpDecorate %buffer_type Block
OpMemberDecorate %buffer_type 0 Offset 0
OpDecorate %array ArrayStride 4
OpDecorate %output_buffer DescriptorSet 0
OpDecorate %output_buffer Binding 1
OpDecorate %wg Aliased
OpMemberDecorate %push_constants_type 0 Offset 0
OpDecorate %push_constants_type Block

%uint = OpTypeInt 32 0
%const_uint_0 = OpConstant %uint 0
%const_uint_32 = OpConstant %uint 32
%uint_input_ptr = OpTypePointer Input %uint
%uint_pc_ptr = OpTypePointer PushConstant %uint

%bool = OpTypeBool
%void = OpTypeVoid
%main_type = OpTypeFunction %void
%array = OpTypeArray %uint %const_uint_32
%buffer_type = OpTypeStruct %array
%output_buffer_ptr = OpTypePointer StorageBuffer %buffer_type
%wg_ptr = OpTypePointer Workgroup %buffer_type
%push_constants_type = OpTypeStruct %uint
%push_constants_type_ptr = OpTypePointer PushConstant %push_constants_type
%null_buffer = OpConstantNull %buffer_type

;;; Workgroup variable has a "null initializer".

%wg = OpVariable %wg_ptr Workgroup %null_buffer
%output_buffer = OpVariable %output_buffer_ptr StorageBuffer

%index = OpVariable %uint_input_ptr Input
%push_constants = OpVariable %push_constants_type_ptr PushConstant

%main = OpFunction %void None %main_type
%entry = OpLabel

;;; Look up in the push constant to select which invocation will do
;;; the work.

%index_val = OpLoad %uint %index
%worker_ptr = OpAccessChain %uint_pc_ptr %push_constants %const_uint_0
%worker = OpLoad %uint %worker_ptr
%is_worker = OpIEqual %bool %index_val %worker

OpSelectionMerge %after_copy None
OpBranchConditional %is_worker %copy %after_copy
%copy = OpLabel

OpCopyMemory %output_buffer %wg

OpBranch %after_copy
%after_copy = OpLabel

OpReturn
OpFunctionEnd


OpCapability Shader
OpCapability WorkgroupMemoryExplicitLayoutKHR
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %index %push_constants %output_buffer %wg %other_wg
OpExecutionMode %main LocalSize 32 4 1

OpDecorate %index BuiltIn LocalInvocationIndex
OpDecorate %buffer_type Block
OpMemberDecorate %buffer_type 0 Offset 0
OpDecorate %array ArrayStride 4
OpDecorate %output_buffer DescriptorSet 0
OpDecorate %output_buffer Binding 1
OpDecorate %wg Aliased
OpDecorate %other_wg Aliased
OpMemberDecorate %push_constants_type 0 Offset 0
OpDecorate %push_constants_type Block

%uint = OpTypeInt 32 0
%const_uint_0 = OpConstant %uint 0
%const_uint_32 = OpConstant %uint 32
%uint_input_ptr = OpTypePointer Input %uint
%uint_pc_ptr = OpTypePointer PushConstant %uint

%bool = OpTypeBool
%void = OpTypeVoid
%main_type = OpTypeFunction %void
%array = OpTypeArray %uint %const_uint_32
%buffer_type = OpTypeStruct %array
%output_buffer_ptr = OpTypePointer StorageBuffer %buffer_type
%wg_ptr = OpTypePointer Workgroup %buffer_type
%push_constants_type = OpTypeStruct %uint
%push_constants_type_ptr = OpTypePointer PushConstant %push_constants_type
%null_buffer = OpConstantNull %buffer_type

;;; One variable has a "null initializer" and the other not.

%wg = OpVariable %wg_ptr Workgroup %null_buffer
%other_wg = OpVariable %wg_ptr Workgroup
%output_buffer = OpVariable %output_buffer_ptr StorageBuffer

%index = OpVariable %uint_input_ptr Input
%push_constants = OpVariable %push_constants_type_ptr PushConstant

%main = OpFunction %void None %main_type
%entry = OpLabel

;;; Look up in the push constant to select which invocation will do
;;; the work.

%index_val = OpLoad %uint %index
%worker_ptr = OpAccessChain %uint_pc_ptr %push_constants %const_uint_0
%worker = OpLoad %uint %worker_ptr
%is_worker = OpIEqual %bool %index_val %worker

OpSelectionMerge %after_copy None
OpBranchConditional %is_worker %copy %after_copy
%copy = OpLabel

;;; Copying the other variable to output.  Because the aliasing, it
;;; should be zero initalized too.

OpCopyMemory %output_buffer %other_wg

OpBranch %after_copy
%after_copy = OpLabel

OpReturn
OpFunctionEnd


OpCapability Shader
OpCapability WorkgroupMemoryExplicitLayoutKHR
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %index %push_constants %output_buffer %wg %offset_wg
OpExecutionMode %main LocalSize 32 4 1

OpDecorate %index BuiltIn LocalInvocationIndex
OpDecorate %buffer_type Block
OpDecorate %offset_buffer_type Block
OpMemberDecorate %buffer_type 0 Offset 0
OpMemberDecorate %offset_buffer_type 0 Offset 64
OpDecorate %array ArrayStride 4
OpDecorate %output_buffer DescriptorSet 0
OpDecorate %output_buffer Binding 1
OpDecorate %wg Aliased
OpDecorate %offset_wg Aliased
OpMemberDecorate %push_constants_type 0 Offset 0
OpDecorate %push_constants_type Block

%uint = OpTypeInt 32 0
%const_uint_0 = OpConstant %uint 0
%const_uint_32 = OpConstant %uint 32
%uint_input_ptr = OpTypePointer Input %uint
%uint_pc_ptr = OpTypePointer PushConstant %uint

%bool = OpTypeBool
%void = OpTypeVoid
%main_type = OpTypeFunction %void
%array = OpTypeArray %uint %const_uint_32
%buffer_type = OpTypeStruct %array
%offset_buffer_type = OpTypeStruct %array
%output_buffer_ptr = OpTypePointer StorageBuffer %buffer_type
%wg_ptr = OpTypePointer Workgroup %buffer_type
%offset_wg_ptr = OpTypePointer Workgroup %offset_buffer_type
%push_constants_type = OpTypeStruct %uint
%push_constants_type_ptr = OpTypePointer PushConstant %push_constants_type
%null_offset_buffer = OpConstantNull %offset_buffer_type

;;; One variable has a "null initializer" and the other not.

%wg = OpVariable %wg_ptr Workgroup
%offset_wg = OpVariable %offset_wg_ptr Workgroup %null_offset_buffer
%output_buffer = OpVariable %output_buffer_ptr StorageBuffer

%index = OpVariable %uint_input_ptr Input
%push_constants = OpVariable %push_constants_type_ptr PushConstant

%main = OpFunction %void None %main_type
%entry = OpLabel

;;; Look up in the push constant to select which invocation will do
;;; the work.

%index_val = OpLoad %uint %index
%worker_ptr = OpAccessChain %uint_pc_ptr %push_constants %const_uint_0
%worker = OpLoad %uint %worker_ptr
%is_worker = OpIEqual %bool %index_val %worker

OpSelectionMerge %after_copy None
OpBranchConditional %is_worker %copy %after_copy
%copy = OpLabel

;;; Copying variable to output.  Because the aliasing at least half of
;;; it should be zero initialized.

OpCopyMemory %output_buffer %wg

OpBranch %after_copy
%after_copy = OpLabel

OpReturn
OpFunctionEnd

