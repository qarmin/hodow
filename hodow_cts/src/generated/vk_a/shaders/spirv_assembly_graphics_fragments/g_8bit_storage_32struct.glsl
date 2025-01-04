OpCapability Shader
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %i32
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v3i32ptr = OpTypePointer StorageBuffer %v3i32
%v4i32ptr = OpTypePointer StorageBuffer %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %i32
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v3i32ptr = OpTypePointer StorageBuffer %v3i32
%v4i32ptr = OpTypePointer StorageBuffer %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %i32
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v3i32ptr = OpTypePointer StorageBuffer %v3i32
%v4i32ptr = OpTypePointer StorageBuffer %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %i32
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v3i32ptr = OpTypePointer StorageBuffer %v3i32
%v4i32ptr = OpTypePointer StorageBuffer %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %i32
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v3i32ptr = OpTypePointer StorageBuffer %v3i32
%v4i32ptr = OpTypePointer StorageBuffer %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %u32
%v2i32ptr = OpTypePointer StorageBuffer %v2u32
%v3i32ptr = OpTypePointer StorageBuffer %v3u32
%v4i32ptr = OpTypePointer StorageBuffer %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %u32
%v2i32ptr = OpTypePointer StorageBuffer %v2u32
%v3i32ptr = OpTypePointer StorageBuffer %v3u32
%v4i32ptr = OpTypePointer StorageBuffer %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %u32
%v2i32ptr = OpTypePointer StorageBuffer %v2u32
%v3i32ptr = OpTypePointer StorageBuffer %v3u32
%v4i32ptr = OpTypePointer StorageBuffer %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %u32
%v2i32ptr = OpTypePointer StorageBuffer %v2u32
%v3i32ptr = OpTypePointer StorageBuffer %v3u32
%v4i32ptr = OpTypePointer StorageBuffer %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer StorageBuffer %u32
%v2i32ptr = OpTypePointer StorageBuffer %v2u32
%v3i32ptr = OpTypePointer StorageBuffer %v3u32
%v4i32ptr = OpTypePointer StorageBuffer %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %i32
%v2i32ptr = OpTypePointer Uniform %v2i32
%v3i32ptr = OpTypePointer Uniform %v3i32
%v4i32ptr = OpTypePointer Uniform %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %i32
%v2i32ptr = OpTypePointer Uniform %v2i32
%v3i32ptr = OpTypePointer Uniform %v3i32
%v4i32ptr = OpTypePointer Uniform %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %i32
%v2i32ptr = OpTypePointer Uniform %v2i32
%v3i32ptr = OpTypePointer Uniform %v3i32
%v4i32ptr = OpTypePointer Uniform %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %i32
%v2i32ptr = OpTypePointer Uniform %v2i32
%v3i32ptr = OpTypePointer Uniform %v3i32
%v4i32ptr = OpTypePointer Uniform %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 1
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %i32
%v2i32ptr = OpTypePointer Uniform %v2i32
%v3i32ptr = OpTypePointer Uniform %v3i32
%v4i32ptr = OpTypePointer Uniform %v4i32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8  = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0    = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1    = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2    = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8  = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8  = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8  = OpSConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8  = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %u32
%v2i32ptr = OpTypePointer Uniform %v2u32
%v3i32ptr = OpTypePointer Uniform %v3u32
%v4i32ptr = OpTypePointer Uniform %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %u32
%v2i32ptr = OpTypePointer Uniform %v2u32
%v3i32ptr = OpTypePointer Uniform %v3u32
%v4i32ptr = OpTypePointer Uniform %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %u32
%v2i32ptr = OpTypePointer Uniform %v2u32
%v3i32ptr = OpTypePointer Uniform %v3u32
%v4i32ptr = OpTypePointer Uniform %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

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

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %u32
%v2i32ptr = OpTypePointer Uniform %v2u32
%v3i32ptr = OpTypePointer Uniform %v3u32
%v4i32ptr = OpTypePointer Uniform %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
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

%i8      = OpTypeInt 8 0
%v2i8    = OpTypeVector %i8 2
%v3i8    = OpTypeVector %i8 3
%v4i8    = OpTypeVector %i8 4
%i8ptr   = OpTypePointer StorageBuffer %i8
%v2i8ptr = OpTypePointer StorageBuffer %v2i8
%v3i8ptr = OpTypePointer StorageBuffer %v3i8
%v4i8ptr = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %u32
%v2i32ptr = OpTypePointer Uniform %v2u32
%v3i32ptr = OpTypePointer Uniform %v3u32
%v4i32ptr = OpTypePointer Uniform %v4u32

%zero = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_11 = OpConstant %i32 11

%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3    = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %u32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2u32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2u32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3u32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4u32 %c_u32_3
%struct32      = OpTypeStruct %u32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %u32 %v2u32 %v3u32 %v4u32 %i32arr3 %struct32arr11 %v2i32arr11 %u32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer



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

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %zero
%val_i32 = OpLoad %u32 %i32src
%val_i8 = OpUConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_1
%val_v2i32 = OpLoad %v2u32 %v2i32src
%val_v2i8 = OpUConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_2
%val_v3i32 = OpLoad %v3u32 %v3i32src
%val_v3i8 = OpUConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_3
%val_v4i32 = OpLoad %v4u32 %v4i32src
%val_v4i8 = OpUConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_3
OpStore %v4i8dst %val_v4i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_7
%val2_i32 = OpLoad %u32 %i32src2
%val2_i8 = OpUConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_7
OpStore %i8dst2 %val2_i8

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

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
%Sval_i32 = OpLoad %u32 %Si32src
%Sval_i8  = OpUConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
%Sv2i32_0   = OpLoad %v2u32 %Sv2i32src0
%Sv2i8_0    = OpUConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
%Sv2i32_1   = OpLoad %v2u32 %Sv2i32src1
%Sv2i8_1    = OpUConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2 = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
%Sv2i32_2   = OpLoad %v2u32 %Sv2i32src2
%Sv2i8_2    = OpUConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2 = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_5 %valInsideLoopNdx %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
%val2_v2i32 = OpLoad %v2u32 %v2i32src2
%val2_v2i8  = OpUConvert %v2i8 %val2_v2i32
%v2i8dst2   = OpAccessChain %v2i8ptr %ssboOUT %zero %valLoopNdx %c_i32_6 %valInsideLoopNdx
OpStore %v2i8dst2 %val2_v2i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
%val2_v3i32 = OpLoad %v3u32 %v3i32src2
%val2_v3i8  = OpUConvert %v3i8 %val2_v3i32
%v3i8dst2   = OpAccessChain %v3i8ptr %ssboOUT %zero %valLoopNdx %c_i32_8 %valInsideLoopNdx
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %valInsideLoopNdx %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  %val3_i32 = OpLoad %u32 %i32src3
  %val3_i8  = OpUConvert %i8 %val3_i32
  %i8dst3   = OpAccessChain %i8ptr %ssboOUT %zero %valLoopNdx %c_i32_4 %valInsideLoopNdx
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  %val2_v4i32 = OpLoad %v4u32 %v4i32src2
  %val2_v4i8  = OpUConvert %v4i8 %val2_v4i32
  %v4i8dst2   = OpAccessChain %v4i8ptr %ssboOUT %zero %valLoopNdx %c_i32_9 %valInsideLoopNdx
  OpStore %v4i8dst2 %val2_v4i8
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

