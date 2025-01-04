; Tests copying smaller array stride to larger array stride.
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct_stride_4 Block
OpMemberDecorate %struct_stride_4 0 Offset 0
OpDecorate %struct_stride_8 Block
OpMemberDecorate %struct_stride_8 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorate %float_array_32_stride_4 ArrayStride 4
OpDecorate %float_array_32_stride_8 ArrayStride 8
%void = OpTypeVoid
%float = OpTypeFloat 32
%uint = OpTypeInt 32 0
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%float_array_32_stride_4 = OpTypeArray %float %uint_32
%ptr_float_array_32_stride_4 = OpTypePointer StorageBuffer %float_array_32_stride_4
%struct_stride_4 = OpTypeStruct %float_array_32_stride_4
%ptr_struct_stride_4 = OpTypePointer StorageBuffer %struct_stride_4
%float_array_32_stride_8 = OpTypeArray %float %uint_32
%ptr_float_array_32_stride_8 = OpTypePointer StorageBuffer %float_array_32_stride_8
%struct_stride_8 = OpTypeStruct %float_array_32_stride_8
%ptr_struct_stride_8 = OpTypePointer StorageBuffer %struct_stride_8
%in_var = OpVariable %ptr_struct_stride_4 StorageBuffer
%out_var = OpVariable %ptr_struct_stride_8 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_gep = OpAccessChain %ptr_float_array_32_stride_4 %in_var %uint_0
%in_array = OpLoad %float_array_32_stride_4 %in_gep
%copy = OpCopyLogical %float_array_32_stride_8 %in_array
%out_gep = OpAccessChain %ptr_float_array_32_stride_8 %out_var %uint_0
OpStore %out_gep %copy
OpReturn
OpFunctionEnd
; Tests copying larger array stride to smaller array stride.
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct_stride_4 Block
OpMemberDecorate %struct_stride_4 0 Offset 0
OpDecorate %struct_stride_8 Block
OpMemberDecorate %struct_stride_8 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
OpDecorate %float_array_32_stride_4 ArrayStride 4
OpDecorate %float_array_32_stride_8 ArrayStride 8
%void = OpTypeVoid
%float = OpTypeFloat 32
%uint = OpTypeInt 32 0
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%float_array_32_stride_4 = OpTypeArray %float %uint_32
%ptr_float_array_32_stride_4 = OpTypePointer StorageBuffer %float_array_32_stride_4
%struct_stride_4 = OpTypeStruct %float_array_32_stride_4
%ptr_struct_stride_4 = OpTypePointer StorageBuffer %struct_stride_4
%float_array_32_stride_8 = OpTypeArray %float %uint_32
%ptr_float_array_32_stride_8 = OpTypePointer StorageBuffer %float_array_32_stride_8
%struct_stride_8 = OpTypeStruct %float_array_32_stride_8
%ptr_struct_stride_8 = OpTypePointer StorageBuffer %struct_stride_8
%in_var = OpVariable %ptr_struct_stride_8 StorageBuffer
%out_var = OpVariable %ptr_struct_stride_4 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_gep = OpAccessChain %ptr_float_array_32_stride_8 %in_var %uint_0
%in_array = OpLoad %float_array_32_stride_8 %in_gep
%copy = OpCopyLogical %float_array_32_stride_4 %in_array
%out_gep = OpAccessChain %ptr_float_array_32_stride_4 %out_var %uint_0
OpStore %out_gep %copy
OpReturn
OpFunctionEnd
