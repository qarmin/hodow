; Applying the no signed wrap decoration
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct1 Block
OpMemberDecorate %struct1 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorate %out_int NoSignedWrap
%void = OpTypeVoid
%int = OpTypeInt 32 1
%int_10 = OpConstant %int 10
%struct1 = OpTypeStruct %int
%ptr_struct1 = OpTypePointer StorageBuffer %struct1
%in_var = OpVariable %ptr_struct1 StorageBuffer
%out_var = OpVariable %ptr_struct1 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_struct = OpLoad %struct1 %in_var
%in_int = OpCompositeExtract %int %in_struct 0
%out_int = OpIAdd %int %in_int %int_10
%out_struct = OpCompositeConstruct %struct1 %out_int
OpStore %out_var %out_struct
OpReturn
OpFunctionEnd
; Applying the no signed wrap decoration
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct1 Block
OpMemberDecorate %struct1 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorate %out_int NoUnsignedWrap
%void = OpTypeVoid
%int = OpTypeInt 32 0
%int_10 = OpConstant %int 10
%struct1 = OpTypeStruct %int
%ptr_struct1 = OpTypePointer StorageBuffer %struct1
%in_var = OpVariable %ptr_struct1 StorageBuffer
%out_var = OpVariable %ptr_struct1 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_struct = OpLoad %struct1 %in_var
%in_int = OpCompositeExtract %int %in_struct 0
%out_int = OpIAdd %int %in_int %int_10
%out_struct = OpCompositeConstruct %struct1 %out_int
OpStore %out_var %out_struct
OpReturn
OpFunctionEnd
