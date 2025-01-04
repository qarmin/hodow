OpCapability Shader
OpCapability Int8
OpCapability UniformAndStorageBuffer8BitAccess
OpCapability LongVectorEXT
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_EXT_long_vector"

OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %BP_main "main"
OpExecutionMode %BP_main LocalSize 1 1 1
OpDecorate %input0 DescriptorSet 0
OpDecorate %input0 Binding 0
OpDecorate %input1 DescriptorSet 0
OpDecorate %input1 Binding 1
OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 2
OpDecorate %a450testtype ArrayStride 8
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a450scalartype ArrayStride 8
OpDecorate %scalarbuf BufferBlock
OpMemberDecorate %scalarbuf 0 Offset 0
%void = OpTypeVoid
%bool = OpTypeBool
%i32 = OpTypeInt 32 1
%u32 = OpTypeInt 32 0
%f32 = OpTypeFloat 32
%v2i32 = OpTypeVector %i32 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%v3i32 = OpTypeVector %i32 3
%v3u32 = OpTypeVector %u32 3
%v3f32 = OpTypeVector %f32 3
%v4i32 = OpTypeVector %i32 4
%v4u32 = OpTypeVector %u32 4
%v4f32 = OpTypeVector %f32 4
%v4bool = OpTypeVector %bool 4
%v4f32_v4f32_function = OpTypeFunction %v4f32 %v4f32
%bool_function = OpTypeFunction %bool
%voidf = OpTypeFunction %void
%ip_f32 = OpTypePointer Input %f32
%ip_i32 = OpTypePointer Input %i32
%ip_u32 = OpTypePointer Input %u32
%ip_v2f32 = OpTypePointer Input %v2f32
%ip_v2i32 = OpTypePointer Input %v2i32
%ip_v2u32 = OpTypePointer Input %v2u32
%ip_v3f32 = OpTypePointer Input %v3f32
%ip_v4f32 = OpTypePointer Input %v4f32
%ip_v4i32 = OpTypePointer Input %v4i32
%ip_v4u32 = OpTypePointer Input %v4u32
%op_f32 = OpTypePointer Output %f32
%op_i32 = OpTypePointer Output %i32
%op_u32 = OpTypePointer Output %u32
%op_v2f32 = OpTypePointer Output %v2f32
%op_v2i32 = OpTypePointer Output %v2i32
%op_v2u32 = OpTypePointer Output %v2u32
%op_v4f32 = OpTypePointer Output %v4f32
%op_v4i32 = OpTypePointer Output %v4i32
%op_v4u32 = OpTypePointer Output %v4u32
%fp_f32   = OpTypePointer Function %f32
%fp_i32   = OpTypePointer Function %i32
%fp_v4f32 = OpTypePointer Function %v4f32
%c_f32_1 = OpConstant %f32 1.0
%c_f32_0 = OpConstant %f32 0.0
%c_f32_0_5 = OpConstant %f32 0.5
%c_f32_n1  = OpConstant %f32 -1.
%c_f32_7 = OpConstant %f32 7.0
%c_f32_8 = OpConstant %f32 8.0
%c_i32_0 = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_u32_0 = OpConstant %u32 0
%c_u32_1 = OpConstant %u32 1
%c_u32_2 = OpConstant %u32 2
%c_u32_3 = OpConstant %u32 3
%c_u32_32 = OpConstant %u32 32
%c_u32_4 = OpConstant %u32 4
%c_u32_31_bits = OpConstant %u32 0x7FFFFFFF
%c_v4f32_1_1_1_1 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_1 %c_f32_1 %c_f32_1
%c_v4f32_1_0_0_1 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_1
%c_v4f32_0_5_0_5_0_5_0_5 = OpConstantComposite %v4f32 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5
%a1f32 = OpTypeArray %f32 %c_u32_1
%a2f32 = OpTypeArray %f32 %c_u32_2
%a3v4f32 = OpTypeArray %v4f32 %c_u32_3
%a4f32 = OpTypeArray %f32 %c_u32_4
%a32v4f32 = OpTypeArray %v4f32 %c_u32_32
%ip_a3v4f32 = OpTypePointer Input %a3v4f32
%ip_a32v4f32 = OpTypePointer Input %a32v4f32
%op_a2f32 = OpTypePointer Output %a2f32
%op_a3v4f32 = OpTypePointer Output %a3v4f32
%op_a4f32 = OpTypePointer Output %a4f32
%BP_color = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_0 %c_f32_1
%c_u32_450 = OpConstant %u32 450
%c_i32_450 = OpConstant %i32 450
%v8i32 = OpTypeVector %i32 8
%v8u32 = OpTypeVector %u32 8
%v8f32 = OpTypeVector %f32 8

%scalartype = OpTypeInt 8 1
%testtype = OpTypeVector %scalartype 8
%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v8u32  %c_shift1 %c_shift1 %c_shift1 %c_shift1 %c_shift1 %c_shift1 %c_shift1 %c_shift1
%v8bool = OpTypeVector %bool 8
%c_zero = OpConstantComposite %v8u32 %c_u32_0 %c_u32_0 %c_u32_0 %c_u32_0 %c_u32_0 %c_u32_0 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v8u32 %c_u32_1 %c_u32_1 %c_u32_1 %c_u32_1 %c_u32_1 %c_u32_1 %c_u32_1 %c_u32_1
%a450scalartype = OpTypeArray %u32 %c_u32_450
%up_scalartype = OpTypePointer Uniform %u32
%scalarbuf = OpTypeStruct %a450scalartype
%scalarbufptr = OpTypePointer Uniform %scalarbuf
%a450testtype = OpTypeArray %testtype %c_u32_450
%up_testtype = OpTypePointer Uniform %testtype
%buf = OpTypeStruct %a450testtype
%bufptr = OpTypePointer Uniform %buf
%output = OpVariable %bufptr Uniform

%fp_testtype = OpTypePointer Function %testtype

%input0 = OpVariable %bufptr Uniform
%input1 = OpVariable %bufptr Uniform
%BP_main = OpFunction %void None %voidf
%BP_label_main = OpLabel
%BP_in_color = OpVariable %fp_v4f32 Function
%BP_out_color = OpVariable %fp_v4f32 Function
OpStore %BP_in_color %BP_color
%BP_tmp1 = OpLoad %v4f32 %BP_in_color
%BP_tmp2 = OpFunctionCall %v4f32 %test_code %BP_tmp1
OpStore %BP_out_color %BP_tmp2
OpReturn
OpFunctionEnd

%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param = OpFunctionParameter %v4f32
%entry = OpLabel
%op_constant = OpVariable %fp_testtype Function
%counter = OpVariable %fp_i32 Function
OpStore %counter %c_i32_0
OpBranch %loop
%loop = OpLabel
%counter_val = OpLoad %i32 %counter
%lt = OpSLessThan %bool %counter_val %c_i32_450
OpLoopMerge %exit %inc None
OpBranchConditional %lt %write %exit
%write = OpLabel
%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val
%input0_loc = OpAccessChain %up_testtype %input0 %c_i32_0 %counter_val
%input0_val = OpLoad %testtype %input0_loc
%input1_loc = OpAccessChain %up_testtype %input1 %c_i32_0 %counter_val
%input1_val = OpLoad %testtype %input1_loc
%op_result_pre = OpSLessThanEqual %v8bool %input0_val %input1_val
%op_result_u32 = OpSelect %v8u32 %op_result_pre %c_one %c_zero
%op_result     = OpSConvert %testtype %op_result_u32
OpStore %output_loc %op_result
OpBranch %inc
%inc = OpLabel
%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1
OpStore %counter %counter_val_next
OpBranch %loop
%exit = OpLabel
OpReturnValue %param
OpFunctionEnd
