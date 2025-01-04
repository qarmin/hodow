OpCapability Shader
OpCapability StorageUniformBufferBlock16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
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

OpCapability Tessellation
OpCapability StorageUniformBufferBlock16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1



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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
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
OpCapability StorageUniformBufferBlock16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

OpCapability Geometry
OpCapability StorageUniformBufferBlock16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

OpCapability Shader
OpCapability StorageUniformBufferBlock16

OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

OpCapability Shader
OpCapability StorageUniform16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 16
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 16
OpDecorate %struct16arr11 ArrayStride 64
OpDecorate %f16arr3       ArrayStride 16
OpDecorate %v2f16arr11    ArrayStride 16
OpDecorate %v3f16arr11    ArrayStride 16
OpDecorate %v4f16arr3     ArrayStride 16
OpDecorate %f16StructArr7 ArrayStride 1200

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 32
OpMemberDecorate %f16Struct 5 Offset 80
OpMemberDecorate %f16Struct 6 Offset 784
OpMemberDecorate %f16Struct 7 Offset 960
OpMemberDecorate %f16Struct 8 Offset 976
OpMemberDecorate %f16Struct 9 Offset 1152

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

OpCapability Tessellation
OpCapability StorageUniform16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 16
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 16
OpDecorate %struct16arr11 ArrayStride 64
OpDecorate %f16arr3       ArrayStride 16
OpDecorate %v2f16arr11    ArrayStride 16
OpDecorate %v3f16arr11    ArrayStride 16
OpDecorate %v4f16arr3     ArrayStride 16
OpDecorate %f16StructArr7 ArrayStride 1200

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 32
OpMemberDecorate %f16Struct 5 Offset 80
OpMemberDecorate %f16Struct 6 Offset 784
OpMemberDecorate %f16Struct 7 Offset 960
OpMemberDecorate %f16Struct 8 Offset 976
OpMemberDecorate %f16Struct 9 Offset 1152

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1



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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

OpCapability Tessellation
OpCapability StorageUniform16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 16
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 16
OpDecorate %struct16arr11 ArrayStride 64
OpDecorate %f16arr3       ArrayStride 16
OpDecorate %v2f16arr11    ArrayStride 16
OpDecorate %v3f16arr11    ArrayStride 16
OpDecorate %v4f16arr3     ArrayStride 16
OpDecorate %f16StructArr7 ArrayStride 1200

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 32
OpMemberDecorate %f16Struct 5 Offset 80
OpMemberDecorate %f16Struct 6 Offset 784
OpMemberDecorate %f16Struct 7 Offset 960
OpMemberDecorate %f16Struct 8 Offset 976
OpMemberDecorate %f16Struct 9 Offset 1152

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

OpCapability Geometry
OpCapability StorageUniform16

OpExtension "SPV_KHR_16bit_storage"
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

OpDecorate %v2f16arr3 ArrayStride 16
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 16
OpDecorate %struct16arr11 ArrayStride 64
OpDecorate %f16arr3       ArrayStride 16
OpDecorate %v2f16arr11    ArrayStride 16
OpDecorate %v3f16arr11    ArrayStride 16
OpDecorate %v4f16arr3     ArrayStride 16
OpDecorate %f16StructArr7 ArrayStride 1200

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 32
OpMemberDecorate %f16Struct 5 Offset 80
OpMemberDecorate %f16Struct 6 Offset 784
OpMemberDecorate %f16Struct 7 Offset 960
OpMemberDecorate %f16Struct 8 Offset 976
OpMemberDecorate %f16Struct 9 Offset 1152

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

OpCapability Shader
OpCapability StorageUniform16

OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %v2f16arr3 ArrayStride 16
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 16
OpDecorate %struct16arr11 ArrayStride 64
OpDecorate %f16arr3       ArrayStride 16
OpDecorate %v2f16arr11    ArrayStride 16
OpDecorate %v3f16arr11    ArrayStride 16
OpDecorate %v4f16arr3     ArrayStride 16
OpDecorate %f16StructArr7 ArrayStride 1200

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 32
OpMemberDecorate %f16Struct 5 Offset 80
OpMemberDecorate %f16Struct 6 Offset 784
OpMemberDecorate %f16Struct 7 Offset 960
OpMemberDecorate %f16Struct 8 Offset 976
OpMemberDecorate %f16Struct 9 Offset 1152

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1


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

%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform



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
%label     = OpLabel
%loopNdx    = OpVariable %fp_i32 Function
%insideLoopNdx = OpVariable %fp_i32 Function
OpStore %loopNdx %zero
OpBranch %loop
%loop = OpLabel
OpLoopMerge %merge %13 None
OpBranch %14
%14 = OpLabel
%valLoopNdx = OpLoad %i32 %loopNdx
%18 = OpSLessThan %bool %valLoopNdx %c_i32_7
OpBranchConditional %18 %11 %merge
%11 = OpLabel

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4f32dst %val_v4f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %f32dst2 %val2_f32

OpStore %insideLoopNdx %zero
OpBranch %loopInside
%loopInside = OpLabel
OpLoopMerge %92 %93 None
OpBranch %94
%94 = OpLabel
%valInsideLoopNdx = OpLoad %i32 %insideLoopNdx
%96 = OpSLessThan %bool %valInsideLoopNdx %c_i32_11
OpBranchConditional %96 %91 %92

%91 = OpLabel

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2f32dst2 %val2_v2f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3f32dst2 %val2_v3f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel

OpBranch %93
%93 = OpLabel
%132 = OpLoad %i32 %insideLoopNdx
%133 = OpIAdd %i32 %132 %c_i32_1
OpStore %insideLoopNdx %133
OpBranch %loopInside

%92 = OpLabel
OpBranch %13
%13 = OpLabel
%134 = OpLoad %i32 %loopNdx
%135 = OpIAdd %i32 %134 %c_i32_1
OpStore %loopNdx %135
OpBranch %loop
%merge = OpLabel
         OpReturnValue %param
         OpFunctionEnd

