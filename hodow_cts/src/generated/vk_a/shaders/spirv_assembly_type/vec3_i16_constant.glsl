OpCapability Shader
OpCapability Int16
OpCapability UniformAndStorageBuffer16BitAccess
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %BP_main "main"
OpExecutionMode %BP_main LocalSize 1 1 1
OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 1
OpDecorate %a10testtype ArrayStride 8
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a10scalartype ArrayStride 8
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
%c_u32_10 = OpConstant %u32 10
%c_i32_10 = OpConstant %i32 10

%scalartype = OpTypeInt 16 1
%testtype = OpTypeVector %scalartype 3
%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v3u32  %c_shift1 %c_shift1 %c_shift1
%v3bool = OpTypeVector %bool 3
%c_zero = OpConstantComposite %v3u32 %c_u32_0 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v3u32 %c_u32_1 %c_u32_1 %c_u32_1
%a10scalartype = OpTypeArray %u32 %c_u32_10
%up_scalartype = OpTypePointer Uniform %u32
%scalarbuf = OpTypeStruct %a10scalartype
%scalarbufptr = OpTypePointer Uniform %scalarbuf
%a10testtype = OpTypeArray %testtype %c_u32_10
%up_testtype = OpTypePointer Uniform %testtype
%buf = OpTypeStruct %a10testtype
%bufptr = OpTypePointer Uniform %buf
%output = OpVariable %bufptr Uniform

%fp_testtype = OpTypePointer Function %testtype

%c_constituent_0 = OpConstant %scalartype 0
%c_constituent_1 = OpConstant %scalartype -32768
%c_constituent_2 = OpConstant %scalartype 32767
%c_constituent_3 = OpConstant %scalartype -3221
%c_constituent_4 = OpConstant %scalartype 3210
%c_constituent_5 = OpConstant %scalartype 19597
%c_constituent_6 = OpConstant %scalartype -245
%c_constituent_7 = OpConstant %scalartype -29230
%c_constituent_8 = OpConstant %scalartype -9731
%c_constituent_9 = OpConstant %scalartype -19441
%c_testtype_0 = OpConstantComposite %testtype %c_constituent_0 %c_constituent_0 %c_constituent_0
%c_testtype_1 = OpConstantComposite %testtype %c_constituent_1 %c_constituent_0 %c_constituent_0
%c_testtype_2 = OpConstantComposite %testtype %c_constituent_2 %c_constituent_1 %c_constituent_0
%c_testtype_3 = OpConstantComposite %testtype %c_constituent_3 %c_constituent_1 %c_constituent_1
%c_testtype_4 = OpConstantComposite %testtype %c_constituent_4 %c_constituent_2 %c_constituent_1
%c_testtype_5 = OpConstantComposite %testtype %c_constituent_5 %c_constituent_2 %c_constituent_1
%c_testtype_6 = OpConstantComposite %testtype %c_constituent_6 %c_constituent_3 %c_constituent_2
%c_testtype_7 = OpConstantComposite %testtype %c_constituent_7 %c_constituent_3 %c_constituent_2
%c_testtype_8 = OpConstantComposite %testtype %c_constituent_8 %c_constituent_4 %c_constituent_2
%c_testtype_9 = OpConstantComposite %testtype %c_constituent_9 %c_constituent_4 %c_constituent_3
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
%lt = OpSLessThan %bool %counter_val %c_i32_10
OpLoopMerge %exit %inc None
OpBranchConditional %lt %write %exit
%write = OpLabel
%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val
OpBranch %switchStart
%switchStart = OpLabel
OpSelectionMerge %switchEnd None
OpSwitch %counter_val %caseDefault 0 %case0 1 %case1 2 %case2 3 %case3 4 %case4 5 %case5 6 %case6 7 %case7 8 %case8 9 %case9
%case0 = OpLabel
OpStore %op_constant %c_testtype_0
OpBranch %switchEnd
%case1 = OpLabel
OpStore %op_constant %c_testtype_1
OpBranch %switchEnd
%case2 = OpLabel
OpStore %op_constant %c_testtype_2
OpBranch %switchEnd
%case3 = OpLabel
OpStore %op_constant %c_testtype_3
OpBranch %switchEnd
%case4 = OpLabel
OpStore %op_constant %c_testtype_4
OpBranch %switchEnd
%case5 = OpLabel
OpStore %op_constant %c_testtype_5
OpBranch %switchEnd
%case6 = OpLabel
OpStore %op_constant %c_testtype_6
OpBranch %switchEnd
%case7 = OpLabel
OpStore %op_constant %c_testtype_7
OpBranch %switchEnd
%case8 = OpLabel
OpStore %op_constant %c_testtype_8
OpBranch %switchEnd
%case9 = OpLabel
OpStore %op_constant %c_testtype_9
OpBranch %switchEnd
%caseDefault = OpLabel
OpBranch %switchEnd
%switchEnd = OpLabel
%op_result = OpLoad %testtype %op_constant
OpStore %output_loc %op_result
OpBranch %inc
%inc = OpLabel
%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1
OpStore %counter %counter_val_next
OpBranch %loop
%exit = OpLabel
OpReturnValue %param
OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability UniformAndStorageBuffer16BitAccess
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %BP_main "main"
OpExecutionMode %BP_main LocalSize 1 1 1
OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 1
OpDecorate %a10testtype ArrayStride 8
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a10scalartype ArrayStride 8
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
%c_u32_10 = OpConstant %u32 10
%c_i32_10 = OpConstant %i32 10

%scalartype = OpTypeInt 16 1
%testtype = OpTypeVector %scalartype 3
%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v3u32  %c_shift1 %c_shift1 %c_shift1
%v3bool = OpTypeVector %bool 3
%c_zero = OpConstantComposite %v3u32 %c_u32_0 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v3u32 %c_u32_1 %c_u32_1 %c_u32_1
%a10scalartype = OpTypeArray %u32 %c_u32_10
%up_scalartype = OpTypePointer Uniform %u32
%scalarbuf = OpTypeStruct %a10scalartype
%scalarbufptr = OpTypePointer Uniform %scalarbuf
%a10testtype = OpTypeArray %testtype %c_u32_10
%up_testtype = OpTypePointer Uniform %testtype
%buf = OpTypeStruct %a10testtype
%bufptr = OpTypePointer Uniform %buf
%output = OpVariable %bufptr Uniform

%fp_testtype = OpTypePointer Function %testtype

%c_constituent_0 = OpConstant %scalartype 0
%c_constituent_1 = OpConstant %scalartype -32768
%c_constituent_2 = OpConstant %scalartype 32767
%c_constituent_3 = OpConstant %scalartype -3221
%c_constituent_4 = OpConstant %scalartype 3210
%c_constituent_5 = OpConstant %scalartype 19597
%c_constituent_6 = OpConstant %scalartype -12085
%c_constituent_7 = OpConstant %scalartype 8432
%c_constituent_8 = OpConstant %scalartype 6477
%c_constituent_9 = OpConstant %scalartype 12536
%c_testtype_0 = OpConstantComposite %testtype %c_constituent_0 %c_constituent_0 %c_constituent_0
%c_testtype_1 = OpConstantComposite %testtype %c_constituent_1 %c_constituent_0 %c_constituent_0
%c_testtype_2 = OpConstantComposite %testtype %c_constituent_2 %c_constituent_1 %c_constituent_0
%c_testtype_3 = OpConstantComposite %testtype %c_constituent_3 %c_constituent_1 %c_constituent_1
%c_testtype_4 = OpConstantComposite %testtype %c_constituent_4 %c_constituent_2 %c_constituent_1
%c_testtype_5 = OpConstantComposite %testtype %c_constituent_5 %c_constituent_2 %c_constituent_1
%c_testtype_6 = OpConstantComposite %testtype %c_constituent_6 %c_constituent_3 %c_constituent_2
%c_testtype_7 = OpConstantComposite %testtype %c_constituent_7 %c_constituent_3 %c_constituent_2
%c_testtype_8 = OpConstantComposite %testtype %c_constituent_8 %c_constituent_4 %c_constituent_2
%c_testtype_9 = OpConstantComposite %testtype %c_constituent_9 %c_constituent_4 %c_constituent_3
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
%lt = OpSLessThan %bool %counter_val %c_i32_10
OpLoopMerge %exit %inc None
OpBranchConditional %lt %write %exit
%write = OpLabel
%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val
OpBranch %switchStart
%switchStart = OpLabel
OpSelectionMerge %switchEnd None
OpSwitch %counter_val %caseDefault 0 %case0 1 %case1 2 %case2 3 %case3 4 %case4 5 %case5 6 %case6 7 %case7 8 %case8 9 %case9
%case0 = OpLabel
OpStore %op_constant %c_testtype_0
OpBranch %switchEnd
%case1 = OpLabel
OpStore %op_constant %c_testtype_1
OpBranch %switchEnd
%case2 = OpLabel
OpStore %op_constant %c_testtype_2
OpBranch %switchEnd
%case3 = OpLabel
OpStore %op_constant %c_testtype_3
OpBranch %switchEnd
%case4 = OpLabel
OpStore %op_constant %c_testtype_4
OpBranch %switchEnd
%case5 = OpLabel
OpStore %op_constant %c_testtype_5
OpBranch %switchEnd
%case6 = OpLabel
OpStore %op_constant %c_testtype_6
OpBranch %switchEnd
%case7 = OpLabel
OpStore %op_constant %c_testtype_7
OpBranch %switchEnd
%case8 = OpLabel
OpStore %op_constant %c_testtype_8
OpBranch %switchEnd
%case9 = OpLabel
OpStore %op_constant %c_testtype_9
OpBranch %switchEnd
%caseDefault = OpLabel
OpBranch %switchEnd
%switchEnd = OpLabel
%op_result_pre = OpLoad %testtype %op_constant
%op_result_a = OpUConvert %v3u32 %op_result_pre
%op_result_b = OpShiftRightLogical %v3u32 %op_result_a %c_shift
%op_result   = OpSConvert %testtype %op_result_b
OpStore %output_loc %op_result
OpBranch %inc
%inc = OpLabel
%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1
OpStore %counter %counter_val_next
OpBranch %loop
%exit = OpLabel
OpReturnValue %param
OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability UniformAndStorageBuffer16BitAccess
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %BP_main "main"
OpExecutionMode %BP_main LocalSize 1 1 1
OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 1
OpDecorate %a10testtype ArrayStride 8
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a10scalartype ArrayStride 8
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
%c_u32_10 = OpConstant %u32 10
%c_i32_10 = OpConstant %i32 10

%scalartype = OpTypeInt 16 1
%testtype = OpTypeVector %scalartype 3
%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v3u32  %c_shift1 %c_shift1 %c_shift1
%v3bool = OpTypeVector %bool 3
%c_zero = OpConstantComposite %v3u32 %c_u32_0 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v3u32 %c_u32_1 %c_u32_1 %c_u32_1
%a10scalartype = OpTypeArray %u32 %c_u32_10
%up_scalartype = OpTypePointer Uniform %u32
%scalarbuf = OpTypeStruct %a10scalartype
%scalarbufptr = OpTypePointer Uniform %scalarbuf
%a10testtype = OpTypeArray %testtype %c_u32_10
%up_testtype = OpTypePointer Uniform %testtype
%buf = OpTypeStruct %a10testtype
%bufptr = OpTypePointer Uniform %buf
%output = OpVariable %bufptr Uniform

%fp_testtype = OpTypePointer Function %testtype

%c_constituent_0 = OpConstantNull %scalartype
%c_constituent_1 = OpConstant %scalartype -32768
%c_constituent_2 = OpConstant %scalartype 32767
%c_constituent_3 = OpConstant %scalartype -3221
%c_constituent_4 = OpConstant %scalartype 3210
%c_constituent_5 = OpConstant %scalartype 19597
%c_constituent_6 = OpConstant %scalartype -31730
%c_constituent_7 = OpConstant %scalartype -22313
%c_constituent_8 = OpConstant %scalartype -22215
%c_constituent_9 = OpConstant %scalartype 28059
%c_testtype_0 = OpConstantNull %testtype
%c_testtype_1 = OpConstantComposite %testtype %c_constituent_1 %c_constituent_0 %c_constituent_0
%c_testtype_2 = OpConstantComposite %testtype %c_constituent_2 %c_constituent_1 %c_constituent_0
%c_testtype_3 = OpConstantComposite %testtype %c_constituent_3 %c_constituent_1 %c_constituent_1
%c_testtype_4 = OpConstantComposite %testtype %c_constituent_4 %c_constituent_2 %c_constituent_1
%c_testtype_5 = OpConstantComposite %testtype %c_constituent_5 %c_constituent_2 %c_constituent_1
%c_testtype_6 = OpConstantComposite %testtype %c_constituent_6 %c_constituent_3 %c_constituent_2
%c_testtype_7 = OpConstantComposite %testtype %c_constituent_7 %c_constituent_3 %c_constituent_2
%c_testtype_8 = OpConstantComposite %testtype %c_constituent_8 %c_constituent_4 %c_constituent_2
%c_testtype_9 = OpConstantComposite %testtype %c_constituent_9 %c_constituent_4 %c_constituent_3
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
%lt = OpSLessThan %bool %counter_val %c_i32_10
OpLoopMerge %exit %inc None
OpBranchConditional %lt %write %exit
%write = OpLabel
%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val
OpBranch %switchStart
%switchStart = OpLabel
OpSelectionMerge %switchEnd None
OpSwitch %counter_val %caseDefault 0 %case0 1 %case1 2 %case2 3 %case3 4 %case4 5 %case5 6 %case6 7 %case7 8 %case8 9 %case9
%case0 = OpLabel
OpStore %op_constant %c_testtype_0
OpBranch %switchEnd
%case1 = OpLabel
OpStore %op_constant %c_testtype_1
OpBranch %switchEnd
%case2 = OpLabel
OpStore %op_constant %c_testtype_2
OpBranch %switchEnd
%case3 = OpLabel
OpStore %op_constant %c_testtype_3
OpBranch %switchEnd
%case4 = OpLabel
OpStore %op_constant %c_testtype_4
OpBranch %switchEnd
%case5 = OpLabel
OpStore %op_constant %c_testtype_5
OpBranch %switchEnd
%case6 = OpLabel
OpStore %op_constant %c_testtype_6
OpBranch %switchEnd
%case7 = OpLabel
OpStore %op_constant %c_testtype_7
OpBranch %switchEnd
%case8 = OpLabel
OpStore %op_constant %c_testtype_8
OpBranch %switchEnd
%case9 = OpLabel
OpStore %op_constant %c_testtype_9
OpBranch %switchEnd
%caseDefault = OpLabel
OpBranch %switchEnd
%switchEnd = OpLabel
%op_result = OpLoad %testtype %op_constant
OpStore %output_loc %op_result
OpBranch %inc
%inc = OpLabel
%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1
OpStore %counter %counter_val_next
OpBranch %loop
%exit = OpLabel
OpReturnValue %param
OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability UniformAndStorageBuffer16BitAccess
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %BP_main "main"
OpExecutionMode %BP_main LocalSize 1 1 1
OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 1
OpDecorate %a10testtype ArrayStride 8
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a10scalartype ArrayStride 8
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
%c_u32_10 = OpConstant %u32 10
%c_i32_10 = OpConstant %i32 10

%scalartype = OpTypeInt 16 1
%testtype = OpTypeVector %scalartype 3
%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v3u32  %c_shift1 %c_shift1 %c_shift1
%v3bool = OpTypeVector %bool 3
%c_zero = OpConstantComposite %v3u32 %c_u32_0 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v3u32 %c_u32_1 %c_u32_1 %c_u32_1
%a10scalartype = OpTypeArray %u32 %c_u32_10
%up_scalartype = OpTypePointer Uniform %u32
%scalarbuf = OpTypeStruct %a10scalartype
%scalarbufptr = OpTypePointer Uniform %scalarbuf
%a10testtype = OpTypeArray %testtype %c_u32_10
%up_testtype = OpTypePointer Uniform %testtype
%buf = OpTypeStruct %a10testtype
%bufptr = OpTypePointer Uniform %buf
%output = OpVariable %bufptr Uniform

%fp_testtype = OpTypePointer Function %testtype

%c_constituent_0 = OpConstantNull %scalartype
%c_constituent_1 = OpConstant %scalartype -32768
%c_constituent_2 = OpConstant %scalartype 32767
%c_constituent_3 = OpConstant %scalartype -3221
%c_constituent_4 = OpConstant %scalartype 3210
%c_constituent_5 = OpConstant %scalartype 19597
%c_constituent_6 = OpConstant %scalartype -1192
%c_constituent_7 = OpConstant %scalartype 15010
%c_constituent_8 = OpConstant %scalartype 22946
%c_constituent_9 = OpConstant %scalartype 24540
%c_testtype_0 = OpConstantNull %testtype
%c_testtype_1 = OpConstantComposite %testtype %c_constituent_1 %c_constituent_0 %c_constituent_0
%c_testtype_2 = OpConstantComposite %testtype %c_constituent_2 %c_constituent_1 %c_constituent_0
%c_testtype_3 = OpConstantComposite %testtype %c_constituent_3 %c_constituent_1 %c_constituent_1
%c_testtype_4 = OpConstantComposite %testtype %c_constituent_4 %c_constituent_2 %c_constituent_1
%c_testtype_5 = OpConstantComposite %testtype %c_constituent_5 %c_constituent_2 %c_constituent_1
%c_testtype_6 = OpConstantComposite %testtype %c_constituent_6 %c_constituent_3 %c_constituent_2
%c_testtype_7 = OpConstantComposite %testtype %c_constituent_7 %c_constituent_3 %c_constituent_2
%c_testtype_8 = OpConstantComposite %testtype %c_constituent_8 %c_constituent_4 %c_constituent_2
%c_testtype_9 = OpConstantComposite %testtype %c_constituent_9 %c_constituent_4 %c_constituent_3
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
%lt = OpSLessThan %bool %counter_val %c_i32_10
OpLoopMerge %exit %inc None
OpBranchConditional %lt %write %exit
%write = OpLabel
%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val
OpBranch %switchStart
%switchStart = OpLabel
OpSelectionMerge %switchEnd None
OpSwitch %counter_val %caseDefault 0 %case0 1 %case1 2 %case2 3 %case3 4 %case4 5 %case5 6 %case6 7 %case7 8 %case8 9 %case9
%case0 = OpLabel
OpStore %op_constant %c_testtype_0
OpBranch %switchEnd
%case1 = OpLabel
OpStore %op_constant %c_testtype_1
OpBranch %switchEnd
%case2 = OpLabel
OpStore %op_constant %c_testtype_2
OpBranch %switchEnd
%case3 = OpLabel
OpStore %op_constant %c_testtype_3
OpBranch %switchEnd
%case4 = OpLabel
OpStore %op_constant %c_testtype_4
OpBranch %switchEnd
%case5 = OpLabel
OpStore %op_constant %c_testtype_5
OpBranch %switchEnd
%case6 = OpLabel
OpStore %op_constant %c_testtype_6
OpBranch %switchEnd
%case7 = OpLabel
OpStore %op_constant %c_testtype_7
OpBranch %switchEnd
%case8 = OpLabel
OpStore %op_constant %c_testtype_8
OpBranch %switchEnd
%case9 = OpLabel
OpStore %op_constant %c_testtype_9
OpBranch %switchEnd
%caseDefault = OpLabel
OpBranch %switchEnd
%switchEnd = OpLabel
%op_result_pre = OpLoad %testtype %op_constant
%op_result_a = OpUConvert %v3u32 %op_result_pre
%op_result_b = OpShiftRightLogical %v3u32 %op_result_a %c_shift
%op_result   = OpSConvert %testtype %op_result_b
OpStore %output_loc %op_result
OpBranch %inc
%inc = OpLabel
%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1
OpStore %counter %counter_val_next
OpBranch %loop
%exit = OpLabel
OpReturnValue %param
OpFunctionEnd
