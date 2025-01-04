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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 2
OpDecorate %b32NestedArr11In  ArrayStride 4
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 8
OpMemberDecorate %sNestedIn 3 Offset 32
OpDecorate %sNestedArr11In ArrayStride 76

OpDecorate %sb8Arr11In ArrayStride 1
OpDecorate %sb32Arr11In ArrayStride 4
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 916
OpMemberDecorate %structIn 10 Offset 928
OpDecorate %structArr7In ArrayStride 976

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer StorageBuffer %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN StorageBuffer

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8outPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8outPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 2
OpDecorate %b32NestedArr11In  ArrayStride 4
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 8
OpMemberDecorate %sNestedIn 3 Offset 32
OpDecorate %sNestedArr11In ArrayStride 76

OpDecorate %sb8Arr11In ArrayStride 1
OpDecorate %sb32Arr11In ArrayStride 4
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 916
OpMemberDecorate %structIn 10 Offset 928
OpDecorate %structArr7In ArrayStride 976

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer StorageBuffer %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN StorageBuffer

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8outPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8outPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 2
OpDecorate %b32NestedArr11In  ArrayStride 4
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 8
OpMemberDecorate %sNestedIn 3 Offset 32
OpDecorate %sNestedArr11In ArrayStride 76

OpDecorate %sb8Arr11In ArrayStride 1
OpDecorate %sb32Arr11In ArrayStride 4
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 916
OpMemberDecorate %structIn 10 Offset 928
OpDecorate %structArr7In ArrayStride 976

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer StorageBuffer %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN StorageBuffer

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8outPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8outPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 2
OpDecorate %b32NestedArr11In  ArrayStride 4
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 8
OpMemberDecorate %sNestedIn 3 Offset 32
OpDecorate %sNestedArr11In ArrayStride 76

OpDecorate %sb8Arr11In ArrayStride 1
OpDecorate %sb32Arr11In ArrayStride 4
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 916
OpMemberDecorate %structIn 10 Offset 928
OpDecorate %structArr7In ArrayStride 976

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer StorageBuffer %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN StorageBuffer

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8outPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8outPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 2
OpDecorate %b32NestedArr11In  ArrayStride 4
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 8
OpMemberDecorate %sNestedIn 3 Offset 32
OpDecorate %sNestedArr11In ArrayStride 76

OpDecorate %sb8Arr11In ArrayStride 1
OpDecorate %sb32Arr11In ArrayStride 4
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 916
OpMemberDecorate %structIn 10 Offset 928
OpDecorate %structArr7In ArrayStride 976

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer StorageBuffer %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN StorageBuffer

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8outPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8outPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
OpReturnValue %param
OpFunctionEnd

OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability UniformAndStorageBuffer8BitAccess

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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 16
OpDecorate %b32NestedArr11In ArrayStride 16
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 16
OpMemberDecorate %sNestedIn 3 Offset 192
OpDecorate %sNestedArr11In ArrayStride 368

OpDecorate %sb8Arr11In ArrayStride 16
OpDecorate %sb32Arr11In ArrayStride 16
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 4128
OpMemberDecorate %structIn 10 Offset 4304
OpDecorate %structArr7In ArrayStride 4480

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8inPtr     = OpTypePointer Uniform %i8
%v2i8inPtr   = OpTypePointer Uniform %v2i8
%v3i8inPtr   = OpTypePointer Uniform %v3i8
%v4i8inPtr   = OpTypePointer Uniform %v4i8
%i32inPtr    = OpTypePointer Uniform %i32
%v2i32inPtr  = OpTypePointer Uniform %v2i32
%v3i32inPtr  = OpTypePointer Uniform %v3i32
%v4i32inPtr  = OpTypePointer Uniform %v4i32
%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32inPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8inPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32inPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8inPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32inPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
OpReturnValue %param
OpFunctionEnd

OpCapability Tessellation
OpCapability StorageBuffer8BitAccess
OpCapability UniformAndStorageBuffer8BitAccess

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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 16
OpDecorate %b32NestedArr11In ArrayStride 16
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 16
OpMemberDecorate %sNestedIn 3 Offset 192
OpDecorate %sNestedArr11In ArrayStride 368

OpDecorate %sb8Arr11In ArrayStride 16
OpDecorate %sb32Arr11In ArrayStride 16
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 4128
OpMemberDecorate %structIn 10 Offset 4304
OpDecorate %structArr7In ArrayStride 4480

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8inPtr     = OpTypePointer Uniform %i8
%v2i8inPtr   = OpTypePointer Uniform %v2i8
%v3i8inPtr   = OpTypePointer Uniform %v3i8
%v4i8inPtr   = OpTypePointer Uniform %v4i8
%i32inPtr    = OpTypePointer Uniform %i32
%v2i32inPtr  = OpTypePointer Uniform %v2i32
%v3i32inPtr  = OpTypePointer Uniform %v3i32
%v4i32inPtr  = OpTypePointer Uniform %v4i32
%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32inPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8inPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32inPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8inPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32inPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
OpReturnValue %param
OpFunctionEnd

OpCapability Tessellation
OpCapability StorageBuffer8BitAccess
OpCapability UniformAndStorageBuffer8BitAccess

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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 16
OpDecorate %b32NestedArr11In ArrayStride 16
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 16
OpMemberDecorate %sNestedIn 3 Offset 192
OpDecorate %sNestedArr11In ArrayStride 368

OpDecorate %sb8Arr11In ArrayStride 16
OpDecorate %sb32Arr11In ArrayStride 16
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 4128
OpMemberDecorate %structIn 10 Offset 4304
OpDecorate %structArr7In ArrayStride 4480

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8inPtr     = OpTypePointer Uniform %i8
%v2i8inPtr   = OpTypePointer Uniform %v2i8
%v3i8inPtr   = OpTypePointer Uniform %v3i8
%v4i8inPtr   = OpTypePointer Uniform %v4i8
%i32inPtr    = OpTypePointer Uniform %i32
%v2i32inPtr  = OpTypePointer Uniform %v2i32
%v3i32inPtr  = OpTypePointer Uniform %v3i32
%v4i32inPtr  = OpTypePointer Uniform %v4i32
%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32inPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8inPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32inPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8inPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32inPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
OpReturnValue %param
OpFunctionEnd

OpCapability Geometry
OpCapability StorageBuffer8BitAccess
OpCapability UniformAndStorageBuffer8BitAccess

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


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 16
OpDecorate %b32NestedArr11In ArrayStride 16
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 16
OpMemberDecorate %sNestedIn 3 Offset 192
OpDecorate %sNestedArr11In ArrayStride 368

OpDecorate %sb8Arr11In ArrayStride 16
OpDecorate %sb32Arr11In ArrayStride 16
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 4128
OpMemberDecorate %structIn 10 Offset 4304
OpDecorate %structArr7In ArrayStride 4480

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8inPtr     = OpTypePointer Uniform %i8
%v2i8inPtr   = OpTypePointer Uniform %v2i8
%v3i8inPtr   = OpTypePointer Uniform %v3i8
%v4i8inPtr   = OpTypePointer Uniform %v4i8
%i32inPtr    = OpTypePointer Uniform %i32
%v2i32inPtr  = OpTypePointer Uniform %v2i32
%v3i32inPtr  = OpTypePointer Uniform %v3i32
%v4i32inPtr  = OpTypePointer Uniform %v4i32
%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32inPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8inPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32inPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8inPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32inPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
OpReturnValue %param
OpFunctionEnd

OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability UniformAndStorageBuffer8BitAccess

OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_storage_buffer_storage_class"

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord


OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 16
OpDecorate %b32NestedArr11In ArrayStride 16
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 16
OpMemberDecorate %sNestedIn 3 Offset 192
OpDecorate %sNestedArr11In ArrayStride 368

OpDecorate %sb8Arr11In ArrayStride 16
OpDecorate %sb32Arr11In ArrayStride 16
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 4128
OpMemberDecorate %structIn 10 Offset 4304
OpDecorate %structArr7In ArrayStride 4480

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
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

%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4

%zero     = OpConstant %i32 0
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8inPtr     = OpTypePointer Uniform %i8
%v2i8inPtr   = OpTypePointer Uniform %v2i8
%v3i8inPtr   = OpTypePointer Uniform %v3i8
%v4i8inPtr   = OpTypePointer Uniform %v4i8
%i32inPtr    = OpTypePointer Uniform %i32
%v2i32inPtr  = OpTypePointer Uniform %v2i32
%v3i32inPtr  = OpTypePointer Uniform %v3i32
%v4i32inPtr  = OpTypePointer Uniform %v4i32
%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%uvec3ptr = OpTypePointer Input %v3u32

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer


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
%param     = OpFunctionParameter %v4f32
%label     = OpLabel
%ndxArrx   = OpVariable %fp_i32  Function
%ndxArry   = OpVariable %fp_i32  Function
%ndxArrz   = OpVariable %fp_i32  Function
OpStore %ndxArrx %zero
OpBranch %Loopx
%Loopx = OpLabel
OpLoopMerge %MergeLabel1x %MergeLabel2x None
OpBranch %Label1x
%Label1x = OpLabel
%Valx = OpLoad %i32 %ndxArrx
%LessThanx = OpSLessThan %bool %Valx %c_i32_7
OpBranchConditional %LessThanx %ifLabelx %MergeLabel1x
%ifLabelx = OpLabel

%inP1  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32inPtr %ssboIN %zero %Valx %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %Valx %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8inPtr %ssboIN %zero %Valx %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %Valx %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32inPtr %ssboIN %zero %Valx %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %Valx %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8inPtr %ssboIN %zero %Valx %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %Valx %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32inPtr %ssboIN %zero %Valx %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %Valx %c_i32_7
OpStore %outP8 %inV8
OpStore %ndxArry %zero
OpBranch %Loopy
%Loopy = OpLabel
OpLoopMerge %MergeLabel1y %MergeLabel2y None
OpBranch %Label1y
%Label1y = OpLabel
%Valy = OpLoad %i32 %ndxArry
%LessThany = OpSLessThan %bool %Valy %c_i32_11
OpBranchConditional %LessThany %ifLabely %MergeLabel1y
%ifLabely = OpLabel

%inP9  = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_9 %Valy
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_9 %Valy
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_10 %Valy
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_10 %Valy
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_1
OpStore %outP12 %inV12
OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32inPtr %ssboIN %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %Valx %c_i32_8 %Valy %c_i32_3 %Valz
OpStore %outP14 %inV14
OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel
OpBranch %MergeLabel2y
%MergeLabel2y = OpLabel
%plusOney = OpIAdd %i32 %Valy %c_i32_1
OpStore %ndxArry %plusOney
OpBranch %Loopy
%MergeLabel1y = OpLabel
OpBranch %MergeLabel2x
%MergeLabel2x = OpLabel
%plusOnex = OpIAdd %i32 %Valx %c_i32_1
OpStore %ndxArrx %plusOnex
OpBranch %Loopx
%MergeLabel1x = OpLabel

OpBranch %ExitLabel
%ExitLabel = OpLabel
OpReturnValue %param
OpFunctionEnd

