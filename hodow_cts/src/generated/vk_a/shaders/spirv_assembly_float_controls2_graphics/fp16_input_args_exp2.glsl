OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result    = OpVariable %type_u32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%tmp_vec2            = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%packed_result       = OpBitcast %type_u32 %tmp_vec2
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result    = OpVariable %type_u32_iptr Input
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result       = OpLoad %type_u32 %BP_vertex_result
%tmp_vec2            = OpBitcast %type_f16_vec2 %packed_result
%result              = OpCompositeExtract %type_f16 %tmp_vec2 0
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpDecorate %type_f32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_vertex_result     = OpVariable %type_i32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpDecorate %result FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result    = OpVariable %type_u32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%tmp_vec2            = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%packed_result       = OpBitcast %type_u32 %tmp_vec2
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result    = OpVariable %type_u32_iptr Input
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result       = OpLoad %type_u32 %BP_vertex_result
%tmp_vec2            = OpBitcast %type_f16_vec2 %packed_result
%result              = OpCompositeExtract %type_f16 %tmp_vec2 0
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpDecorate %type_f32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_vertex_result     = OpVariable %type_i32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %result FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result    = OpVariable %type_u32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%tmp_vec2            = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%packed_result       = OpBitcast %type_u32 %tmp_vec2
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result    = OpVariable %type_u32_iptr Input
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result       = OpLoad %type_u32 %BP_vertex_result
%tmp_vec2            = OpBitcast %type_f16_vec2 %packed_result
%result              = OpCompositeExtract %type_f16 %tmp_vec2 0
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpDecorate %type_f32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_vertex_result     = OpVariable %type_i32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpDecorate %result FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result    = OpVariable %type_u32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%tmp_vec2            = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%packed_result       = OpBitcast %type_u32 %tmp_vec2
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %result FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result    = OpVariable %type_u32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%tmp_vec2            = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%packed_result       = OpBitcast %type_u32 %tmp_vec2
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result    = OpVariable %type_u32_iptr Input
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result       = OpLoad %type_u32 %BP_vertex_result
%tmp_vec2            = OpBitcast %type_f16_vec2 %packed_result
%result              = OpCompositeExtract %type_f16 %tmp_vec2 0
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpDecorate %type_f32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_vertex_result     = OpVariable %type_i32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
OpExtension "SPV_KHR_16bit_storage"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpMemberDecorate %BP_gl_PerVertex 0 BuiltIn Position
OpMemberDecorate %BP_gl_PerVertex 1 BuiltIn PointSize
OpMemberDecorate %BP_gl_PerVertex 2 BuiltIn ClipDistance
OpMemberDecorate %BP_gl_PerVertex 3 BuiltIn CullDistance
OpDecorate %BP_gl_PerVertex Block
OpDecorate %BP_position Location 0
OpDecorate %BP_color Location 1
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_VertexIndex BuiltIn VertexIndex
OpDecorate %BP_gl_InstanceIndex BuiltIn InstanceIndex
OpDecorate %result FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_u32_iptr        = OpTypePointer Input %type_u32
%type_u32_optr        = OpTypePointer Output %type_u32
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result    = OpVariable %type_u32_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%tmp_vec2            = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%packed_result       = OpBitcast %type_u32 %tmp_vec2
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float16
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %result FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f16_arr_1 ArrayStride 2
OpDecorate %type_f16_arr_2 ArrayStride 2
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
OpDecorate %type_u32_arr_1 ArrayStride 4
%type_void            = OpTypeVoid
%type_voidf           = OpTypeFunction %type_void
%type_bool            = OpTypeBool
%type_i32             = OpTypeInt 32 1
%type_u32             = OpTypeInt 32 0
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_i32_iptr        = OpTypePointer Input %type_i32
%type_i32_optr        = OpTypePointer Output %type_i32
%type_i32_fptr        = OpTypePointer Function %type_i32
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
%c_u32_1              = OpConstant %type_u32 1
%type_f16             = OpTypeFloat 16
%type_f16_uptr        = OpTypePointer Uniform %type_f16
%type_f16_fptr        = OpTypePointer Function %type_f16
%type_f16_vec2        = OpTypeVector %type_f16 2
%type_f16_vec3        = OpTypeVector %type_f16 3
%type_f16_vec4        = OpTypeVector %type_f16 4
%type_f16_vec4_iptr   = OpTypePointer Input %type_f16_vec4
%type_f16_vec4_optr   = OpTypePointer Output %type_f16_vec4
%type_f16_mat2x2      = OpTypeMatrix %type_f16_vec2 2
%type_f16_arr_1       = OpTypeArray %type_f16 %c_i32_1
%type_f16_arr_2       = OpTypeArray %type_f16 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f16_n1             = OpConstant %type_f16 -1
%c_f16_n2pt58         = OpConstant %type_f16 -2.58
%c_f16_0              = OpConstant %type_f16 0.0
%c_f16_0_5            = OpConstant %type_f16 0.5
%c_f16_1              = OpConstant %type_f16 1
%c_f16_2              = OpConstant %type_f16 2
%c_f16_3              = OpConstant %type_f16 3
%c_f16_4              = OpConstant %type_f16 4
%c_f16_5              = OpConstant %type_f16 5
%c_f16_6              = OpConstant %type_f16 6
%c_f16_eps            = OpConstant %type_f16 6.104e-5
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 Exp2 %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
