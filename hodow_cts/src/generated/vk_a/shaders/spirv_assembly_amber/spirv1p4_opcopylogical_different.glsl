; Tests copying column major to row major matrix.
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct1 Block
OpMemberDecorate %struct1 0 Offset 0
OpMemberDecorate %struct1 0 ColMajor
OpMemberDecorate %struct1 0 MatrixStride 16
OpDecorate %struct2 Block
OpMemberDecorate %struct2 0 Offset 0
OpMemberDecorate %struct2 0 RowMajor
OpMemberDecorate %struct2 0 MatrixStride 16
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
%void = OpTypeVoid
%float = OpTypeFloat 32
%float4 = OpTypeVector %float 4
%matrix = OpTypeMatrix %float4 4
%struct1 = OpTypeStruct %matrix
%ptr_struct1 = OpTypePointer StorageBuffer %struct1
%struct2 = OpTypeStruct %matrix
%ptr_struct2 = OpTypePointer StorageBuffer %struct2
%in_var = OpVariable %ptr_struct1 StorageBuffer
%out_var = OpVariable %ptr_struct2 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_struct = OpLoad %struct1 %in_var
%copy = OpCopyLogical %struct2 %in_struct
OpStore %out_var %copy
OpReturn
OpFunctionEnd
; Tests copying structs containing a matrix with different matrix strides.
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct1 Block
OpMemberDecorate %struct1 0 Offset 0
OpMemberDecorate %struct1 0 ColMajor
OpMemberDecorate %struct1 0 MatrixStride 16
OpDecorate %struct2 Block
OpMemberDecorate %struct2 0 Offset 0
OpMemberDecorate %struct2 0 ColMajor
OpMemberDecorate %struct2 0 MatrixStride 32
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 1
%void = OpTypeVoid
%float = OpTypeFloat 32
%float4 = OpTypeVector %float 4
%matrix = OpTypeMatrix %float4 4
%struct1 = OpTypeStruct %matrix
%ptr_struct1 = OpTypePointer StorageBuffer %struct1
%struct2 = OpTypeStruct %matrix
%ptr_struct2 = OpTypePointer StorageBuffer %struct2
%in_var = OpVariable %ptr_struct1 StorageBuffer
%out_var = OpVariable %ptr_struct2 StorageBuffer
%func_ty = OpTypeFunction %void
%main = OpFunction %void None %func_ty
%1 = OpLabel
%in_struct = OpLoad %struct1 %in_var
%copy = OpCopyLogical %struct2 %in_struct
OpStore %out_var %copy
OpReturn
OpFunctionEnd
