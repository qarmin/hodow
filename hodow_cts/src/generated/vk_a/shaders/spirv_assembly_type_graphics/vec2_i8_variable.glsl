OpCapability Shader
OpCapability Int8
OpCapability UniformAndStorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %BP_main "main" %BP_stream %BP_position %BP_vtx_color %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex  



OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_vtx_color Location 1
OpDecorate %BP_color Location 1
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex

OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 1
OpDecorate %a10testtype ArrayStride 2
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a10scalartype ArrayStride 2
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
%BP_gl_PerVertex = OpTypeStruct %v4f32 %f32 %a1f32 %a1f32
%BP_op_gl_PerVertex = OpTypePointer Output %BP_gl_PerVertex
%BP_stream = OpVariable %BP_op_gl_PerVertex Output
%BP_position = OpVariable %ip_v4f32 Input
%BP_vtx_color = OpVariable %op_v4f32 Output
%BP_color = OpVariable %ip_v4f32 Input
%BP_gl_VertexIndex = OpVariable %ip_i32 Input
%BP_gl_InstanceIndex = OpVariable %ip_i32 Input
%c_u32_10 = OpConstant %u32 10
%c_i32_10 = OpConstant %i32 10

%scalartype = OpTypeInt 8 1
%testtype = OpTypeVector %scalartype 2
%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v2u32  %c_shift1 %c_shift1
%v2bool = OpTypeVector %bool 2
%c_zero = OpConstantComposite %v2u32 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v2u32 %c_u32_1 %c_u32_1
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
%c_constituent_1 = OpConstant %scalartype -128
%c_constituent_2 = OpConstant %scalartype 127
%c_constituent_3 = OpConstant %scalartype -42
%c_constituent_4 = OpConstant %scalartype 73
%c_constituent_5 = OpConstant %scalartype 121
%c_constituent_6 = OpConstant %scalartype -86
%c_constituent_7 = OpConstant %scalartype -50
%c_constituent_8 = OpConstant %scalartype -1
%c_constituent_9 = OpConstant %scalartype 8
%c_testtype_0 = OpConstantNull %testtype
%c_testtype_1 = OpConstantComposite %testtype %c_constituent_1 %c_constituent_0
%c_testtype_2 = OpConstantComposite %testtype %c_constituent_2 %c_constituent_1
%c_testtype_3 = OpConstantComposite %testtype %c_constituent_3 %c_constituent_1
%c_testtype_4 = OpConstantComposite %testtype %c_constituent_4 %c_constituent_2
%c_testtype_5 = OpConstantComposite %testtype %c_constituent_5 %c_constituent_2
%c_testtype_6 = OpConstantComposite %testtype %c_constituent_6 %c_constituent_3
%c_testtype_7 = OpConstantComposite %testtype %c_constituent_7 %c_constituent_3
%c_testtype_8 = OpConstantComposite %testtype %c_constituent_8 %c_constituent_4
%c_testtype_9 = OpConstantComposite %testtype %c_constituent_9 %c_constituent_4


%BP_main = OpFunction %void None %voidf
%BP_label = OpLabel


%BP_pos = OpLoad %v4f32 %BP_position
%BP_gl_pos = OpAccessChain %op_v4f32 %BP_stream %c_i32_0
OpStore %BP_gl_pos %BP_pos
%BP_col = OpLoad %v4f32 %BP_color
%BP_col_transformed = OpFunctionCall %v4f32 %test_code %BP_col
OpStore %BP_vtx_color %BP_col_transformed
OpReturn
OpFunctionEnd

%isUniqueIdZero = OpFunction %bool None %bool_function
%getId_label = OpLabel
%vert_id = OpLoad %i32 %BP_gl_VertexIndex
%is_id_0 = OpIEqual %bool %vert_id %c_i32_0
OpReturnValue %is_id_0
OpFunctionEnd
%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param = OpFunctionParameter %v4f32
%entry = OpLabel
%op_constant = OpVariable %fp_testtype Function
%testvariable_0 = OpVariable %fp_testtype Function %c_testtype_0
%testvariable_1 = OpVariable %fp_testtype Function %c_testtype_1
%testvariable_2 = OpVariable %fp_testtype Function %c_testtype_2
%testvariable_3 = OpVariable %fp_testtype Function %c_testtype_3
%testvariable_4 = OpVariable %fp_testtype Function %c_testtype_4
%testvariable_5 = OpVariable %fp_testtype Function %c_testtype_5
%testvariable_6 = OpVariable %fp_testtype Function %c_testtype_6
%testvariable_7 = OpVariable %fp_testtype Function %c_testtype_7
%testvariable_8 = OpVariable %fp_testtype Function %c_testtype_8
%testvariable_9 = OpVariable %fp_testtype Function %c_testtype_9
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
%temp_0 = OpLoad %testtype %testvariable_0
OpStore %op_constant %temp_0
OpBranch %switchEnd
%case1 = OpLabel
%temp_1 = OpLoad %testtype %testvariable_1
OpStore %op_constant %temp_1
OpBranch %switchEnd
%case2 = OpLabel
%temp_2 = OpLoad %testtype %testvariable_2
OpStore %op_constant %temp_2
OpBranch %switchEnd
%case3 = OpLabel
%temp_3 = OpLoad %testtype %testvariable_3
OpStore %op_constant %temp_3
OpBranch %switchEnd
%case4 = OpLabel
%temp_4 = OpLoad %testtype %testvariable_4
OpStore %op_constant %temp_4
OpBranch %switchEnd
%case5 = OpLabel
%temp_5 = OpLoad %testtype %testvariable_5
OpStore %op_constant %temp_5
OpBranch %switchEnd
%case6 = OpLabel
%temp_6 = OpLoad %testtype %testvariable_6
OpStore %op_constant %temp_6
OpBranch %switchEnd
%case7 = OpLabel
%temp_7 = OpLoad %testtype %testvariable_7
OpStore %op_constant %temp_7
OpBranch %switchEnd
%case8 = OpLabel
%temp_8 = OpLoad %testtype %testvariable_8
OpStore %op_constant %temp_8
OpBranch %switchEnd
%case9 = OpLabel
%temp_9 = OpLoad %testtype %testvariable_9
OpStore %op_constant %temp_9
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


OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord


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
%BP_gl_FragCoord = OpVariable %ip_v4f32 Input
%BP_fragColor = OpVariable %op_v4f32 Output
%BP_vtxColor = OpVariable %ip_v4f32 Input


%BP_main = OpFunction %void None %voidf
%BP_label_main = OpLabel


%BP_tmp1 = OpLoad %v4f32 %BP_vtxColor
%BP_tmp2 = OpFunctionCall %v4f32 %test_code %BP_tmp1
OpStore %BP_fragColor %BP_tmp2
OpReturn
OpFunctionEnd

%isUniqueIdZero = OpFunction %bool None %bool_function
%getId_label = OpLabel
%loc_x_coord = OpAccessChain %ip_f32 %BP_gl_FragCoord %c_i32_0
%loc_y_coord = OpAccessChain %ip_f32 %BP_gl_FragCoord %c_i32_1
%x_coord = OpLoad %f32 %loc_x_coord
%y_coord = OpLoad %f32 %loc_y_coord
%is_x_idx0 = OpFOrdEqual %bool %x_coord %c_f32_0_5
%is_y_idx0 = OpFOrdEqual %bool %y_coord %c_f32_0_5
%is_frag_0 = OpLogicalAnd %bool %is_x_idx0 %is_y_idx0
OpReturnValue %is_frag_0
OpFunctionEnd
%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param1 = OpFunctionParameter %v4f32
%label_testfun = OpLabel
OpReturnValue %param1
OpFunctionEnd

OpCapability Shader


OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %BP_main "main" %BP_stream %BP_position %BP_vtx_color %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex  



OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_vtx_color Location 1
OpDecorate %BP_color Location 1
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex


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
%BP_gl_PerVertex = OpTypeStruct %v4f32 %f32 %a1f32 %a1f32
%BP_op_gl_PerVertex = OpTypePointer Output %BP_gl_PerVertex
%BP_stream = OpVariable %BP_op_gl_PerVertex Output
%BP_position = OpVariable %ip_v4f32 Input
%BP_vtx_color = OpVariable %op_v4f32 Output
%BP_color = OpVariable %ip_v4f32 Input
%BP_gl_VertexIndex = OpVariable %ip_i32 Input
%BP_gl_InstanceIndex = OpVariable %ip_i32 Input


%BP_main = OpFunction %void None %voidf
%BP_label = OpLabel


%BP_pos = OpLoad %v4f32 %BP_position
%BP_gl_pos = OpAccessChain %op_v4f32 %BP_stream %c_i32_0
OpStore %BP_gl_pos %BP_pos
%BP_col = OpLoad %v4f32 %BP_color
%BP_col_transformed = OpFunctionCall %v4f32 %test_code %BP_col
OpStore %BP_vtx_color %BP_col_transformed
OpReturn
OpFunctionEnd

%isUniqueIdZero = OpFunction %bool None %bool_function
%getId_label = OpLabel
%vert_id = OpLoad %i32 %BP_gl_VertexIndex
%is_id_0 = OpIEqual %bool %vert_id %c_i32_0
OpReturnValue %is_id_0
OpFunctionEnd
%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param1 = OpFunctionParameter %v4f32
%label_testfun = OpLabel
OpReturnValue %param1
OpFunctionEnd

OpCapability Shader
OpCapability Int8
OpCapability UniformAndStorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 1
OpDecorate %a10testtype ArrayStride 2
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a10scalartype ArrayStride 2
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
%BP_gl_FragCoord = OpVariable %ip_v4f32 Input
%BP_fragColor = OpVariable %op_v4f32 Output
%BP_vtxColor = OpVariable %ip_v4f32 Input
%c_u32_10 = OpConstant %u32 10
%c_i32_10 = OpConstant %i32 10

%scalartype = OpTypeInt 8 1
%testtype = OpTypeVector %scalartype 2
%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v2u32  %c_shift1 %c_shift1
%v2bool = OpTypeVector %bool 2
%c_zero = OpConstantComposite %v2u32 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v2u32 %c_u32_1 %c_u32_1
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
%c_constituent_1 = OpConstant %scalartype -128
%c_constituent_2 = OpConstant %scalartype 127
%c_constituent_3 = OpConstant %scalartype -42
%c_constituent_4 = OpConstant %scalartype 73
%c_constituent_5 = OpConstant %scalartype 121
%c_constituent_6 = OpConstant %scalartype -86
%c_constituent_7 = OpConstant %scalartype -50
%c_constituent_8 = OpConstant %scalartype -1
%c_constituent_9 = OpConstant %scalartype 8
%c_testtype_0 = OpConstantNull %testtype
%c_testtype_1 = OpConstantComposite %testtype %c_constituent_1 %c_constituent_0
%c_testtype_2 = OpConstantComposite %testtype %c_constituent_2 %c_constituent_1
%c_testtype_3 = OpConstantComposite %testtype %c_constituent_3 %c_constituent_1
%c_testtype_4 = OpConstantComposite %testtype %c_constituent_4 %c_constituent_2
%c_testtype_5 = OpConstantComposite %testtype %c_constituent_5 %c_constituent_2
%c_testtype_6 = OpConstantComposite %testtype %c_constituent_6 %c_constituent_3
%c_testtype_7 = OpConstantComposite %testtype %c_constituent_7 %c_constituent_3
%c_testtype_8 = OpConstantComposite %testtype %c_constituent_8 %c_constituent_4
%c_testtype_9 = OpConstantComposite %testtype %c_constituent_9 %c_constituent_4


%BP_main = OpFunction %void None %voidf
%BP_label_main = OpLabel


%BP_tmp1 = OpLoad %v4f32 %BP_vtxColor
%BP_tmp2 = OpFunctionCall %v4f32 %test_code %BP_tmp1
OpStore %BP_fragColor %BP_tmp2
OpReturn
OpFunctionEnd

%isUniqueIdZero = OpFunction %bool None %bool_function
%getId_label = OpLabel
%loc_x_coord = OpAccessChain %ip_f32 %BP_gl_FragCoord %c_i32_0
%loc_y_coord = OpAccessChain %ip_f32 %BP_gl_FragCoord %c_i32_1
%x_coord = OpLoad %f32 %loc_x_coord
%y_coord = OpLoad %f32 %loc_y_coord
%is_x_idx0 = OpFOrdEqual %bool %x_coord %c_f32_0_5
%is_y_idx0 = OpFOrdEqual %bool %y_coord %c_f32_0_5
%is_frag_0 = OpLogicalAnd %bool %is_x_idx0 %is_y_idx0
OpReturnValue %is_frag_0
OpFunctionEnd
%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param = OpFunctionParameter %v4f32
%entry = OpLabel
%op_constant = OpVariable %fp_testtype Function
%testvariable_0 = OpVariable %fp_testtype Function %c_testtype_0
%testvariable_1 = OpVariable %fp_testtype Function %c_testtype_1
%testvariable_2 = OpVariable %fp_testtype Function %c_testtype_2
%testvariable_3 = OpVariable %fp_testtype Function %c_testtype_3
%testvariable_4 = OpVariable %fp_testtype Function %c_testtype_4
%testvariable_5 = OpVariable %fp_testtype Function %c_testtype_5
%testvariable_6 = OpVariable %fp_testtype Function %c_testtype_6
%testvariable_7 = OpVariable %fp_testtype Function %c_testtype_7
%testvariable_8 = OpVariable %fp_testtype Function %c_testtype_8
%testvariable_9 = OpVariable %fp_testtype Function %c_testtype_9
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
%temp_0 = OpLoad %testtype %testvariable_0
OpStore %op_constant %temp_0
OpBranch %switchEnd
%case1 = OpLabel
%temp_1 = OpLoad %testtype %testvariable_1
OpStore %op_constant %temp_1
OpBranch %switchEnd
%case2 = OpLabel
%temp_2 = OpLoad %testtype %testvariable_2
OpStore %op_constant %temp_2
OpBranch %switchEnd
%case3 = OpLabel
%temp_3 = OpLoad %testtype %testvariable_3
OpStore %op_constant %temp_3
OpBranch %switchEnd
%case4 = OpLabel
%temp_4 = OpLoad %testtype %testvariable_4
OpStore %op_constant %temp_4
OpBranch %switchEnd
%case5 = OpLabel
%temp_5 = OpLoad %testtype %testvariable_5
OpStore %op_constant %temp_5
OpBranch %switchEnd
%case6 = OpLabel
%temp_6 = OpLoad %testtype %testvariable_6
OpStore %op_constant %temp_6
OpBranch %switchEnd
%case7 = OpLabel
%temp_7 = OpLoad %testtype %testvariable_7
OpStore %op_constant %temp_7
OpBranch %switchEnd
%case8 = OpLabel
%temp_8 = OpLoad %testtype %testvariable_8
OpStore %op_constant %temp_8
OpBranch %switchEnd
%case9 = OpLabel
%temp_9 = OpLoad %testtype %testvariable_9
OpStore %op_constant %temp_9
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

