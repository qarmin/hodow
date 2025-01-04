OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %struct BufferBlock
OpMemberDecorate %struct 0 Offset 0
OpDecorate %buf_array DescriptorSet 0
OpDecorate %buf_array Binding 0
%void = OpTypeVoid
%func_type = OpTypeFunction %void
%int = OpTypeInt 32 1
%int_0 = OpConstant %int 0
%uint = OpTypeInt 32 0
%uint_4 = OpConstant %uint 4
%struct = OpTypeStruct %int
%struct_array = OpTypeArray %struct %uint_4
%ptr_struct_array = OpTypePointer Uniform %struct_array
%ptr_struct = OpTypePointer Uniform %struct
%ptr_int = OpTypePointer Uniform %int
%buf_array = OpVariable %ptr_struct_array Uniform
%main = OpFunction %void None %func_type
%entry = OpLabel
%var_copy = OpCopyObject %ptr_struct_array %buf_array
%buf_ptr = OpAccessChain %ptr_struct %var_copy %int_0
%int_ptr = OpAccessChain %ptr_int %buf_ptr %int_0
%val = OpLoad %int %int_ptr
OpReturn
OpFunctionEnd
