OpCapability Shader
OpCapability Int8
OpCapability UniformAndStorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %BP_main "main"
OpExecutionMode %BP_main LocalSize 1 1 1
OpDecorate %rta_i32 ArrayStride 4
OpMemberDecorate %BlockType 0 Offset 0
OpDecorate %BlockType BufferBlock
OpDecorate %block DescriptorSet 0
OpDecorate %block Binding 2
OpDecorate %input DescriptorSet 0
OpDecorate %input Binding 0
OpDecorate %input NonWritable
OpDecorate %expectedOutput DescriptorSet 0
OpDecorate %expectedOutput Binding 1
OpDecorate %expectedOutput NonWritable
OpDecorate %a10testtype ArrayStride 1
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
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
%rta_i32 = OpTypeRuntimeArray %i32
%BlockType = OpTypeStruct %rta_i32
%up_BlockType = OpTypePointer Uniform %BlockType
%block = OpVariable %up_BlockType Uniform
%BP_color = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_0 %c_f32_1
%fp_bool = OpTypePointer Function %bool
%c_u32_10 = OpConstant %u32 10
%c_i32_10 = OpConstant %i32 10
%testtype = OpTypeInt 8 0
%c_casedefault = OpConstant %testtype 10
%c_case0 = OpConstant %testtype 100
%c_case1 = OpConstant %testtype 110
%c_case2 = OpConstant %testtype 120
%fail_color = OpConstantComposite %v4f32 %c_f32_0_5 %c_f32_0_5 %c_f32_0_5 %c_f32_1
%a10testtype = OpTypeArray %testtype %c_u32_10
%up_testtype = OpTypePointer Uniform %testtype
%buf = OpTypeStruct %a10testtype
%bufptr = OpTypePointer Uniform %buf
%input = OpVariable %bufptr Uniform
%expectedOutput = OpVariable %bufptr Uniform
%up_i32 = OpTypePointer Uniform %i32
%BP_main = OpFunction %void None %voidf
%BP_label_main = OpLabel
%BP_in_color = OpVariable %fp_v4f32 Function
%BP_out_color = OpVariable %fp_v4f32 Function
OpStore %BP_in_color %BP_color
%BP_tmp1 = OpLoad %v4f32 %BP_in_color
%BP_tmp2 = OpFunctionCall %v4f32 %test_code %BP_tmp1
OpStore %BP_out_color %BP_tmp2
%BP_tmp3 = OpLoad %v4f32 %BP_in_color
%BP_tmp4 = OpLoad %v4f32 %BP_out_color
%BP_tmp5 = OpFOrdEqual %v4bool %BP_tmp3 %BP_tmp4
%BP_tmp6 = OpAll %bool %BP_tmp5
%BP_tmp7 = OpSelect %i32 %BP_tmp6 %c_i32_1 %c_i32_0
%BP_tmp8 = OpAccessChain %up_i32 %block %c_i32_0 %c_i32_0
OpStore %BP_tmp8 %BP_tmp7
OpReturn
OpFunctionEnd

%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param = OpFunctionParameter %v4f32
%entry = OpLabel
%counter = OpVariable %fp_i32 Function
%return = OpVariable %fp_v4f32 Function
%works = OpVariable %fp_bool Function
OpStore %counter %c_i32_0
OpStore %return %param
OpBranch %loop
%loop = OpLabel
%counter_val = OpLoad %i32 %counter
%lt = OpSLessThan %bool %counter_val %c_i32_10
OpLoopMerge %loop_exit %inc None
OpBranchConditional %lt %load %loop_exit
%load = OpLabel
%input_loc = OpAccessChain %up_testtype %input %c_i32_0 %counter_val
%input_val = OpLoad %testtype %input_loc
%expectedOutput_loc = OpAccessChain %up_testtype %expectedOutput %c_i32_0 %counter_val
%expectedOutput_val = OpLoad %testtype %expectedOutput_loc
OpSelectionMerge %switch_exit None
OpSwitch %input_val %default 0 %case0 73 %case1 193 %case2
%default = OpLabel
%is_default = OpIEqual %bool %expectedOutput_val %c_casedefault
OpBranch %switch_exit
%case0 = OpLabel
%is_case0 = OpIEqual %bool %expectedOutput_val %c_case0
OpBranch %switch_exit
%case1 = OpLabel
%is_case1 = OpIEqual %bool %expectedOutput_val %c_case1
OpBranch %switch_exit
%case2 = OpLabel
%is_case2 = OpIEqual %bool %expectedOutput_val %c_case2
OpBranch %switch_exit
%switch_exit = OpLabel
%case_result = OpPhi %bool %is_default %default %is_case0 %case0 %is_case1 %case1 %is_case2 %case2
OpSelectionMerge %result_end None
OpBranchConditional %case_result %result_correct %result_incorrect
%result_correct = OpLabel
OpBranch %result_end
%result_incorrect = OpLabel
%counter_val_end = OpIAdd %i32 %counter_val %c_i32_10
OpStore %counter %counter_val_end
OpStore %return %fail_color
OpBranch %result_end
%result_end = OpLabel
OpBranch %inc
%inc = OpLabel
%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1
OpStore %counter %counter_val_next
OpBranch %loop
%loop_exit = OpLabel
%return_val = OpLoad %v4f32 %return
OpReturnValue %return_val
OpFunctionEnd
