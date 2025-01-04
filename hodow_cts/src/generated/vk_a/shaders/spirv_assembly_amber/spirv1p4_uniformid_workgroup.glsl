OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gid_var %in_var %out_var
OpExecutionMode %main LocalSize 8 1 1
OpDecorate %gid_var BuiltIn GlobalInvocationId
OpDecorate %int_rta ArrayStride 4
OpDecorate %struct Block
OpMemberDecorate %struct 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorateId %cmp UniformId %workgroup
%void = OpTypeVoid
%bool = OpTypeBool
%int = OpTypeInt 32 0
%int_0 = OpConstant %int 0
%int_10 = OpConstant %int 10
%int_100 = OpConstant %int 100
%int_50 = OpConstant %int 50
%workgroup = OpConstant %int 2
%int3 = OpTypeVector %int 3
%int_rta = OpTypeRuntimeArray %int
%struct = OpTypeStruct %int_rta
%ptr_ssbo_struct = OpTypePointer StorageBuffer %struct
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%in_var = OpVariable %ptr_ssbo_struct StorageBuffer
%out_var = OpVariable %ptr_ssbo_struct StorageBuffer
%ptr_input_int3 = OpTypePointer Input %int3
%gid_var = OpVariable %ptr_input_int3 Input
%void_fn = OpTypeFunction %void
%main = OpFunction %void None %void_fn
%entry = OpLabel
%gid = OpLoad %int3 %gid_var
%gid_x = OpCompositeExtract %int %gid 0
%in_gep = OpAccessChain %ptr_ssbo_int %in_var %int_0 %gid_x
%ld = OpLoad %int %in_gep
%cmp = OpULessThan %bool %ld %int_10
OpSelectionMerge %merge None
OpBranchConditional %cmp %then %else
%then = OpLabel
%then_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %gid_x
OpStore %then_gep %int_100
OpBranch %merge
%else = OpLabel
%else_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %gid_x
OpStore %else_gep %int_50
OpBranch %merge
%merge = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gid_var %in_var %out_var
OpExecutionMode %main LocalSize 8 1 1
OpDecorate %lid_var BuiltIn LocalInvocationId
OpDecorate %gid_var BuiltIn GlobalInvocationId
OpDecorate %int_rta ArrayStride 4
OpDecorate %struct Block
OpMemberDecorate %struct 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorateId %in_ld UniformId %workgroup
%void = OpTypeVoid
%int = OpTypeInt 32 0
%int_0 = OpConstant %int 0
%workgroup = OpConstant %int 2
%int3 = OpTypeVector %int 3
%int_rta = OpTypeRuntimeArray %int
%struct = OpTypeStruct %int_rta
%ptr_ssbo_struct = OpTypePointer StorageBuffer %struct
%in_var = OpVariable %ptr_ssbo_struct StorageBuffer
%out_var = OpVariable %ptr_ssbo_struct StorageBuffer
%ptr_ssbo_int = OpTypePointer StorageBuffer %int
%ptr_input_int3 = OpTypePointer Input %int3
%lid_var = OpVariable %ptr_input_int3 Input
%gid_var = OpVariable %ptr_input_int3 Input
%void_fn = OpTypeFunction %void
%main = OpFunction %void None %void_fn
%entry = OpLabel
%gid = OpLoad %int3 %gid_var
%gid_x = OpCompositeExtract %int %gid 0
%in_gep = OpAccessChain %ptr_ssbo_int %in_var %int_0 %gid_x
%in_ld = OpLoad %int %in_gep
%out_gep = OpAccessChain %ptr_ssbo_int %out_var %int_0 %gid_x
OpStore %out_gep %in_ld
OpReturn
OpFunctionEnd
