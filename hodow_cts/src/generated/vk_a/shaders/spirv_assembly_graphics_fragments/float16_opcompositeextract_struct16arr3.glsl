OpCapability Shader
OpCapability Float16


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

OpDecorate %SSBO_src BufferBlock
OpDecorate %SSBO_dst BufferBlock
OpDecorate %ra_f16 ArrayStride 4
OpDecorate %ra_st ArrayStride 4
OpDecorate %ssbo_src DescriptorSet 0
OpDecorate %ssbo_src Binding 0
OpDecorate %ssbo_dst DescriptorSet 0
OpDecorate %ssbo_dst Binding 1
OpMemberDecorate %SSBO_src 0 Offset 0
OpMemberDecorate %SSBO_dst 0 Offset 0
OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr3 ArrayStride 16
OpDecorate %f16arr3 ArrayStride 2
OpDecorate %v2f16arr5 ArrayStride 4
OpDecorate %v3f16arr5 ArrayStride 8
OpDecorate %v4f16arr3 ArrayStride 8
OpMemberDecorate %st_test 0 Offset 0

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
   %c_i32_ndp = OpConstant %i32 24
  %c_i32_hndp = OpSpecConstantOp %i32 SDiv %c_i32_ndp %c_i32_2
  %c_i32_size = OpConstant %i32 12
%c_u32_high_ones = OpConstant %u32 0xffff0000
 %c_u32_low_ones = OpConstant %u32 0x0000ffff
         %f16 = OpTypeFloat 16
       %v2f16 = OpTypeVector %f16 2
       %v3f16 = OpTypeVector %f16 3
       %v4f16 = OpTypeVector %f16 4
    %c_f16_na = OpConstant %f16 -1.0
  %c_v2f16_n1 = OpConstantComposite %v2f16 %c_f16_na %c_f16_na
     %c_u32_5 = OpConstant %u32 5
     %c_i32_5 = OpConstant %i32 5
     %c_i32_6 = OpConstant %i32 6
     %c_i32_7 = OpConstant %i32 7
     %c_i32_8 = OpConstant %i32 8
     %c_i32_9 = OpConstant %i32 9
    %c_i32_10 = OpConstant %i32 10
    %c_i32_11 = OpConstant %i32 11
%f16arr3      = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr5    = OpTypeArray %v2f16 %c_u32_5
%v3f16arr5    = OpTypeArray %v3f16 %c_u32_5
%v4f16arr3    = OpTypeArray %v4f16 %c_u32_3
%struct16     = OpTypeStruct %f16 %v2f16arr3
%struct16arr3 = OpTypeArray %struct16 %c_u32_3
%st_test      = OpTypeStruct %struct16arr3
      %ra_f16 = OpTypeArray %u32 %c_i32_hndp
       %ra_st = OpTypeArray %u32 %c_i32_size
      %up_u32 = OpTypePointer Uniform %u32
     %st_test_i32_fn = OpTypeFunction %st_test %i32
%void_st_test_i32_fn = OpTypeFunction %void %st_test %i32
         %f16_i32_fn = OpTypeFunction %f16 %i32
    %void_f16_i32_fn = OpTypeFunction %void %f16 %i32
       %v2f16_i32_fn = OpTypeFunction %v2f16 %i32
  %void_v2f16_i32_fn = OpTypeFunction %void %v2f16 %i32
       %fun_t = OpTypeFunction %f16 %st_test %i32
    %SSBO_src = OpTypeStruct %ra_st
    %SSBO_dst = OpTypeStruct %ra_f16
 %up_SSBO_src = OpTypePointer Uniform %SSBO_src
 %up_SSBO_dst = OpTypePointer Uniform %SSBO_dst
    %ssbo_src = OpVariable %up_SSBO_src Uniform
    %ssbo_dst = OpVariable %up_SSBO_dst Uniform


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
         %i = OpVariable %fp_i32 Function
              OpStore %i %c_i32_0
  %will_run = OpFunctionCall %bool %isUniqueIdZero
              OpSelectionMerge %end_if None
              OpBranchConditional %will_run %run_test %end_if
  %run_test = OpLabel
              OpBranch %loop
      %loop = OpLabel
     %i_cmp = OpLoad %i32 %i
        %lt = OpSLessThan %bool %i_cmp %c_i32_ndp
              OpLoopMerge %merge %next None
              OpBranchConditional %lt %write %merge
     %write = OpLabel
       %ndx = OpLoad %i32 %i
   %val_src = OpFunctionCall %st_test %ld_ssbo_src %c_i32_0
   %val_dst = OpFunctionCall %f16 %sw_fun %val_src %ndx
    %dst_st = OpFunctionCall %void %st_fn_ssbo_dst %val_dst %ndx
              OpBranch %next
      %next = OpLabel
     %i_cur = OpLoad %i32 %i
     %i_new = OpIAdd %i32 %i_cur %c_i32_1
              OpStore %i %i_new
              OpBranch %loop
     %merge = OpLabel
              OpBranch %end_if
    %end_if = OpLabel
              OpReturnValue %param
              OpFunctionEnd
   %sw_fun = OpFunction %f16 None %fun_t
 %sw_param = OpFunctionParameter %st_test
%sw_paramn = OpFunctionParameter %i32
 %sw_entry = OpLabel
             OpSelectionMerge %switch_e None
             OpSwitch %sw_paramn %default 0 %case_0 2 %case_2 3 %case_3 4 %case_4 5 %case_5 6 %case_6 7 %case_7 8 %case_8 10 %case_10 11 %case_11 12 %case_12 13 %case_13 14 %case_14 15 %case_15 16 %case_16 18 %case_18 19 %case_19 20 %case_20 21 %case_21 22 %case_22 23 %case_23 
%case_0    = OpLabel
%val_ret_0 = OpCompositeExtract %f16 %sw_param 0 0 0
             OpReturnValue %val_ret_0
%case_2    = OpLabel
%val_ret_2 = OpCompositeExtract %f16 %sw_param 0 0 1 0 0
             OpReturnValue %val_ret_2
%case_3    = OpLabel
%val_ret_3 = OpCompositeExtract %f16 %sw_param 0 0 1 0 1
             OpReturnValue %val_ret_3
%case_4    = OpLabel
%val_ret_4 = OpCompositeExtract %f16 %sw_param 0 0 1 1 0
             OpReturnValue %val_ret_4
%case_5    = OpLabel
%val_ret_5 = OpCompositeExtract %f16 %sw_param 0 0 1 1 1
             OpReturnValue %val_ret_5
%case_6    = OpLabel
%val_ret_6 = OpCompositeExtract %f16 %sw_param 0 0 1 2 0
             OpReturnValue %val_ret_6
%case_7    = OpLabel
%val_ret_7 = OpCompositeExtract %f16 %sw_param 0 0 1 2 1
             OpReturnValue %val_ret_7
%case_8    = OpLabel
%val_ret_8 = OpCompositeExtract %f16 %sw_param 0 1 0
             OpReturnValue %val_ret_8
%case_10    = OpLabel
%val_ret_10 = OpCompositeExtract %f16 %sw_param 0 1 1 0 0
             OpReturnValue %val_ret_10
%case_11    = OpLabel
%val_ret_11 = OpCompositeExtract %f16 %sw_param 0 1 1 0 1
             OpReturnValue %val_ret_11
%case_12    = OpLabel
%val_ret_12 = OpCompositeExtract %f16 %sw_param 0 1 1 1 0
             OpReturnValue %val_ret_12
%case_13    = OpLabel
%val_ret_13 = OpCompositeExtract %f16 %sw_param 0 1 1 1 1
             OpReturnValue %val_ret_13
%case_14    = OpLabel
%val_ret_14 = OpCompositeExtract %f16 %sw_param 0 1 1 2 0
             OpReturnValue %val_ret_14
%case_15    = OpLabel
%val_ret_15 = OpCompositeExtract %f16 %sw_param 0 1 1 2 1
             OpReturnValue %val_ret_15
%case_16    = OpLabel
%val_ret_16 = OpCompositeExtract %f16 %sw_param 0 2 0
             OpReturnValue %val_ret_16
%case_18    = OpLabel
%val_ret_18 = OpCompositeExtract %f16 %sw_param 0 2 1 0 0
             OpReturnValue %val_ret_18
%case_19    = OpLabel
%val_ret_19 = OpCompositeExtract %f16 %sw_param 0 2 1 0 1
             OpReturnValue %val_ret_19
%case_20    = OpLabel
%val_ret_20 = OpCompositeExtract %f16 %sw_param 0 2 1 1 0
             OpReturnValue %val_ret_20
%case_21    = OpLabel
%val_ret_21 = OpCompositeExtract %f16 %sw_param 0 2 1 1 1
             OpReturnValue %val_ret_21
%case_22    = OpLabel
%val_ret_22 = OpCompositeExtract %f16 %sw_param 0 2 1 2 0
             OpReturnValue %val_ret_22
%case_23    = OpLabel
%val_ret_23 = OpCompositeExtract %f16 %sw_param 0 2 1 2 1
             OpReturnValue %val_ret_23
%default   = OpLabel
             OpReturnValue %c_f16_na
%switch_e  = OpLabel
             OpUnreachable
             OpFunctionEnd
          %ld_ssbo_src = OpFunction %st_test None %st_test_i32_fn
    %ld_ssbo_src_param = OpFunctionParameter %i32
    %ld_ssbo_src_entry = OpLabel
%ld_ssbo_src_gep_0_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_0
%ld_ssbo_src_gep_0_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_1
%ld_ssbo_src_gep_0_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_2
%ld_ssbo_src_gep_0_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_3
%ld_ssbo_src_gep_1_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_4
%ld_ssbo_src_gep_1_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_5
%ld_ssbo_src_gep_1_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_6
%ld_ssbo_src_gep_1_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_7
%ld_ssbo_src_gep_2_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_8
%ld_ssbo_src_gep_2_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_9
%ld_ssbo_src_gep_2_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_10
%ld_ssbo_src_gep_2_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_11
 %ld_ssbo_src_ld_0_0   = OpLoad %u32 %ld_ssbo_src_gep_0_0
 %ld_ssbo_src_ld_0_1_0 = OpLoad %u32 %ld_ssbo_src_gep_0_1_0
 %ld_ssbo_src_ld_0_1_1 = OpLoad %u32 %ld_ssbo_src_gep_0_1_1
 %ld_ssbo_src_ld_0_1_2 = OpLoad %u32 %ld_ssbo_src_gep_0_1_2
 %ld_ssbo_src_ld_1_0   = OpLoad %u32 %ld_ssbo_src_gep_1_0
 %ld_ssbo_src_ld_1_1_0 = OpLoad %u32 %ld_ssbo_src_gep_1_1_0
 %ld_ssbo_src_ld_1_1_1 = OpLoad %u32 %ld_ssbo_src_gep_1_1_1
 %ld_ssbo_src_ld_1_1_2 = OpLoad %u32 %ld_ssbo_src_gep_1_1_2
 %ld_ssbo_src_ld_2_0   = OpLoad %u32 %ld_ssbo_src_gep_2_0
 %ld_ssbo_src_ld_2_1_0 = OpLoad %u32 %ld_ssbo_src_gep_2_1_0
 %ld_ssbo_src_ld_2_1_1 = OpLoad %u32 %ld_ssbo_src_gep_2_1_1
 %ld_ssbo_src_ld_2_1_2 = OpLoad %u32 %ld_ssbo_src_gep_2_1_2
 %ld_ssbo_src_bc_0_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_0_0
 %ld_ssbo_src_bc_0_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_0
 %ld_ssbo_src_bc_0_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_1
 %ld_ssbo_src_bc_0_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_2
 %ld_ssbo_src_bc_1_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_1_0
 %ld_ssbo_src_bc_1_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_0
 %ld_ssbo_src_bc_1_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_1
 %ld_ssbo_src_bc_1_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_2
 %ld_ssbo_src_bc_2_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_2_0
 %ld_ssbo_src_bc_2_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_0
 %ld_ssbo_src_bc_2_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_1
 %ld_ssbo_src_bc_2_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_2
    %ld_ssbo_src_arr_0 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_0_1_0 %ld_ssbo_src_bc_0_1_1 %ld_ssbo_src_bc_0_1_2
    %ld_ssbo_src_arr_1 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_1_1_0 %ld_ssbo_src_bc_1_1_1 %ld_ssbo_src_bc_1_1_2
    %ld_ssbo_src_arr_2 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_2_1_0 %ld_ssbo_src_bc_2_1_1 %ld_ssbo_src_bc_2_1_2
     %ld_ssbo_src_ex_0 = OpCompositeExtract %f16 %ld_ssbo_src_bc_0_0 0
     %ld_ssbo_src_ex_1 = OpCompositeExtract %f16 %ld_ssbo_src_bc_1_0 0
     %ld_ssbo_src_ex_2 = OpCompositeExtract %f16 %ld_ssbo_src_bc_2_0 0
     %ld_ssbo_src_st_0 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_0 %ld_ssbo_src_arr_0
     %ld_ssbo_src_st_1 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_1 %ld_ssbo_src_arr_1
     %ld_ssbo_src_st_2 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_2 %ld_ssbo_src_arr_2
     %ld_ssbo_src_cons = OpCompositeConstruct %struct16arr3 %ld_ssbo_src_st_0 %ld_ssbo_src_st_1 %ld_ssbo_src_st_2
  %ld_ssbo_src_st_test = OpCompositeConstruct %st_test %ld_ssbo_src_cons
                       OpReturnValue %ld_ssbo_src_st_test
                      OpFunctionEnd
%st_fn_ssbo_dst = OpFunction %void None %void_f16_i32_fn
%st_fn_ssbo_dst_param1 = OpFunctionParameter %f16
%st_fn_ssbo_dst_param2 = OpFunctionParameter %i32
%st_fn_ssbo_dst_entry = OpLabel
%st_fn_ssbo_dst_and_low = OpBitwiseAnd %u32 %st_fn_ssbo_dst_param2 %c_u32_1
%st_fn_ssbo_dst_zero_vec = OpBitcast %v2f16 %c_u32_0
%st_fn_ssbo_dst_insert = OpVectorInsertDynamic %v2f16 %st_fn_ssbo_dst_zero_vec %st_fn_ssbo_dst_param1 %st_fn_ssbo_dst_and_low
%st_fn_ssbo_dst_odd = OpIEqual %bool %st_fn_ssbo_dst_and_low %c_u32_1
%st_fn_ssbo_dst_sel = OpSelect %u32 %st_fn_ssbo_dst_odd %c_u32_low_ones %c_u32_high_ones
%st_fn_ssbo_dst_cast = OpBitcast %u32 %st_fn_ssbo_dst_insert
%st_fn_ssbo_dst_or = OpBitwiseOr %u32 %st_fn_ssbo_dst_cast %st_fn_ssbo_dst_sel
%st_fn_ssbo_dst_conv = OpBitcast %u32 %st_fn_ssbo_dst_param2
%st_fn_ssbo_dst_div = OpUDiv %u32 %st_fn_ssbo_dst_conv %c_u32_2
%st_fn_ssbo_dst_gep = OpAccessChain %up_u32 %ssbo_dst %c_u32_0 %st_fn_ssbo_dst_div
%st_fn_ssbo_dst_and = OpAtomicAnd %u32 %st_fn_ssbo_dst_gep %c_u32_1 %c_u32_0 %st_fn_ssbo_dst_or
OpReturn
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

OpCapability Tessellation
OpCapability Float16


OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %BP_main "main" %BP_out_color %BP_gl_InvocationID %BP_gl_PrimitiveID %BP_in_color %BP_gl_out %BP_gl_in %BP_gl_TessLevelOuter %BP_gl_TessLevelInner  
OpExecutionMode %BP_main OutputVertices 3



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

OpDecorate %SSBO_src BufferBlock
OpDecorate %SSBO_dst BufferBlock
OpDecorate %ra_f16 ArrayStride 4
OpDecorate %ra_st ArrayStride 4
OpDecorate %ssbo_src DescriptorSet 0
OpDecorate %ssbo_src Binding 0
OpDecorate %ssbo_dst DescriptorSet 0
OpDecorate %ssbo_dst Binding 1
OpMemberDecorate %SSBO_src 0 Offset 0
OpMemberDecorate %SSBO_dst 0 Offset 0
OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr3 ArrayStride 16
OpDecorate %f16arr3 ArrayStride 2
OpDecorate %v2f16arr5 ArrayStride 4
OpDecorate %v3f16arr5 ArrayStride 8
OpDecorate %v4f16arr3 ArrayStride 8
OpMemberDecorate %st_test 0 Offset 0


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
   %c_i32_ndp = OpConstant %i32 24
  %c_i32_hndp = OpSpecConstantOp %i32 SDiv %c_i32_ndp %c_i32_2
  %c_i32_size = OpConstant %i32 12
%c_u32_high_ones = OpConstant %u32 0xffff0000
 %c_u32_low_ones = OpConstant %u32 0x0000ffff
         %f16 = OpTypeFloat 16
       %v2f16 = OpTypeVector %f16 2
       %v3f16 = OpTypeVector %f16 3
       %v4f16 = OpTypeVector %f16 4
    %c_f16_na = OpConstant %f16 -1.0
  %c_v2f16_n1 = OpConstantComposite %v2f16 %c_f16_na %c_f16_na
     %c_u32_5 = OpConstant %u32 5
     %c_i32_5 = OpConstant %i32 5
     %c_i32_6 = OpConstant %i32 6
     %c_i32_7 = OpConstant %i32 7
     %c_i32_8 = OpConstant %i32 8
     %c_i32_9 = OpConstant %i32 9
    %c_i32_10 = OpConstant %i32 10
    %c_i32_11 = OpConstant %i32 11
%f16arr3      = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr5    = OpTypeArray %v2f16 %c_u32_5
%v3f16arr5    = OpTypeArray %v3f16 %c_u32_5
%v4f16arr3    = OpTypeArray %v4f16 %c_u32_3
%struct16     = OpTypeStruct %f16 %v2f16arr3
%struct16arr3 = OpTypeArray %struct16 %c_u32_3
%st_test      = OpTypeStruct %struct16arr3
      %ra_f16 = OpTypeArray %u32 %c_i32_hndp
       %ra_st = OpTypeArray %u32 %c_i32_size
      %up_u32 = OpTypePointer Uniform %u32
     %st_test_i32_fn = OpTypeFunction %st_test %i32
%void_st_test_i32_fn = OpTypeFunction %void %st_test %i32
         %f16_i32_fn = OpTypeFunction %f16 %i32
    %void_f16_i32_fn = OpTypeFunction %void %f16 %i32
       %v2f16_i32_fn = OpTypeFunction %v2f16 %i32
  %void_v2f16_i32_fn = OpTypeFunction %void %v2f16 %i32
       %fun_t = OpTypeFunction %f16 %st_test %i32
    %SSBO_src = OpTypeStruct %ra_st
    %SSBO_dst = OpTypeStruct %ra_f16
 %up_SSBO_src = OpTypePointer Uniform %SSBO_src
 %up_SSBO_dst = OpTypePointer Uniform %SSBO_dst
    %ssbo_src = OpVariable %up_SSBO_src Uniform
    %ssbo_dst = OpVariable %up_SSBO_dst Uniform


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
 %test_code = OpFunction %v4f32 None %v4f32_v4f32_function
     %param = OpFunctionParameter %v4f32
     %entry = OpLabel
         %i = OpVariable %fp_i32 Function
              OpStore %i %c_i32_0
  %will_run = OpFunctionCall %bool %isUniqueIdZero
              OpSelectionMerge %end_if None
              OpBranchConditional %will_run %run_test %end_if
  %run_test = OpLabel
              OpBranch %loop
      %loop = OpLabel
     %i_cmp = OpLoad %i32 %i
        %lt = OpSLessThan %bool %i_cmp %c_i32_ndp
              OpLoopMerge %merge %next None
              OpBranchConditional %lt %write %merge
     %write = OpLabel
       %ndx = OpLoad %i32 %i
   %val_src = OpFunctionCall %st_test %ld_ssbo_src %c_i32_0
   %val_dst = OpFunctionCall %f16 %sw_fun %val_src %ndx
    %dst_st = OpFunctionCall %void %st_fn_ssbo_dst %val_dst %ndx
              OpBranch %next
      %next = OpLabel
     %i_cur = OpLoad %i32 %i
     %i_new = OpIAdd %i32 %i_cur %c_i32_1
              OpStore %i %i_new
              OpBranch %loop
     %merge = OpLabel
              OpBranch %end_if
    %end_if = OpLabel
              OpReturnValue %param
              OpFunctionEnd
   %sw_fun = OpFunction %f16 None %fun_t
 %sw_param = OpFunctionParameter %st_test
%sw_paramn = OpFunctionParameter %i32
 %sw_entry = OpLabel
             OpSelectionMerge %switch_e None
             OpSwitch %sw_paramn %default 0 %case_0 2 %case_2 3 %case_3 4 %case_4 5 %case_5 6 %case_6 7 %case_7 8 %case_8 10 %case_10 11 %case_11 12 %case_12 13 %case_13 14 %case_14 15 %case_15 16 %case_16 18 %case_18 19 %case_19 20 %case_20 21 %case_21 22 %case_22 23 %case_23 
%case_0    = OpLabel
%val_ret_0 = OpCompositeExtract %f16 %sw_param 0 0 0
             OpReturnValue %val_ret_0
%case_2    = OpLabel
%val_ret_2 = OpCompositeExtract %f16 %sw_param 0 0 1 0 0
             OpReturnValue %val_ret_2
%case_3    = OpLabel
%val_ret_3 = OpCompositeExtract %f16 %sw_param 0 0 1 0 1
             OpReturnValue %val_ret_3
%case_4    = OpLabel
%val_ret_4 = OpCompositeExtract %f16 %sw_param 0 0 1 1 0
             OpReturnValue %val_ret_4
%case_5    = OpLabel
%val_ret_5 = OpCompositeExtract %f16 %sw_param 0 0 1 1 1
             OpReturnValue %val_ret_5
%case_6    = OpLabel
%val_ret_6 = OpCompositeExtract %f16 %sw_param 0 0 1 2 0
             OpReturnValue %val_ret_6
%case_7    = OpLabel
%val_ret_7 = OpCompositeExtract %f16 %sw_param 0 0 1 2 1
             OpReturnValue %val_ret_7
%case_8    = OpLabel
%val_ret_8 = OpCompositeExtract %f16 %sw_param 0 1 0
             OpReturnValue %val_ret_8
%case_10    = OpLabel
%val_ret_10 = OpCompositeExtract %f16 %sw_param 0 1 1 0 0
             OpReturnValue %val_ret_10
%case_11    = OpLabel
%val_ret_11 = OpCompositeExtract %f16 %sw_param 0 1 1 0 1
             OpReturnValue %val_ret_11
%case_12    = OpLabel
%val_ret_12 = OpCompositeExtract %f16 %sw_param 0 1 1 1 0
             OpReturnValue %val_ret_12
%case_13    = OpLabel
%val_ret_13 = OpCompositeExtract %f16 %sw_param 0 1 1 1 1
             OpReturnValue %val_ret_13
%case_14    = OpLabel
%val_ret_14 = OpCompositeExtract %f16 %sw_param 0 1 1 2 0
             OpReturnValue %val_ret_14
%case_15    = OpLabel
%val_ret_15 = OpCompositeExtract %f16 %sw_param 0 1 1 2 1
             OpReturnValue %val_ret_15
%case_16    = OpLabel
%val_ret_16 = OpCompositeExtract %f16 %sw_param 0 2 0
             OpReturnValue %val_ret_16
%case_18    = OpLabel
%val_ret_18 = OpCompositeExtract %f16 %sw_param 0 2 1 0 0
             OpReturnValue %val_ret_18
%case_19    = OpLabel
%val_ret_19 = OpCompositeExtract %f16 %sw_param 0 2 1 0 1
             OpReturnValue %val_ret_19
%case_20    = OpLabel
%val_ret_20 = OpCompositeExtract %f16 %sw_param 0 2 1 1 0
             OpReturnValue %val_ret_20
%case_21    = OpLabel
%val_ret_21 = OpCompositeExtract %f16 %sw_param 0 2 1 1 1
             OpReturnValue %val_ret_21
%case_22    = OpLabel
%val_ret_22 = OpCompositeExtract %f16 %sw_param 0 2 1 2 0
             OpReturnValue %val_ret_22
%case_23    = OpLabel
%val_ret_23 = OpCompositeExtract %f16 %sw_param 0 2 1 2 1
             OpReturnValue %val_ret_23
%default   = OpLabel
             OpReturnValue %c_f16_na
%switch_e  = OpLabel
             OpUnreachable
             OpFunctionEnd
          %ld_ssbo_src = OpFunction %st_test None %st_test_i32_fn
    %ld_ssbo_src_param = OpFunctionParameter %i32
    %ld_ssbo_src_entry = OpLabel
%ld_ssbo_src_gep_0_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_0
%ld_ssbo_src_gep_0_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_1
%ld_ssbo_src_gep_0_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_2
%ld_ssbo_src_gep_0_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_3
%ld_ssbo_src_gep_1_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_4
%ld_ssbo_src_gep_1_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_5
%ld_ssbo_src_gep_1_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_6
%ld_ssbo_src_gep_1_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_7
%ld_ssbo_src_gep_2_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_8
%ld_ssbo_src_gep_2_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_9
%ld_ssbo_src_gep_2_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_10
%ld_ssbo_src_gep_2_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_11
 %ld_ssbo_src_ld_0_0   = OpLoad %u32 %ld_ssbo_src_gep_0_0
 %ld_ssbo_src_ld_0_1_0 = OpLoad %u32 %ld_ssbo_src_gep_0_1_0
 %ld_ssbo_src_ld_0_1_1 = OpLoad %u32 %ld_ssbo_src_gep_0_1_1
 %ld_ssbo_src_ld_0_1_2 = OpLoad %u32 %ld_ssbo_src_gep_0_1_2
 %ld_ssbo_src_ld_1_0   = OpLoad %u32 %ld_ssbo_src_gep_1_0
 %ld_ssbo_src_ld_1_1_0 = OpLoad %u32 %ld_ssbo_src_gep_1_1_0
 %ld_ssbo_src_ld_1_1_1 = OpLoad %u32 %ld_ssbo_src_gep_1_1_1
 %ld_ssbo_src_ld_1_1_2 = OpLoad %u32 %ld_ssbo_src_gep_1_1_2
 %ld_ssbo_src_ld_2_0   = OpLoad %u32 %ld_ssbo_src_gep_2_0
 %ld_ssbo_src_ld_2_1_0 = OpLoad %u32 %ld_ssbo_src_gep_2_1_0
 %ld_ssbo_src_ld_2_1_1 = OpLoad %u32 %ld_ssbo_src_gep_2_1_1
 %ld_ssbo_src_ld_2_1_2 = OpLoad %u32 %ld_ssbo_src_gep_2_1_2
 %ld_ssbo_src_bc_0_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_0_0
 %ld_ssbo_src_bc_0_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_0
 %ld_ssbo_src_bc_0_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_1
 %ld_ssbo_src_bc_0_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_2
 %ld_ssbo_src_bc_1_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_1_0
 %ld_ssbo_src_bc_1_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_0
 %ld_ssbo_src_bc_1_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_1
 %ld_ssbo_src_bc_1_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_2
 %ld_ssbo_src_bc_2_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_2_0
 %ld_ssbo_src_bc_2_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_0
 %ld_ssbo_src_bc_2_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_1
 %ld_ssbo_src_bc_2_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_2
    %ld_ssbo_src_arr_0 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_0_1_0 %ld_ssbo_src_bc_0_1_1 %ld_ssbo_src_bc_0_1_2
    %ld_ssbo_src_arr_1 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_1_1_0 %ld_ssbo_src_bc_1_1_1 %ld_ssbo_src_bc_1_1_2
    %ld_ssbo_src_arr_2 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_2_1_0 %ld_ssbo_src_bc_2_1_1 %ld_ssbo_src_bc_2_1_2
     %ld_ssbo_src_ex_0 = OpCompositeExtract %f16 %ld_ssbo_src_bc_0_0 0
     %ld_ssbo_src_ex_1 = OpCompositeExtract %f16 %ld_ssbo_src_bc_1_0 0
     %ld_ssbo_src_ex_2 = OpCompositeExtract %f16 %ld_ssbo_src_bc_2_0 0
     %ld_ssbo_src_st_0 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_0 %ld_ssbo_src_arr_0
     %ld_ssbo_src_st_1 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_1 %ld_ssbo_src_arr_1
     %ld_ssbo_src_st_2 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_2 %ld_ssbo_src_arr_2
     %ld_ssbo_src_cons = OpCompositeConstruct %struct16arr3 %ld_ssbo_src_st_0 %ld_ssbo_src_st_1 %ld_ssbo_src_st_2
  %ld_ssbo_src_st_test = OpCompositeConstruct %st_test %ld_ssbo_src_cons
                       OpReturnValue %ld_ssbo_src_st_test
                      OpFunctionEnd
%st_fn_ssbo_dst = OpFunction %void None %void_f16_i32_fn
%st_fn_ssbo_dst_param1 = OpFunctionParameter %f16
%st_fn_ssbo_dst_param2 = OpFunctionParameter %i32
%st_fn_ssbo_dst_entry = OpLabel
%st_fn_ssbo_dst_and_low = OpBitwiseAnd %u32 %st_fn_ssbo_dst_param2 %c_u32_1
%st_fn_ssbo_dst_zero_vec = OpBitcast %v2f16 %c_u32_0
%st_fn_ssbo_dst_insert = OpVectorInsertDynamic %v2f16 %st_fn_ssbo_dst_zero_vec %st_fn_ssbo_dst_param1 %st_fn_ssbo_dst_and_low
%st_fn_ssbo_dst_odd = OpIEqual %bool %st_fn_ssbo_dst_and_low %c_u32_1
%st_fn_ssbo_dst_sel = OpSelect %u32 %st_fn_ssbo_dst_odd %c_u32_low_ones %c_u32_high_ones
%st_fn_ssbo_dst_cast = OpBitcast %u32 %st_fn_ssbo_dst_insert
%st_fn_ssbo_dst_or = OpBitwiseOr %u32 %st_fn_ssbo_dst_cast %st_fn_ssbo_dst_sel
%st_fn_ssbo_dst_conv = OpBitcast %u32 %st_fn_ssbo_dst_param2
%st_fn_ssbo_dst_div = OpUDiv %u32 %st_fn_ssbo_dst_conv %c_u32_2
%st_fn_ssbo_dst_gep = OpAccessChain %up_u32 %ssbo_dst %c_u32_0 %st_fn_ssbo_dst_div
%st_fn_ssbo_dst_and = OpAtomicAnd %u32 %st_fn_ssbo_dst_gep %c_u32_1 %c_u32_0 %st_fn_ssbo_dst_or
OpReturn
OpFunctionEnd

OpCapability Tessellation


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
%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param1 = OpFunctionParameter %v4f32
%label_testfun = OpLabel
OpReturnValue %param1
OpFunctionEnd

OpCapability Tessellation


OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %BP_main "main" %BP_out_color %BP_gl_InvocationID %BP_gl_PrimitiveID %BP_in_color %BP_gl_out %BP_gl_in %BP_gl_TessLevelOuter %BP_gl_TessLevelInner  
OpExecutionMode %BP_main OutputVertices 3



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
%test_code = OpFunction %v4f32 None %v4f32_v4f32_function
%param1 = OpFunctionParameter %v4f32
%label_testfun = OpLabel
OpReturnValue %param1
OpFunctionEnd

OpCapability Tessellation
OpCapability Float16


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

OpDecorate %SSBO_src BufferBlock
OpDecorate %SSBO_dst BufferBlock
OpDecorate %ra_f16 ArrayStride 4
OpDecorate %ra_st ArrayStride 4
OpDecorate %ssbo_src DescriptorSet 0
OpDecorate %ssbo_src Binding 0
OpDecorate %ssbo_dst DescriptorSet 0
OpDecorate %ssbo_dst Binding 1
OpMemberDecorate %SSBO_src 0 Offset 0
OpMemberDecorate %SSBO_dst 0 Offset 0
OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr3 ArrayStride 16
OpDecorate %f16arr3 ArrayStride 2
OpDecorate %v2f16arr5 ArrayStride 4
OpDecorate %v3f16arr5 ArrayStride 8
OpDecorate %v4f16arr3 ArrayStride 8
OpMemberDecorate %st_test 0 Offset 0

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
   %c_i32_ndp = OpConstant %i32 24
  %c_i32_hndp = OpSpecConstantOp %i32 SDiv %c_i32_ndp %c_i32_2
  %c_i32_size = OpConstant %i32 12
%c_u32_high_ones = OpConstant %u32 0xffff0000
 %c_u32_low_ones = OpConstant %u32 0x0000ffff
         %f16 = OpTypeFloat 16
       %v2f16 = OpTypeVector %f16 2
       %v3f16 = OpTypeVector %f16 3
       %v4f16 = OpTypeVector %f16 4
    %c_f16_na = OpConstant %f16 -1.0
  %c_v2f16_n1 = OpConstantComposite %v2f16 %c_f16_na %c_f16_na
     %c_u32_5 = OpConstant %u32 5
     %c_i32_5 = OpConstant %i32 5
     %c_i32_6 = OpConstant %i32 6
     %c_i32_7 = OpConstant %i32 7
     %c_i32_8 = OpConstant %i32 8
     %c_i32_9 = OpConstant %i32 9
    %c_i32_10 = OpConstant %i32 10
    %c_i32_11 = OpConstant %i32 11
%f16arr3      = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr5    = OpTypeArray %v2f16 %c_u32_5
%v3f16arr5    = OpTypeArray %v3f16 %c_u32_5
%v4f16arr3    = OpTypeArray %v4f16 %c_u32_3
%struct16     = OpTypeStruct %f16 %v2f16arr3
%struct16arr3 = OpTypeArray %struct16 %c_u32_3
%st_test      = OpTypeStruct %struct16arr3
      %ra_f16 = OpTypeArray %u32 %c_i32_hndp
       %ra_st = OpTypeArray %u32 %c_i32_size
      %up_u32 = OpTypePointer Uniform %u32
     %st_test_i32_fn = OpTypeFunction %st_test %i32
%void_st_test_i32_fn = OpTypeFunction %void %st_test %i32
         %f16_i32_fn = OpTypeFunction %f16 %i32
    %void_f16_i32_fn = OpTypeFunction %void %f16 %i32
       %v2f16_i32_fn = OpTypeFunction %v2f16 %i32
  %void_v2f16_i32_fn = OpTypeFunction %void %v2f16 %i32
       %fun_t = OpTypeFunction %f16 %st_test %i32
    %SSBO_src = OpTypeStruct %ra_st
    %SSBO_dst = OpTypeStruct %ra_f16
 %up_SSBO_src = OpTypePointer Uniform %SSBO_src
 %up_SSBO_dst = OpTypePointer Uniform %SSBO_dst
    %ssbo_src = OpVariable %up_SSBO_src Uniform
    %ssbo_dst = OpVariable %up_SSBO_dst Uniform


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
 %test_code = OpFunction %v4f32 None %v4f32_v4f32_function
     %param = OpFunctionParameter %v4f32
     %entry = OpLabel
         %i = OpVariable %fp_i32 Function
              OpStore %i %c_i32_0
  %will_run = OpFunctionCall %bool %isUniqueIdZero
              OpSelectionMerge %end_if None
              OpBranchConditional %will_run %run_test %end_if
  %run_test = OpLabel
              OpBranch %loop
      %loop = OpLabel
     %i_cmp = OpLoad %i32 %i
        %lt = OpSLessThan %bool %i_cmp %c_i32_ndp
              OpLoopMerge %merge %next None
              OpBranchConditional %lt %write %merge
     %write = OpLabel
       %ndx = OpLoad %i32 %i
   %val_src = OpFunctionCall %st_test %ld_ssbo_src %c_i32_0
   %val_dst = OpFunctionCall %f16 %sw_fun %val_src %ndx
    %dst_st = OpFunctionCall %void %st_fn_ssbo_dst %val_dst %ndx
              OpBranch %next
      %next = OpLabel
     %i_cur = OpLoad %i32 %i
     %i_new = OpIAdd %i32 %i_cur %c_i32_1
              OpStore %i %i_new
              OpBranch %loop
     %merge = OpLabel
              OpBranch %end_if
    %end_if = OpLabel
              OpReturnValue %param
              OpFunctionEnd
   %sw_fun = OpFunction %f16 None %fun_t
 %sw_param = OpFunctionParameter %st_test
%sw_paramn = OpFunctionParameter %i32
 %sw_entry = OpLabel
             OpSelectionMerge %switch_e None
             OpSwitch %sw_paramn %default 0 %case_0 2 %case_2 3 %case_3 4 %case_4 5 %case_5 6 %case_6 7 %case_7 8 %case_8 10 %case_10 11 %case_11 12 %case_12 13 %case_13 14 %case_14 15 %case_15 16 %case_16 18 %case_18 19 %case_19 20 %case_20 21 %case_21 22 %case_22 23 %case_23 
%case_0    = OpLabel
%val_ret_0 = OpCompositeExtract %f16 %sw_param 0 0 0
             OpReturnValue %val_ret_0
%case_2    = OpLabel
%val_ret_2 = OpCompositeExtract %f16 %sw_param 0 0 1 0 0
             OpReturnValue %val_ret_2
%case_3    = OpLabel
%val_ret_3 = OpCompositeExtract %f16 %sw_param 0 0 1 0 1
             OpReturnValue %val_ret_3
%case_4    = OpLabel
%val_ret_4 = OpCompositeExtract %f16 %sw_param 0 0 1 1 0
             OpReturnValue %val_ret_4
%case_5    = OpLabel
%val_ret_5 = OpCompositeExtract %f16 %sw_param 0 0 1 1 1
             OpReturnValue %val_ret_5
%case_6    = OpLabel
%val_ret_6 = OpCompositeExtract %f16 %sw_param 0 0 1 2 0
             OpReturnValue %val_ret_6
%case_7    = OpLabel
%val_ret_7 = OpCompositeExtract %f16 %sw_param 0 0 1 2 1
             OpReturnValue %val_ret_7
%case_8    = OpLabel
%val_ret_8 = OpCompositeExtract %f16 %sw_param 0 1 0
             OpReturnValue %val_ret_8
%case_10    = OpLabel
%val_ret_10 = OpCompositeExtract %f16 %sw_param 0 1 1 0 0
             OpReturnValue %val_ret_10
%case_11    = OpLabel
%val_ret_11 = OpCompositeExtract %f16 %sw_param 0 1 1 0 1
             OpReturnValue %val_ret_11
%case_12    = OpLabel
%val_ret_12 = OpCompositeExtract %f16 %sw_param 0 1 1 1 0
             OpReturnValue %val_ret_12
%case_13    = OpLabel
%val_ret_13 = OpCompositeExtract %f16 %sw_param 0 1 1 1 1
             OpReturnValue %val_ret_13
%case_14    = OpLabel
%val_ret_14 = OpCompositeExtract %f16 %sw_param 0 1 1 2 0
             OpReturnValue %val_ret_14
%case_15    = OpLabel
%val_ret_15 = OpCompositeExtract %f16 %sw_param 0 1 1 2 1
             OpReturnValue %val_ret_15
%case_16    = OpLabel
%val_ret_16 = OpCompositeExtract %f16 %sw_param 0 2 0
             OpReturnValue %val_ret_16
%case_18    = OpLabel
%val_ret_18 = OpCompositeExtract %f16 %sw_param 0 2 1 0 0
             OpReturnValue %val_ret_18
%case_19    = OpLabel
%val_ret_19 = OpCompositeExtract %f16 %sw_param 0 2 1 0 1
             OpReturnValue %val_ret_19
%case_20    = OpLabel
%val_ret_20 = OpCompositeExtract %f16 %sw_param 0 2 1 1 0
             OpReturnValue %val_ret_20
%case_21    = OpLabel
%val_ret_21 = OpCompositeExtract %f16 %sw_param 0 2 1 1 1
             OpReturnValue %val_ret_21
%case_22    = OpLabel
%val_ret_22 = OpCompositeExtract %f16 %sw_param 0 2 1 2 0
             OpReturnValue %val_ret_22
%case_23    = OpLabel
%val_ret_23 = OpCompositeExtract %f16 %sw_param 0 2 1 2 1
             OpReturnValue %val_ret_23
%default   = OpLabel
             OpReturnValue %c_f16_na
%switch_e  = OpLabel
             OpUnreachable
             OpFunctionEnd
          %ld_ssbo_src = OpFunction %st_test None %st_test_i32_fn
    %ld_ssbo_src_param = OpFunctionParameter %i32
    %ld_ssbo_src_entry = OpLabel
%ld_ssbo_src_gep_0_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_0
%ld_ssbo_src_gep_0_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_1
%ld_ssbo_src_gep_0_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_2
%ld_ssbo_src_gep_0_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_3
%ld_ssbo_src_gep_1_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_4
%ld_ssbo_src_gep_1_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_5
%ld_ssbo_src_gep_1_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_6
%ld_ssbo_src_gep_1_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_7
%ld_ssbo_src_gep_2_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_8
%ld_ssbo_src_gep_2_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_9
%ld_ssbo_src_gep_2_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_10
%ld_ssbo_src_gep_2_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_11
 %ld_ssbo_src_ld_0_0   = OpLoad %u32 %ld_ssbo_src_gep_0_0
 %ld_ssbo_src_ld_0_1_0 = OpLoad %u32 %ld_ssbo_src_gep_0_1_0
 %ld_ssbo_src_ld_0_1_1 = OpLoad %u32 %ld_ssbo_src_gep_0_1_1
 %ld_ssbo_src_ld_0_1_2 = OpLoad %u32 %ld_ssbo_src_gep_0_1_2
 %ld_ssbo_src_ld_1_0   = OpLoad %u32 %ld_ssbo_src_gep_1_0
 %ld_ssbo_src_ld_1_1_0 = OpLoad %u32 %ld_ssbo_src_gep_1_1_0
 %ld_ssbo_src_ld_1_1_1 = OpLoad %u32 %ld_ssbo_src_gep_1_1_1
 %ld_ssbo_src_ld_1_1_2 = OpLoad %u32 %ld_ssbo_src_gep_1_1_2
 %ld_ssbo_src_ld_2_0   = OpLoad %u32 %ld_ssbo_src_gep_2_0
 %ld_ssbo_src_ld_2_1_0 = OpLoad %u32 %ld_ssbo_src_gep_2_1_0
 %ld_ssbo_src_ld_2_1_1 = OpLoad %u32 %ld_ssbo_src_gep_2_1_1
 %ld_ssbo_src_ld_2_1_2 = OpLoad %u32 %ld_ssbo_src_gep_2_1_2
 %ld_ssbo_src_bc_0_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_0_0
 %ld_ssbo_src_bc_0_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_0
 %ld_ssbo_src_bc_0_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_1
 %ld_ssbo_src_bc_0_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_2
 %ld_ssbo_src_bc_1_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_1_0
 %ld_ssbo_src_bc_1_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_0
 %ld_ssbo_src_bc_1_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_1
 %ld_ssbo_src_bc_1_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_2
 %ld_ssbo_src_bc_2_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_2_0
 %ld_ssbo_src_bc_2_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_0
 %ld_ssbo_src_bc_2_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_1
 %ld_ssbo_src_bc_2_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_2
    %ld_ssbo_src_arr_0 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_0_1_0 %ld_ssbo_src_bc_0_1_1 %ld_ssbo_src_bc_0_1_2
    %ld_ssbo_src_arr_1 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_1_1_0 %ld_ssbo_src_bc_1_1_1 %ld_ssbo_src_bc_1_1_2
    %ld_ssbo_src_arr_2 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_2_1_0 %ld_ssbo_src_bc_2_1_1 %ld_ssbo_src_bc_2_1_2
     %ld_ssbo_src_ex_0 = OpCompositeExtract %f16 %ld_ssbo_src_bc_0_0 0
     %ld_ssbo_src_ex_1 = OpCompositeExtract %f16 %ld_ssbo_src_bc_1_0 0
     %ld_ssbo_src_ex_2 = OpCompositeExtract %f16 %ld_ssbo_src_bc_2_0 0
     %ld_ssbo_src_st_0 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_0 %ld_ssbo_src_arr_0
     %ld_ssbo_src_st_1 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_1 %ld_ssbo_src_arr_1
     %ld_ssbo_src_st_2 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_2 %ld_ssbo_src_arr_2
     %ld_ssbo_src_cons = OpCompositeConstruct %struct16arr3 %ld_ssbo_src_st_0 %ld_ssbo_src_st_1 %ld_ssbo_src_st_2
  %ld_ssbo_src_st_test = OpCompositeConstruct %st_test %ld_ssbo_src_cons
                       OpReturnValue %ld_ssbo_src_st_test
                      OpFunctionEnd
%st_fn_ssbo_dst = OpFunction %void None %void_f16_i32_fn
%st_fn_ssbo_dst_param1 = OpFunctionParameter %f16
%st_fn_ssbo_dst_param2 = OpFunctionParameter %i32
%st_fn_ssbo_dst_entry = OpLabel
%st_fn_ssbo_dst_and_low = OpBitwiseAnd %u32 %st_fn_ssbo_dst_param2 %c_u32_1
%st_fn_ssbo_dst_zero_vec = OpBitcast %v2f16 %c_u32_0
%st_fn_ssbo_dst_insert = OpVectorInsertDynamic %v2f16 %st_fn_ssbo_dst_zero_vec %st_fn_ssbo_dst_param1 %st_fn_ssbo_dst_and_low
%st_fn_ssbo_dst_odd = OpIEqual %bool %st_fn_ssbo_dst_and_low %c_u32_1
%st_fn_ssbo_dst_sel = OpSelect %u32 %st_fn_ssbo_dst_odd %c_u32_low_ones %c_u32_high_ones
%st_fn_ssbo_dst_cast = OpBitcast %u32 %st_fn_ssbo_dst_insert
%st_fn_ssbo_dst_or = OpBitwiseOr %u32 %st_fn_ssbo_dst_cast %st_fn_ssbo_dst_sel
%st_fn_ssbo_dst_conv = OpBitcast %u32 %st_fn_ssbo_dst_param2
%st_fn_ssbo_dst_div = OpUDiv %u32 %st_fn_ssbo_dst_conv %c_u32_2
%st_fn_ssbo_dst_gep = OpAccessChain %up_u32 %ssbo_dst %c_u32_0 %st_fn_ssbo_dst_div
%st_fn_ssbo_dst_and = OpAtomicAnd %u32 %st_fn_ssbo_dst_gep %c_u32_1 %c_u32_0 %st_fn_ssbo_dst_or
OpReturn
OpFunctionEnd

OpCapability Geometry
OpCapability Float16


OpMemoryModel Logical GLSL450
OpEntryPoint Geometry %BP_main "main" %BP_out_gl_position %BP_gl_PrimitiveID %BP_gl_in %BP_out_color %BP_in_color   
OpExecutionMode %BP_main Triangles
OpExecutionMode %BP_main Invocations 1
OpExecutionMode %BP_main OutputTriangleStrip
OpExecutionMode %BP_main OutputVertices 3



OpDecorate %BP_gl_PrimitiveID BuiltIn PrimitiveId
OpDecorate %BP_out_gl_position BuiltIn Position
OpMemberDecorate %BP_per_vertex_in 0 BuiltIn Position
OpMemberDecorate %BP_per_vertex_in 1 BuiltIn PointSize
OpMemberDecorate %BP_per_vertex_in 2 BuiltIn ClipDistance
OpMemberDecorate %BP_per_vertex_in 3 BuiltIn CullDistance
OpDecorate %BP_per_vertex_in Block
OpDecorate %BP_out_color Location 1
OpDecorate %BP_in_color Location 1

OpDecorate %SSBO_src BufferBlock
OpDecorate %SSBO_dst BufferBlock
OpDecorate %ra_f16 ArrayStride 4
OpDecorate %ra_st ArrayStride 4
OpDecorate %ssbo_src DescriptorSet 0
OpDecorate %ssbo_src Binding 0
OpDecorate %ssbo_dst DescriptorSet 0
OpDecorate %ssbo_dst Binding 1
OpMemberDecorate %SSBO_src 0 Offset 0
OpMemberDecorate %SSBO_dst 0 Offset 0
OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr3 ArrayStride 16
OpDecorate %f16arr3 ArrayStride 2
OpDecorate %v2f16arr5 ArrayStride 4
OpDecorate %v3f16arr5 ArrayStride 8
OpDecorate %v4f16arr3 ArrayStride 8
OpMemberDecorate %st_test 0 Offset 0

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
%BP_per_vertex_in = OpTypeStruct %v4f32 %f32 %a1f32 %a1f32
%BP_a3_per_vertex_in = OpTypeArray %BP_per_vertex_in %c_u32_3
%BP_ip_a3_per_vertex_in = OpTypePointer Input %BP_a3_per_vertex_in
%BP_pp_i32 = OpTypePointer Private %i32
%BP_pp_v4i32 = OpTypePointer Private %v4i32
%BP_gl_in = OpVariable %BP_ip_a3_per_vertex_in Input
%BP_out_color = OpVariable %op_v4f32 Output
%BP_in_color = OpVariable %ip_a3v4f32 Input
%BP_gl_PrimitiveID = OpVariable %ip_i32 Input
%BP_out_gl_position = OpVariable %op_v4f32 Output
%BP_vertexIdInCurrentPatch = OpVariable %BP_pp_v4i32 Private
   %c_i32_ndp = OpConstant %i32 24
  %c_i32_hndp = OpSpecConstantOp %i32 SDiv %c_i32_ndp %c_i32_2
  %c_i32_size = OpConstant %i32 12
%c_u32_high_ones = OpConstant %u32 0xffff0000
 %c_u32_low_ones = OpConstant %u32 0x0000ffff
         %f16 = OpTypeFloat 16
       %v2f16 = OpTypeVector %f16 2
       %v3f16 = OpTypeVector %f16 3
       %v4f16 = OpTypeVector %f16 4
    %c_f16_na = OpConstant %f16 -1.0
  %c_v2f16_n1 = OpConstantComposite %v2f16 %c_f16_na %c_f16_na
     %c_u32_5 = OpConstant %u32 5
     %c_i32_5 = OpConstant %i32 5
     %c_i32_6 = OpConstant %i32 6
     %c_i32_7 = OpConstant %i32 7
     %c_i32_8 = OpConstant %i32 8
     %c_i32_9 = OpConstant %i32 9
    %c_i32_10 = OpConstant %i32 10
    %c_i32_11 = OpConstant %i32 11
%f16arr3      = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr5    = OpTypeArray %v2f16 %c_u32_5
%v3f16arr5    = OpTypeArray %v3f16 %c_u32_5
%v4f16arr3    = OpTypeArray %v4f16 %c_u32_3
%struct16     = OpTypeStruct %f16 %v2f16arr3
%struct16arr3 = OpTypeArray %struct16 %c_u32_3
%st_test      = OpTypeStruct %struct16arr3
      %ra_f16 = OpTypeArray %u32 %c_i32_hndp
       %ra_st = OpTypeArray %u32 %c_i32_size
      %up_u32 = OpTypePointer Uniform %u32
     %st_test_i32_fn = OpTypeFunction %st_test %i32
%void_st_test_i32_fn = OpTypeFunction %void %st_test %i32
         %f16_i32_fn = OpTypeFunction %f16 %i32
    %void_f16_i32_fn = OpTypeFunction %void %f16 %i32
       %v2f16_i32_fn = OpTypeFunction %v2f16 %i32
  %void_v2f16_i32_fn = OpTypeFunction %void %v2f16 %i32
       %fun_t = OpTypeFunction %f16 %st_test %i32
    %SSBO_src = OpTypeStruct %ra_st
    %SSBO_dst = OpTypeStruct %ra_f16
 %up_SSBO_src = OpTypePointer Uniform %SSBO_src
 %up_SSBO_dst = OpTypePointer Uniform %SSBO_dst
    %ssbo_src = OpVariable %up_SSBO_src Uniform
    %ssbo_dst = OpVariable %up_SSBO_dst Uniform


%BP_main = OpFunction %void None %voidf
%BP_label = OpLabel


%BP_primitiveId = OpLoad %i32 %BP_gl_PrimitiveID
%BP_addr_vertexIdInCurrentPatch = OpAccessChain %BP_pp_i32 %BP_vertexIdInCurrentPatch %BP_primitiveId
%BP_gl_in_0_gl_position = OpAccessChain %ip_v4f32 %BP_gl_in %c_i32_0 %c_i32_0
%BP_gl_in_1_gl_position = OpAccessChain %ip_v4f32 %BP_gl_in %c_i32_1 %c_i32_0
%BP_gl_in_2_gl_position = OpAccessChain %ip_v4f32 %BP_gl_in %c_i32_2 %c_i32_0
%BP_in_position_0 = OpLoad %v4f32 %BP_gl_in_0_gl_position
%BP_in_position_1 = OpLoad %v4f32 %BP_gl_in_1_gl_position
%BP_in_position_2 = OpLoad %v4f32 %BP_gl_in_2_gl_position 
%BP_in_color_0_ptr = OpAccessChain %ip_v4f32 %BP_in_color %c_i32_0
%BP_in_color_1_ptr = OpAccessChain %ip_v4f32 %BP_in_color %c_i32_1
%BP_in_color_2_ptr = OpAccessChain %ip_v4f32 %BP_in_color %c_i32_2
%BP_in_color_0 = OpLoad %v4f32 %BP_in_color_0_ptr
%BP_in_color_1 = OpLoad %v4f32 %BP_in_color_1_ptr
%BP_in_color_2 = OpLoad %v4f32 %BP_in_color_2_ptr
OpStore %BP_addr_vertexIdInCurrentPatch %c_i32_0
%BP_transformed_in_color_0 = OpFunctionCall %v4f32 %test_code %BP_in_color_0
OpStore %BP_addr_vertexIdInCurrentPatch %c_i32_1
%BP_transformed_in_color_1 = OpFunctionCall %v4f32 %test_code %BP_in_color_1
OpStore %BP_addr_vertexIdInCurrentPatch %c_i32_2
%BP_transformed_in_color_2 = OpFunctionCall %v4f32 %test_code %BP_in_color_2
OpStore %BP_out_gl_position %BP_in_position_0
OpStore %BP_out_color %BP_transformed_in_color_0
OpEmitVertex
OpStore %BP_out_gl_position %BP_in_position_1
OpStore %BP_out_color %BP_transformed_in_color_1
OpEmitVertex
OpStore %BP_out_gl_position %BP_in_position_2
OpStore %BP_out_color %BP_transformed_in_color_2
OpEmitVertex
OpEndPrimitive
OpReturn
OpFunctionEnd

%isUniqueIdZero = OpFunction %bool None %bool_function
%getId_label = OpLabel
%primitive_id = OpLoad %i32 %BP_gl_PrimitiveID
%addr_vertexIdInCurrentPatch = OpAccessChain %BP_pp_i32 %BP_vertexIdInCurrentPatch %primitive_id
%vertexIdInCurrentPatch = OpLoad %i32 %addr_vertexIdInCurrentPatch
%is_primitive_0 = OpIEqual %bool %primitive_id %c_i32_0
%is_vertex_0 = OpIEqual %bool %vertexIdInCurrentPatch %c_i32_0
%is_unique_id_0 = OpLogicalAnd %bool %is_primitive_0 %is_vertex_0
OpReturnValue %is_unique_id_0
OpFunctionEnd
 %test_code = OpFunction %v4f32 None %v4f32_v4f32_function
     %param = OpFunctionParameter %v4f32
     %entry = OpLabel
         %i = OpVariable %fp_i32 Function
              OpStore %i %c_i32_0
  %will_run = OpFunctionCall %bool %isUniqueIdZero
              OpSelectionMerge %end_if None
              OpBranchConditional %will_run %run_test %end_if
  %run_test = OpLabel
              OpBranch %loop
      %loop = OpLabel
     %i_cmp = OpLoad %i32 %i
        %lt = OpSLessThan %bool %i_cmp %c_i32_ndp
              OpLoopMerge %merge %next None
              OpBranchConditional %lt %write %merge
     %write = OpLabel
       %ndx = OpLoad %i32 %i
   %val_src = OpFunctionCall %st_test %ld_ssbo_src %c_i32_0
   %val_dst = OpFunctionCall %f16 %sw_fun %val_src %ndx
    %dst_st = OpFunctionCall %void %st_fn_ssbo_dst %val_dst %ndx
              OpBranch %next
      %next = OpLabel
     %i_cur = OpLoad %i32 %i
     %i_new = OpIAdd %i32 %i_cur %c_i32_1
              OpStore %i %i_new
              OpBranch %loop
     %merge = OpLabel
              OpBranch %end_if
    %end_if = OpLabel
              OpReturnValue %param
              OpFunctionEnd
   %sw_fun = OpFunction %f16 None %fun_t
 %sw_param = OpFunctionParameter %st_test
%sw_paramn = OpFunctionParameter %i32
 %sw_entry = OpLabel
             OpSelectionMerge %switch_e None
             OpSwitch %sw_paramn %default 0 %case_0 2 %case_2 3 %case_3 4 %case_4 5 %case_5 6 %case_6 7 %case_7 8 %case_8 10 %case_10 11 %case_11 12 %case_12 13 %case_13 14 %case_14 15 %case_15 16 %case_16 18 %case_18 19 %case_19 20 %case_20 21 %case_21 22 %case_22 23 %case_23 
%case_0    = OpLabel
%val_ret_0 = OpCompositeExtract %f16 %sw_param 0 0 0
             OpReturnValue %val_ret_0
%case_2    = OpLabel
%val_ret_2 = OpCompositeExtract %f16 %sw_param 0 0 1 0 0
             OpReturnValue %val_ret_2
%case_3    = OpLabel
%val_ret_3 = OpCompositeExtract %f16 %sw_param 0 0 1 0 1
             OpReturnValue %val_ret_3
%case_4    = OpLabel
%val_ret_4 = OpCompositeExtract %f16 %sw_param 0 0 1 1 0
             OpReturnValue %val_ret_4
%case_5    = OpLabel
%val_ret_5 = OpCompositeExtract %f16 %sw_param 0 0 1 1 1
             OpReturnValue %val_ret_5
%case_6    = OpLabel
%val_ret_6 = OpCompositeExtract %f16 %sw_param 0 0 1 2 0
             OpReturnValue %val_ret_6
%case_7    = OpLabel
%val_ret_7 = OpCompositeExtract %f16 %sw_param 0 0 1 2 1
             OpReturnValue %val_ret_7
%case_8    = OpLabel
%val_ret_8 = OpCompositeExtract %f16 %sw_param 0 1 0
             OpReturnValue %val_ret_8
%case_10    = OpLabel
%val_ret_10 = OpCompositeExtract %f16 %sw_param 0 1 1 0 0
             OpReturnValue %val_ret_10
%case_11    = OpLabel
%val_ret_11 = OpCompositeExtract %f16 %sw_param 0 1 1 0 1
             OpReturnValue %val_ret_11
%case_12    = OpLabel
%val_ret_12 = OpCompositeExtract %f16 %sw_param 0 1 1 1 0
             OpReturnValue %val_ret_12
%case_13    = OpLabel
%val_ret_13 = OpCompositeExtract %f16 %sw_param 0 1 1 1 1
             OpReturnValue %val_ret_13
%case_14    = OpLabel
%val_ret_14 = OpCompositeExtract %f16 %sw_param 0 1 1 2 0
             OpReturnValue %val_ret_14
%case_15    = OpLabel
%val_ret_15 = OpCompositeExtract %f16 %sw_param 0 1 1 2 1
             OpReturnValue %val_ret_15
%case_16    = OpLabel
%val_ret_16 = OpCompositeExtract %f16 %sw_param 0 2 0
             OpReturnValue %val_ret_16
%case_18    = OpLabel
%val_ret_18 = OpCompositeExtract %f16 %sw_param 0 2 1 0 0
             OpReturnValue %val_ret_18
%case_19    = OpLabel
%val_ret_19 = OpCompositeExtract %f16 %sw_param 0 2 1 0 1
             OpReturnValue %val_ret_19
%case_20    = OpLabel
%val_ret_20 = OpCompositeExtract %f16 %sw_param 0 2 1 1 0
             OpReturnValue %val_ret_20
%case_21    = OpLabel
%val_ret_21 = OpCompositeExtract %f16 %sw_param 0 2 1 1 1
             OpReturnValue %val_ret_21
%case_22    = OpLabel
%val_ret_22 = OpCompositeExtract %f16 %sw_param 0 2 1 2 0
             OpReturnValue %val_ret_22
%case_23    = OpLabel
%val_ret_23 = OpCompositeExtract %f16 %sw_param 0 2 1 2 1
             OpReturnValue %val_ret_23
%default   = OpLabel
             OpReturnValue %c_f16_na
%switch_e  = OpLabel
             OpUnreachable
             OpFunctionEnd
          %ld_ssbo_src = OpFunction %st_test None %st_test_i32_fn
    %ld_ssbo_src_param = OpFunctionParameter %i32
    %ld_ssbo_src_entry = OpLabel
%ld_ssbo_src_gep_0_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_0
%ld_ssbo_src_gep_0_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_1
%ld_ssbo_src_gep_0_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_2
%ld_ssbo_src_gep_0_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_3
%ld_ssbo_src_gep_1_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_4
%ld_ssbo_src_gep_1_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_5
%ld_ssbo_src_gep_1_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_6
%ld_ssbo_src_gep_1_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_7
%ld_ssbo_src_gep_2_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_8
%ld_ssbo_src_gep_2_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_9
%ld_ssbo_src_gep_2_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_10
%ld_ssbo_src_gep_2_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_11
 %ld_ssbo_src_ld_0_0   = OpLoad %u32 %ld_ssbo_src_gep_0_0
 %ld_ssbo_src_ld_0_1_0 = OpLoad %u32 %ld_ssbo_src_gep_0_1_0
 %ld_ssbo_src_ld_0_1_1 = OpLoad %u32 %ld_ssbo_src_gep_0_1_1
 %ld_ssbo_src_ld_0_1_2 = OpLoad %u32 %ld_ssbo_src_gep_0_1_2
 %ld_ssbo_src_ld_1_0   = OpLoad %u32 %ld_ssbo_src_gep_1_0
 %ld_ssbo_src_ld_1_1_0 = OpLoad %u32 %ld_ssbo_src_gep_1_1_0
 %ld_ssbo_src_ld_1_1_1 = OpLoad %u32 %ld_ssbo_src_gep_1_1_1
 %ld_ssbo_src_ld_1_1_2 = OpLoad %u32 %ld_ssbo_src_gep_1_1_2
 %ld_ssbo_src_ld_2_0   = OpLoad %u32 %ld_ssbo_src_gep_2_0
 %ld_ssbo_src_ld_2_1_0 = OpLoad %u32 %ld_ssbo_src_gep_2_1_0
 %ld_ssbo_src_ld_2_1_1 = OpLoad %u32 %ld_ssbo_src_gep_2_1_1
 %ld_ssbo_src_ld_2_1_2 = OpLoad %u32 %ld_ssbo_src_gep_2_1_2
 %ld_ssbo_src_bc_0_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_0_0
 %ld_ssbo_src_bc_0_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_0
 %ld_ssbo_src_bc_0_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_1
 %ld_ssbo_src_bc_0_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_2
 %ld_ssbo_src_bc_1_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_1_0
 %ld_ssbo_src_bc_1_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_0
 %ld_ssbo_src_bc_1_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_1
 %ld_ssbo_src_bc_1_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_2
 %ld_ssbo_src_bc_2_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_2_0
 %ld_ssbo_src_bc_2_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_0
 %ld_ssbo_src_bc_2_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_1
 %ld_ssbo_src_bc_2_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_2
    %ld_ssbo_src_arr_0 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_0_1_0 %ld_ssbo_src_bc_0_1_1 %ld_ssbo_src_bc_0_1_2
    %ld_ssbo_src_arr_1 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_1_1_0 %ld_ssbo_src_bc_1_1_1 %ld_ssbo_src_bc_1_1_2
    %ld_ssbo_src_arr_2 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_2_1_0 %ld_ssbo_src_bc_2_1_1 %ld_ssbo_src_bc_2_1_2
     %ld_ssbo_src_ex_0 = OpCompositeExtract %f16 %ld_ssbo_src_bc_0_0 0
     %ld_ssbo_src_ex_1 = OpCompositeExtract %f16 %ld_ssbo_src_bc_1_0 0
     %ld_ssbo_src_ex_2 = OpCompositeExtract %f16 %ld_ssbo_src_bc_2_0 0
     %ld_ssbo_src_st_0 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_0 %ld_ssbo_src_arr_0
     %ld_ssbo_src_st_1 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_1 %ld_ssbo_src_arr_1
     %ld_ssbo_src_st_2 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_2 %ld_ssbo_src_arr_2
     %ld_ssbo_src_cons = OpCompositeConstruct %struct16arr3 %ld_ssbo_src_st_0 %ld_ssbo_src_st_1 %ld_ssbo_src_st_2
  %ld_ssbo_src_st_test = OpCompositeConstruct %st_test %ld_ssbo_src_cons
                       OpReturnValue %ld_ssbo_src_st_test
                      OpFunctionEnd
%st_fn_ssbo_dst = OpFunction %void None %void_f16_i32_fn
%st_fn_ssbo_dst_param1 = OpFunctionParameter %f16
%st_fn_ssbo_dst_param2 = OpFunctionParameter %i32
%st_fn_ssbo_dst_entry = OpLabel
%st_fn_ssbo_dst_and_low = OpBitwiseAnd %u32 %st_fn_ssbo_dst_param2 %c_u32_1
%st_fn_ssbo_dst_zero_vec = OpBitcast %v2f16 %c_u32_0
%st_fn_ssbo_dst_insert = OpVectorInsertDynamic %v2f16 %st_fn_ssbo_dst_zero_vec %st_fn_ssbo_dst_param1 %st_fn_ssbo_dst_and_low
%st_fn_ssbo_dst_odd = OpIEqual %bool %st_fn_ssbo_dst_and_low %c_u32_1
%st_fn_ssbo_dst_sel = OpSelect %u32 %st_fn_ssbo_dst_odd %c_u32_low_ones %c_u32_high_ones
%st_fn_ssbo_dst_cast = OpBitcast %u32 %st_fn_ssbo_dst_insert
%st_fn_ssbo_dst_or = OpBitwiseOr %u32 %st_fn_ssbo_dst_cast %st_fn_ssbo_dst_sel
%st_fn_ssbo_dst_conv = OpBitcast %u32 %st_fn_ssbo_dst_param2
%st_fn_ssbo_dst_div = OpUDiv %u32 %st_fn_ssbo_dst_conv %c_u32_2
%st_fn_ssbo_dst_gep = OpAccessChain %up_u32 %ssbo_dst %c_u32_0 %st_fn_ssbo_dst_div
%st_fn_ssbo_dst_and = OpAtomicAnd %u32 %st_fn_ssbo_dst_gep %c_u32_1 %c_u32_0 %st_fn_ssbo_dst_or
OpReturn
OpFunctionEnd

OpCapability Shader
OpCapability Float16


OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %SSBO_src BufferBlock
OpDecorate %SSBO_dst BufferBlock
OpDecorate %ra_f16 ArrayStride 4
OpDecorate %ra_st ArrayStride 4
OpDecorate %ssbo_src DescriptorSet 0
OpDecorate %ssbo_src Binding 0
OpDecorate %ssbo_dst DescriptorSet 0
OpDecorate %ssbo_dst Binding 1
OpMemberDecorate %SSBO_src 0 Offset 0
OpMemberDecorate %SSBO_dst 0 Offset 0
OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr3 ArrayStride 16
OpDecorate %f16arr3 ArrayStride 2
OpDecorate %v2f16arr5 ArrayStride 4
OpDecorate %v3f16arr5 ArrayStride 8
OpDecorate %v4f16arr3 ArrayStride 8
OpMemberDecorate %st_test 0 Offset 0

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
   %c_i32_ndp = OpConstant %i32 24
  %c_i32_hndp = OpSpecConstantOp %i32 SDiv %c_i32_ndp %c_i32_2
  %c_i32_size = OpConstant %i32 12
%c_u32_high_ones = OpConstant %u32 0xffff0000
 %c_u32_low_ones = OpConstant %u32 0x0000ffff
         %f16 = OpTypeFloat 16
       %v2f16 = OpTypeVector %f16 2
       %v3f16 = OpTypeVector %f16 3
       %v4f16 = OpTypeVector %f16 4
    %c_f16_na = OpConstant %f16 -1.0
  %c_v2f16_n1 = OpConstantComposite %v2f16 %c_f16_na %c_f16_na
     %c_u32_5 = OpConstant %u32 5
     %c_i32_5 = OpConstant %i32 5
     %c_i32_6 = OpConstant %i32 6
     %c_i32_7 = OpConstant %i32 7
     %c_i32_8 = OpConstant %i32 8
     %c_i32_9 = OpConstant %i32 9
    %c_i32_10 = OpConstant %i32 10
    %c_i32_11 = OpConstant %i32 11
%f16arr3      = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr5    = OpTypeArray %v2f16 %c_u32_5
%v3f16arr5    = OpTypeArray %v3f16 %c_u32_5
%v4f16arr3    = OpTypeArray %v4f16 %c_u32_3
%struct16     = OpTypeStruct %f16 %v2f16arr3
%struct16arr3 = OpTypeArray %struct16 %c_u32_3
%st_test      = OpTypeStruct %struct16arr3
      %ra_f16 = OpTypeArray %u32 %c_i32_hndp
       %ra_st = OpTypeArray %u32 %c_i32_size
      %up_u32 = OpTypePointer Uniform %u32
     %st_test_i32_fn = OpTypeFunction %st_test %i32
%void_st_test_i32_fn = OpTypeFunction %void %st_test %i32
         %f16_i32_fn = OpTypeFunction %f16 %i32
    %void_f16_i32_fn = OpTypeFunction %void %f16 %i32
       %v2f16_i32_fn = OpTypeFunction %v2f16 %i32
  %void_v2f16_i32_fn = OpTypeFunction %void %v2f16 %i32
       %fun_t = OpTypeFunction %f16 %st_test %i32
    %SSBO_src = OpTypeStruct %ra_st
    %SSBO_dst = OpTypeStruct %ra_f16
 %up_SSBO_src = OpTypePointer Uniform %SSBO_src
 %up_SSBO_dst = OpTypePointer Uniform %SSBO_dst
    %ssbo_src = OpVariable %up_SSBO_src Uniform
    %ssbo_dst = OpVariable %up_SSBO_dst Uniform


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
         %i = OpVariable %fp_i32 Function
              OpStore %i %c_i32_0
  %will_run = OpFunctionCall %bool %isUniqueIdZero
              OpSelectionMerge %end_if None
              OpBranchConditional %will_run %run_test %end_if
  %run_test = OpLabel
              OpBranch %loop
      %loop = OpLabel
     %i_cmp = OpLoad %i32 %i
        %lt = OpSLessThan %bool %i_cmp %c_i32_ndp
              OpLoopMerge %merge %next None
              OpBranchConditional %lt %write %merge
     %write = OpLabel
       %ndx = OpLoad %i32 %i
   %val_src = OpFunctionCall %st_test %ld_ssbo_src %c_i32_0
   %val_dst = OpFunctionCall %f16 %sw_fun %val_src %ndx
    %dst_st = OpFunctionCall %void %st_fn_ssbo_dst %val_dst %ndx
              OpBranch %next
      %next = OpLabel
     %i_cur = OpLoad %i32 %i
     %i_new = OpIAdd %i32 %i_cur %c_i32_1
              OpStore %i %i_new
              OpBranch %loop
     %merge = OpLabel
              OpBranch %end_if
    %end_if = OpLabel
              OpReturnValue %param
              OpFunctionEnd
   %sw_fun = OpFunction %f16 None %fun_t
 %sw_param = OpFunctionParameter %st_test
%sw_paramn = OpFunctionParameter %i32
 %sw_entry = OpLabel
             OpSelectionMerge %switch_e None
             OpSwitch %sw_paramn %default 0 %case_0 2 %case_2 3 %case_3 4 %case_4 5 %case_5 6 %case_6 7 %case_7 8 %case_8 10 %case_10 11 %case_11 12 %case_12 13 %case_13 14 %case_14 15 %case_15 16 %case_16 18 %case_18 19 %case_19 20 %case_20 21 %case_21 22 %case_22 23 %case_23 
%case_0    = OpLabel
%val_ret_0 = OpCompositeExtract %f16 %sw_param 0 0 0
             OpReturnValue %val_ret_0
%case_2    = OpLabel
%val_ret_2 = OpCompositeExtract %f16 %sw_param 0 0 1 0 0
             OpReturnValue %val_ret_2
%case_3    = OpLabel
%val_ret_3 = OpCompositeExtract %f16 %sw_param 0 0 1 0 1
             OpReturnValue %val_ret_3
%case_4    = OpLabel
%val_ret_4 = OpCompositeExtract %f16 %sw_param 0 0 1 1 0
             OpReturnValue %val_ret_4
%case_5    = OpLabel
%val_ret_5 = OpCompositeExtract %f16 %sw_param 0 0 1 1 1
             OpReturnValue %val_ret_5
%case_6    = OpLabel
%val_ret_6 = OpCompositeExtract %f16 %sw_param 0 0 1 2 0
             OpReturnValue %val_ret_6
%case_7    = OpLabel
%val_ret_7 = OpCompositeExtract %f16 %sw_param 0 0 1 2 1
             OpReturnValue %val_ret_7
%case_8    = OpLabel
%val_ret_8 = OpCompositeExtract %f16 %sw_param 0 1 0
             OpReturnValue %val_ret_8
%case_10    = OpLabel
%val_ret_10 = OpCompositeExtract %f16 %sw_param 0 1 1 0 0
             OpReturnValue %val_ret_10
%case_11    = OpLabel
%val_ret_11 = OpCompositeExtract %f16 %sw_param 0 1 1 0 1
             OpReturnValue %val_ret_11
%case_12    = OpLabel
%val_ret_12 = OpCompositeExtract %f16 %sw_param 0 1 1 1 0
             OpReturnValue %val_ret_12
%case_13    = OpLabel
%val_ret_13 = OpCompositeExtract %f16 %sw_param 0 1 1 1 1
             OpReturnValue %val_ret_13
%case_14    = OpLabel
%val_ret_14 = OpCompositeExtract %f16 %sw_param 0 1 1 2 0
             OpReturnValue %val_ret_14
%case_15    = OpLabel
%val_ret_15 = OpCompositeExtract %f16 %sw_param 0 1 1 2 1
             OpReturnValue %val_ret_15
%case_16    = OpLabel
%val_ret_16 = OpCompositeExtract %f16 %sw_param 0 2 0
             OpReturnValue %val_ret_16
%case_18    = OpLabel
%val_ret_18 = OpCompositeExtract %f16 %sw_param 0 2 1 0 0
             OpReturnValue %val_ret_18
%case_19    = OpLabel
%val_ret_19 = OpCompositeExtract %f16 %sw_param 0 2 1 0 1
             OpReturnValue %val_ret_19
%case_20    = OpLabel
%val_ret_20 = OpCompositeExtract %f16 %sw_param 0 2 1 1 0
             OpReturnValue %val_ret_20
%case_21    = OpLabel
%val_ret_21 = OpCompositeExtract %f16 %sw_param 0 2 1 1 1
             OpReturnValue %val_ret_21
%case_22    = OpLabel
%val_ret_22 = OpCompositeExtract %f16 %sw_param 0 2 1 2 0
             OpReturnValue %val_ret_22
%case_23    = OpLabel
%val_ret_23 = OpCompositeExtract %f16 %sw_param 0 2 1 2 1
             OpReturnValue %val_ret_23
%default   = OpLabel
             OpReturnValue %c_f16_na
%switch_e  = OpLabel
             OpUnreachable
             OpFunctionEnd
          %ld_ssbo_src = OpFunction %st_test None %st_test_i32_fn
    %ld_ssbo_src_param = OpFunctionParameter %i32
    %ld_ssbo_src_entry = OpLabel
%ld_ssbo_src_gep_0_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_0
%ld_ssbo_src_gep_0_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_1
%ld_ssbo_src_gep_0_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_2
%ld_ssbo_src_gep_0_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_3
%ld_ssbo_src_gep_1_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_4
%ld_ssbo_src_gep_1_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_5
%ld_ssbo_src_gep_1_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_6
%ld_ssbo_src_gep_1_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_7
%ld_ssbo_src_gep_2_0   = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_8
%ld_ssbo_src_gep_2_1_0 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_9
%ld_ssbo_src_gep_2_1_1 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_10
%ld_ssbo_src_gep_2_1_2 = OpAccessChain %up_u32 %ssbo_src %c_i32_0 %c_i32_11
 %ld_ssbo_src_ld_0_0   = OpLoad %u32 %ld_ssbo_src_gep_0_0
 %ld_ssbo_src_ld_0_1_0 = OpLoad %u32 %ld_ssbo_src_gep_0_1_0
 %ld_ssbo_src_ld_0_1_1 = OpLoad %u32 %ld_ssbo_src_gep_0_1_1
 %ld_ssbo_src_ld_0_1_2 = OpLoad %u32 %ld_ssbo_src_gep_0_1_2
 %ld_ssbo_src_ld_1_0   = OpLoad %u32 %ld_ssbo_src_gep_1_0
 %ld_ssbo_src_ld_1_1_0 = OpLoad %u32 %ld_ssbo_src_gep_1_1_0
 %ld_ssbo_src_ld_1_1_1 = OpLoad %u32 %ld_ssbo_src_gep_1_1_1
 %ld_ssbo_src_ld_1_1_2 = OpLoad %u32 %ld_ssbo_src_gep_1_1_2
 %ld_ssbo_src_ld_2_0   = OpLoad %u32 %ld_ssbo_src_gep_2_0
 %ld_ssbo_src_ld_2_1_0 = OpLoad %u32 %ld_ssbo_src_gep_2_1_0
 %ld_ssbo_src_ld_2_1_1 = OpLoad %u32 %ld_ssbo_src_gep_2_1_1
 %ld_ssbo_src_ld_2_1_2 = OpLoad %u32 %ld_ssbo_src_gep_2_1_2
 %ld_ssbo_src_bc_0_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_0_0
 %ld_ssbo_src_bc_0_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_0
 %ld_ssbo_src_bc_0_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_1
 %ld_ssbo_src_bc_0_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_0_1_2
 %ld_ssbo_src_bc_1_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_1_0
 %ld_ssbo_src_bc_1_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_0
 %ld_ssbo_src_bc_1_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_1
 %ld_ssbo_src_bc_1_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_1_1_2
 %ld_ssbo_src_bc_2_0   = OpBitcast %v2f16 %ld_ssbo_src_ld_2_0
 %ld_ssbo_src_bc_2_1_0 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_0
 %ld_ssbo_src_bc_2_1_1 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_1
 %ld_ssbo_src_bc_2_1_2 = OpBitcast %v2f16 %ld_ssbo_src_ld_2_1_2
    %ld_ssbo_src_arr_0 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_0_1_0 %ld_ssbo_src_bc_0_1_1 %ld_ssbo_src_bc_0_1_2
    %ld_ssbo_src_arr_1 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_1_1_0 %ld_ssbo_src_bc_1_1_1 %ld_ssbo_src_bc_1_1_2
    %ld_ssbo_src_arr_2 = OpCompositeConstruct %v2f16arr3 %ld_ssbo_src_bc_2_1_0 %ld_ssbo_src_bc_2_1_1 %ld_ssbo_src_bc_2_1_2
     %ld_ssbo_src_ex_0 = OpCompositeExtract %f16 %ld_ssbo_src_bc_0_0 0
     %ld_ssbo_src_ex_1 = OpCompositeExtract %f16 %ld_ssbo_src_bc_1_0 0
     %ld_ssbo_src_ex_2 = OpCompositeExtract %f16 %ld_ssbo_src_bc_2_0 0
     %ld_ssbo_src_st_0 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_0 %ld_ssbo_src_arr_0
     %ld_ssbo_src_st_1 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_1 %ld_ssbo_src_arr_1
     %ld_ssbo_src_st_2 = OpCompositeConstruct %struct16 %ld_ssbo_src_ex_2 %ld_ssbo_src_arr_2
     %ld_ssbo_src_cons = OpCompositeConstruct %struct16arr3 %ld_ssbo_src_st_0 %ld_ssbo_src_st_1 %ld_ssbo_src_st_2
  %ld_ssbo_src_st_test = OpCompositeConstruct %st_test %ld_ssbo_src_cons
                       OpReturnValue %ld_ssbo_src_st_test
                      OpFunctionEnd
%st_fn_ssbo_dst = OpFunction %void None %void_f16_i32_fn
%st_fn_ssbo_dst_param1 = OpFunctionParameter %f16
%st_fn_ssbo_dst_param2 = OpFunctionParameter %i32
%st_fn_ssbo_dst_entry = OpLabel
%st_fn_ssbo_dst_and_low = OpBitwiseAnd %u32 %st_fn_ssbo_dst_param2 %c_u32_1
%st_fn_ssbo_dst_zero_vec = OpBitcast %v2f16 %c_u32_0
%st_fn_ssbo_dst_insert = OpVectorInsertDynamic %v2f16 %st_fn_ssbo_dst_zero_vec %st_fn_ssbo_dst_param1 %st_fn_ssbo_dst_and_low
%st_fn_ssbo_dst_odd = OpIEqual %bool %st_fn_ssbo_dst_and_low %c_u32_1
%st_fn_ssbo_dst_sel = OpSelect %u32 %st_fn_ssbo_dst_odd %c_u32_low_ones %c_u32_high_ones
%st_fn_ssbo_dst_cast = OpBitcast %u32 %st_fn_ssbo_dst_insert
%st_fn_ssbo_dst_or = OpBitwiseOr %u32 %st_fn_ssbo_dst_cast %st_fn_ssbo_dst_sel
%st_fn_ssbo_dst_conv = OpBitcast %u32 %st_fn_ssbo_dst_param2
%st_fn_ssbo_dst_div = OpUDiv %u32 %st_fn_ssbo_dst_conv %c_u32_2
%st_fn_ssbo_dst_gep = OpAccessChain %up_u32 %ssbo_dst %c_u32_0 %st_fn_ssbo_dst_div
%st_fn_ssbo_dst_and = OpAtomicAnd %u32 %st_fn_ssbo_dst_gep %c_u32_1 %c_u32_0 %st_fn_ssbo_dst_or
OpReturn
OpFunctionEnd

