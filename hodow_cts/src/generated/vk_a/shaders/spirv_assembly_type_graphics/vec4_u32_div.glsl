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

OpDecorate %input0 DescriptorSet 0
OpDecorate %input0 Binding 0
OpDecorate %input1 DescriptorSet 0
OpDecorate %input1 Binding 1
OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 2
OpDecorate %a380testtype ArrayStride 16
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a380scalartype ArrayStride 16
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
%c_u32_380 = OpConstant %u32 380
%c_i32_380 = OpConstant %i32 380

%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v4u32  %c_shift1 %c_shift1 %c_shift1 %c_shift1

%c_zero = OpConstantComposite %v4u32 %c_u32_0 %c_u32_0 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v4u32 %c_u32_1 %c_u32_1 %c_u32_1 %c_u32_1
%a380scalartype = OpTypeArray %u32 %c_u32_380
%up_scalartype = OpTypePointer Uniform %u32
%scalarbuf = OpTypeStruct %a380scalartype
%scalarbufptr = OpTypePointer Uniform %scalarbuf
%a380testtype = OpTypeArray %v4u32 %c_u32_380
%up_testtype = OpTypePointer Uniform %v4u32
%buf = OpTypeStruct %a380testtype
%bufptr = OpTypePointer Uniform %buf
%output = OpVariable %bufptr Uniform

%fp_v4u32 = OpTypePointer Function %v4u32

%input0 = OpVariable %bufptr Uniform
%input1 = OpVariable %bufptr Uniform


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
%op_constant = OpVariable %fp_v4u32 Function
%counter = OpVariable %fp_i32 Function
OpStore %counter %c_i32_0
OpBranch %loop
%loop = OpLabel
%counter_val = OpLoad %i32 %counter
%lt = OpSLessThan %bool %counter_val %c_i32_380
OpLoopMerge %exit %inc None
OpBranchConditional %lt %write %exit
%write = OpLabel
%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val
%input0_loc = OpAccessChain %up_testtype %input0 %c_i32_0 %counter_val
%input0_val = OpLoad %v4u32 %input0_loc
%input1_loc = OpAccessChain %up_testtype %input1 %c_i32_0 %counter_val
%input1_val = OpLoad %v4u32 %input1_loc
%op_result = OpUDiv %v4u32 %input0_val %input1_val
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


OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %input0 DescriptorSet 0
OpDecorate %input0 Binding 0
OpDecorate %input1 DescriptorSet 0
OpDecorate %input1 Binding 1
OpDecorate %output DescriptorSet 0
OpDecorate %output Binding 2
OpDecorate %a380testtype ArrayStride 16
OpDecorate %buf BufferBlock
OpMemberDecorate %buf 0 Offset 0
OpDecorate %a380scalartype ArrayStride 16
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
%c_u32_380 = OpConstant %u32 380
%c_i32_380 = OpConstant %i32 380

%c_shift1 = OpConstant %u32 16
%c_shift  = OpConstantComposite %v4u32  %c_shift1 %c_shift1 %c_shift1 %c_shift1

%c_zero = OpConstantComposite %v4u32 %c_u32_0 %c_u32_0 %c_u32_0 %c_u32_0
%c_one = OpConstantComposite %v4u32 %c_u32_1 %c_u32_1 %c_u32_1 %c_u32_1
%a380scalartype = OpTypeArray %u32 %c_u32_380
%up_scalartype = OpTypePointer Uniform %u32
%scalarbuf = OpTypeStruct %a380scalartype
%scalarbufptr = OpTypePointer Uniform %scalarbuf
%a380testtype = OpTypeArray %v4u32 %c_u32_380
%up_testtype = OpTypePointer Uniform %v4u32
%buf = OpTypeStruct %a380testtype
%bufptr = OpTypePointer Uniform %buf
%output = OpVariable %bufptr Uniform

%fp_v4u32 = OpTypePointer Function %v4u32

%input0 = OpVariable %bufptr Uniform
%input1 = OpVariable %bufptr Uniform


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
%op_constant = OpVariable %fp_v4u32 Function
%counter = OpVariable %fp_i32 Function
OpStore %counter %c_i32_0
OpBranch %loop
%loop = OpLabel
%counter_val = OpLoad %i32 %counter
%lt = OpSLessThan %bool %counter_val %c_i32_380
OpLoopMerge %exit %inc None
OpBranchConditional %lt %write %exit
%write = OpLabel
%output_loc = OpAccessChain %up_testtype %output %c_i32_0 %counter_val
%input0_loc = OpAccessChain %up_testtype %input0 %c_i32_0 %counter_val
%input0_val = OpLoad %v4u32 %input0_loc
%input1_loc = OpAccessChain %up_testtype %input1 %c_i32_0 %counter_val
%input1_val = OpLoad %v4u32 %input1_loc
%op_result = OpUDiv %v4u32 %input0_val %input1_val
OpStore %output_loc %op_result
OpBranch %inc
%inc = OpLabel
%counter_val_next = OpIAdd %i32 %counter_val %c_i32_1
OpStore %counter %counter_val_next
OpBranch %loop
%exit = OpLabel
OpReturnValue %param
OpFunctionEnd

