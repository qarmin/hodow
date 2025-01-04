OpCapability Tessellation
${capability}
${extension}
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationEvaluation %BP_main "main" %BP_stream %BP_gl_TessCoord %BP_gl_PrimitiveID %BP_gl_in %BP_out_color %BP_in_color  
OpExecutionMode %BP_main Triangles
OpExecutionMode %BP_main SpacingEqual
OpExecutionMode %BP_main VertexOrderCcw



OpMemberDecorate %BP_gl_PerVertexOut 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertexOut 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertexOut 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertexOut 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertexOut Block
OpDecorate %BP_gl_PrimitiveID BuiltIn PrimitiveId
OpDecorate %BP_gl_TessCoord BuiltIn TessCoord
OpMemberDecorate %BP_gl_PerVertexIn 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertexIn 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertexIn 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertexIn 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertexIn Block
OpDecorate %BP_out_color Location 1
OpDecorate %BP_in_color Location 1

${decoration}
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
%BP_gl_PerVertexOut = OpTypeStruct %v4f32 %f32 %a1f32 %a1f32
%BP_op_gl_PerVertexOut = OpTypePointer Output %BP_gl_PerVertexOut
%BP_stream = OpVariable %BP_op_gl_PerVertexOut Output
%BP_gl_TessCoord = OpVariable %ip_v3f32 Input
%BP_gl_PrimitiveID = OpVariable %ip_i32 Input
%BP_gl_PerVertexIn = OpTypeStruct %v4f32 %f32 %a1f32 %a1f32
%BP_a32_gl_PerVertexIn = OpTypeArray %BP_gl_PerVertexIn %c_u32_32
%BP_ip_a32_gl_PerVertexIn = OpTypePointer Input %BP_a32_gl_PerVertexIn
%BP_gl_in = OpVariable %BP_ip_a32_gl_PerVertexIn Input
%BP_out_color = OpVariable %op_v4f32 Output
%BP_in_color = OpVariable %ip_a32v4f32 Input
${pre_main}

%BP_main = OpFunction %void None %voidf
%BP_label = OpLabel


%BP_gl_TC_0 = OpAccessChain %ip_f32 %BP_gl_TessCoord %c_u32_0
%BP_gl_TC_1 = OpAccessChain %ip_f32 %BP_gl_TessCoord %c_u32_1
%BP_gl_TC_2 = OpAccessChain %ip_f32 %BP_gl_TessCoord %c_u32_2
%BP_gl_in_gl_Pos_0 = OpAccessChain %ip_v4f32 %BP_gl_in %c_i32_0 %c_i32_0
%BP_gl_in_gl_Pos_1 = OpAccessChain %ip_v4f32 %BP_gl_in %c_i32_1 %c_i32_0
%BP_gl_in_gl_Pos_2 = OpAccessChain %ip_v4f32 %BP_gl_in %c_i32_2 %c_i32_0
%BP_gl_OPos = OpAccessChain %op_v4f32 %BP_stream %c_i32_0
%BP_in_color_0 = OpAccessChain %ip_v4f32 %BP_in_color %c_i32_0
%BP_in_color_1 = OpAccessChain %ip_v4f32 %BP_in_color %c_i32_1
%BP_in_color_2 = OpAccessChain %ip_v4f32 %BP_in_color %c_i32_2
%BP_TC_W_0 = OpLoad %f32 %BP_gl_TC_0
%BP_TC_W_1 = OpLoad %f32 %BP_gl_TC_1
%BP_TC_W_2 = OpLoad %f32 %BP_gl_TC_2
%BP_v4f32_TC_0 = OpCompositeConstruct %v4f32 %BP_TC_W_0 %BP_TC_W_0 %BP_TC_W_0 %BP_TC_W_0
%BP_v4f32_TC_1 = OpCompositeConstruct %v4f32 %BP_TC_W_1 %BP_TC_W_1 %BP_TC_W_1 %BP_TC_W_1
%BP_v4f32_TC_2 = OpCompositeConstruct %v4f32 %BP_TC_W_2 %BP_TC_W_2 %BP_TC_W_2 %BP_TC_W_2
%BP_gl_IP_0 = OpLoad %v4f32 %BP_gl_in_gl_Pos_0
%BP_gl_IP_1 = OpLoad %v4f32 %BP_gl_in_gl_Pos_1
%BP_gl_IP_2 = OpLoad %v4f32 %BP_gl_in_gl_Pos_2
%BP_IP_W_0 = OpFMul %v4f32 %BP_v4f32_TC_0 %BP_gl_IP_0
%BP_IP_W_1 = OpFMul %v4f32 %BP_v4f32_TC_1 %BP_gl_IP_1
%BP_IP_W_2 = OpFMul %v4f32 %BP_v4f32_TC_2 %BP_gl_IP_2
%BP_pos_sum_0 = OpFAdd %v4f32 %BP_IP_W_0 %BP_IP_W_1
%BP_pos_sum_1 = OpFAdd %v4f32 %BP_pos_sum_0 %BP_IP_W_2
OpStore %BP_gl_OPos %BP_pos_sum_1
%BP_IC_0 = OpLoad %v4f32 %BP_in_color_0
%BP_IC_1 = OpLoad %v4f32 %BP_in_color_1
%BP_IC_2 = OpLoad %v4f32 %BP_in_color_2
%BP_IC_W_0 = OpFMul %v4f32 %BP_v4f32_TC_0 %BP_IC_0
%BP_IC_W_1 = OpFMul %v4f32 %BP_v4f32_TC_1 %BP_IC_1
%BP_IC_W_2 = OpFMul %v4f32 %BP_v4f32_TC_2 %BP_IC_2
%BP_col_sum_0 = OpFAdd %v4f32 %BP_IC_W_0 %BP_IC_W_1
%BP_col_sum_1 = OpFAdd %v4f32 %BP_col_sum_0 %BP_IC_W_2
%BP_clr_transformed = OpFunctionCall %v4f32 %test_code %BP_col_sum_1
OpStore %BP_out_color %BP_clr_transformed
OpReturn
OpFunctionEnd

%isUniqueIdZero = OpFunction %bool None %bool_function
%getId_label = OpLabel
%primitive_id = OpLoad %i32 %BP_gl_PrimitiveID
%is_primitive_0 = OpIEqual %bool %primitive_id %c_i32_0
%TC_0_loc = OpAccessChain %ip_f32 %BP_gl_TessCoord %c_u32_0
%TC_1_loc = OpAccessChain %ip_f32 %BP_gl_TessCoord %c_u32_1
%TC_2_loc = OpAccessChain %ip_f32 %BP_gl_TessCoord %c_u32_2
%TC_W_0 = OpLoad %f32 %TC_0_loc
%TC_W_1 = OpLoad %f32 %TC_1_loc
%TC_W_2 = OpLoad %f32 %TC_2_loc
%is_W_0_1 = OpFOrdEqual %bool %TC_W_0 %c_f32_1
%is_W_1_0 = OpFOrdEqual %bool %TC_W_1 %c_f32_0
%is_W_2_0 = OpFOrdEqual %bool %TC_W_2 %c_f32_0
%is_tessCoord_1_0 = OpLogicalAnd %bool %is_W_0_1 %is_W_1_0
%is_tessCoord_1_0_0 = OpLogicalAnd %bool %is_tessCoord_1_0 %is_W_2_0
%is_unique_id_0 = OpLogicalAnd %bool %is_tessCoord_1_0_0 %is_primitive_0
OpReturnValue %is_unique_id_0
OpFunctionEnd
${testfun}
