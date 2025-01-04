OpCapability Tessellation
${capability}
${extension}
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %BP_main "main" %BP_out_color %BP_gl_InvocationID %BP_gl_PrimitiveID %BP_in_color %BP_gl_out %BP_gl_in %BP_gl_TessLevelOuter %BP_gl_TessLevelInner  
OpExecutionMode %BP_main OutputVertices 3
${execution_mode}
${debug}
${moduleprocessed}
OpDecorate %BP_out_color Location 1
OpDecorate %BP_gl_InvocationID BuiltIn InvocationId
OpDecorate %BP_gl_PrimitiveID BuiltIn PrimitiveId
OpDecorate %BP_in_color Location 1
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpMemberDecorate %BP_gl_PVOut 0 BuiltIn Position
OpMemberDecorate %BP_gl_PVOut 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PVOut 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PVOut 3 BuiltIn CullDistance
OpDecorate %BP_gl_PVOut Block
OpDecorate %BP_gl_TessLevelOuter Patch
OpDecorate %BP_gl_TessLevelOuter BuiltIn TessLevelOuter
OpDecorate %BP_gl_TessLevelInner Patch
OpDecorate %BP_gl_TessLevelInner BuiltIn TessLevelInner

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
%BP_out_color = OpVariable %op_a3v4f32 Output
%BP_gl_InvocationID = OpVariable %ip_i32 Input
%BP_gl_PrimitiveID = OpVariable %ip_i32 Input
%BP_in_color = OpVariable %ip_a32v4f32 Input
%BP_gl_PerVertex = OpTypeStruct %v4f32 %f32 %a1f32 %a1f32
%BP_a3_gl_PerVertex = OpTypeArray %BP_gl_PerVertex %c_u32_3
%BP_op_a3_gl_PerVertex = OpTypePointer Output %BP_a3_gl_PerVertex
%BP_gl_out = OpVariable %BP_op_a3_gl_PerVertex Output
%BP_gl_PVOut = OpTypeStruct %v4f32 %f32 %a1f32 %a1f32
%BP_a32_gl_PVOut = OpTypeArray %BP_gl_PVOut %c_u32_32
%BP_ip_a32_gl_PVOut = OpTypePointer Input %BP_a32_gl_PVOut
%BP_gl_in = OpVariable %BP_ip_a32_gl_PVOut Input
%BP_gl_TessLevelOuter = OpVariable %op_a4f32 Output
%BP_gl_TessLevelInner = OpVariable %op_a2f32 Output
${pre_main}

%BP_main = OpFunction %void None %voidf
%BP_label = OpLabel
%BP_gl_Invoc = OpLoad %i32 %BP_gl_InvocationID


%BP_in_col_loc = OpAccessChain %ip_v4f32 %BP_in_color %BP_gl_Invoc
%BP_out_col_loc = OpAccessChain %op_v4f32 %BP_out_color %BP_gl_Invoc
%BP_in_col_val = OpLoad %v4f32 %BP_in_col_loc
%BP_clr_transformed = OpFunctionCall %v4f32 %test_code %BP_in_col_val
OpStore %BP_out_col_loc %BP_clr_transformed
%BP_in_pos_loc = OpAccessChain %ip_v4f32 %BP_gl_in %BP_gl_Invoc %c_i32_0
%BP_out_pos_loc = OpAccessChain %op_v4f32 %BP_gl_out %BP_gl_Invoc %c_i32_0
%BP_in_pos_val = OpLoad %v4f32 %BP_in_pos_loc
OpStore %BP_out_pos_loc %BP_in_pos_val
%BP_cmp = OpIEqual %bool %BP_gl_Invoc %c_i32_0
OpSelectionMerge %BP_merge_label None
OpBranchConditional %BP_cmp %BP_if_label %BP_merge_label
%BP_if_label = OpLabel
%BP_gl_TessLevelOuterPos_0 = OpAccessChain %op_f32 %BP_gl_TessLevelOuter %c_i32_0
%BP_gl_TessLevelOuterPos_1 = OpAccessChain %op_f32 %BP_gl_TessLevelOuter %c_i32_1
%BP_gl_TessLevelOuterPos_2 = OpAccessChain %op_f32 %BP_gl_TessLevelOuter %c_i32_2
%BP_gl_TessLevelInnerPos_0 = OpAccessChain %op_f32 %BP_gl_TessLevelInner %c_i32_0
OpStore %BP_gl_TessLevelOuterPos_0 %c_f32_1
OpStore %BP_gl_TessLevelOuterPos_1 %c_f32_1
OpStore %BP_gl_TessLevelOuterPos_2 %c_f32_1
OpStore %BP_gl_TessLevelInnerPos_0 %c_f32_1
OpBranch %BP_merge_label
%BP_merge_label = OpLabel
OpReturn
OpFunctionEnd

%isUniqueIdZero = OpFunction %bool None %bool_function
%getId_label = OpLabel
%invocation_id = OpLoad %i32 %BP_gl_InvocationID
%primitive_id = OpLoad %i32 %BP_gl_PrimitiveID
%is_invocation_0 = OpIEqual %bool %invocation_id %c_i32_0
%is_primitive_0 = OpIEqual %bool %primitive_id %c_i32_0
%is_id_0 = OpLogicalAnd %bool %is_invocation_0 %is_primitive_0
OpReturnValue %is_id_0
OpFunctionEnd
${testfun}
