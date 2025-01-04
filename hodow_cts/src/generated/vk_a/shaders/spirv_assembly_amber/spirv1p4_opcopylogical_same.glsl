; Tests copy of same structural array given two IDs.
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct1 Block
OpMemberDecorate %struct1 0 Offset 0
OpDecorate %struct2 Block
OpMemberDecorate %struct2 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorate %float_array1 ArrayStride 4
OpDecorate %float_array2 ArrayStride 4
%void = OpTypeVoid
%float = OpTypeFloat 32
%uint = OpTypeInt 32 0
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%float_array1 = OpTypeArray %float %uint_32
%ptr_float_array1 = OpTypePointer StorageBuffer %float_array1
%struct1 = OpTypeStruct %float_array1
%ptr_struct1 = OpTypePointer StorageBuffer %struct1
%float_array2 = OpTypeArray %float %uint_32
%ptr_float_array2 = OpTypePointer StorageBuffer %float_array2
%struct2 = OpTypeStruct %float_array2
%ptr_struct2 = OpTypePointer StorageBuffer %struct2
%in_var = OpVariable %ptr_struct1 StorageBuffer
%out_var = OpVariable %ptr_struct2 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_gep = OpAccessChain %ptr_float_array1 %in_var %uint_0
%in_array = OpLoad %float_array1 %in_gep
%copy = OpCopyLogical %float_array2 %in_array
%out_gep = OpAccessChain %ptr_float_array2 %out_var %uint_0
OpStore %out_gep %copy
OpReturn
OpFunctionEnd
; Tests copying same structural struct with different IDs.
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct1 Block
OpMemberDecorate %struct1 0 Offset 0
OpMemberDecorate %struct1 1 Offset 4
OpMemberDecorate %struct1 2 Offset 8
OpMemberDecorate %struct1 3 Offset 12
OpDecorate %struct2 Block
OpMemberDecorate %struct2 0 Offset 0
OpMemberDecorate %struct2 1 Offset 4
OpMemberDecorate %struct2 2 Offset 8
OpMemberDecorate %struct2 3 Offset 12
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
%void = OpTypeVoid
%int = OpTypeInt 32 0
%struct1 = OpTypeStruct %int %int %int %int
%ptr_struct1 = OpTypePointer Uniform %struct1
%struct2 = OpTypeStruct %int %int %int %int
%ptr_struct2 = OpTypePointer StorageBuffer %struct2
%in_var = OpVariable %ptr_struct1 Uniform
%out_var = OpVariable %ptr_struct2 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_struct = OpLoad %struct1 %in_var
%copy = OpCopyLogical %struct2 %in_struct
OpStore %out_var %copy
OpReturn
OpFunctionEnd
