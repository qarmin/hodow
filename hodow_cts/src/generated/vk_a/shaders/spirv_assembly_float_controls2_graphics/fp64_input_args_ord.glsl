OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpExtension "SPV_KHR_float_controls2"
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_u32_vec2_iptr Input
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result        = OpLoad %type_u32_vec2 %BP_vertex_result
%result               = OpBitcast %type_f64 %packed_result
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
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
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpExtension "SPV_KHR_float_controls2"
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_u32_vec2_iptr Input
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result        = OpLoad %type_u32_vec2 %BP_vertex_result
%result               = OpBitcast %type_f64 %packed_result
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
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
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpExtension "SPV_KHR_float_controls2"
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_u32_vec2_iptr Input
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result        = OpLoad %type_u32_vec2 %BP_vertex_result
%result               = OpBitcast %type_f64 %packed_result
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
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
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpExtension "SPV_KHR_float_controls2"
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_u32_vec2_iptr Input
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%packed_result        = OpLoad %type_u32_vec2 %BP_vertex_result
%result               = OpBitcast %type_f64 %packed_result
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
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
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdNotEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThan %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdLessThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458763
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NotInf|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458765
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458766
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main "main" %BP_stream %BP_position %BP_color %BP_gl_VertexIndex %BP_gl_InstanceIndex %BP_vertex_color %BP_vertex_result 
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
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
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_u32_vec2_iptr   = OpTypePointer Input %type_u32_vec2
%type_u32_vec2_optr   = OpTypePointer Output %type_u32_vec2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%BP_vertex_result     = OpVariable %type_u32_vec2_optr Output
%BP_gl_PerVertex      = OpTypeStruct %type_f32_vec4 %type_f32 %type_f32_arr_1 %type_f32_arr_1
%BP_gl_PerVertex_optr = OpTypePointer Output %BP_gl_PerVertex
%BP_stream            = OpVariable %BP_gl_PerVertex_optr Output
%BP_position          = OpVariable %type_f32_vec4_iptr Input
%BP_color             = OpVariable %type_f32_vec4_iptr Input
%BP_gl_VertexIndex    = OpVariable %type_i32_iptr Input
%BP_gl_InstanceIndex  = OpVariable %type_i32_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_optr Output
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%position             = OpLoad %type_f32_vec4 %BP_position
%gl_pos               = OpAccessChain %type_f32_vec4_optr %BP_stream %c_i32_0
OpStore %gl_pos %position
%color                = OpLoad %type_f32_vec4 %BP_color
OpStore %BP_vertex_color %color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%packed_result        = OpBitcast %type_u32_vec2 %result
OpStore %BP_vertex_result %packed_result
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpCapability FloatControls2
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %BP_vertex_color %BP_vertex_result %BP_fragColor %BP_gl_FragCoord 
OpExecutionMode %main OriginUpperLeft
OpExecutionModeId %main FPFastMathDefault %type_f64 %bc_u32_fp_exec_mode
OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vertex_color Location 1
OpDecorate %BP_vertex_result Location 2
OpDecorate %BP_vertex_result Flat
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord
OpDecorate %boolVal FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
OpDecorate %type_f64_arr_1 ArrayStride 8
OpDecorate %type_f64_arr_2 ArrayStride 8
OpMemberDecorate %SSBO_out 0 Offset 0
OpDecorate %SSBO_out BufferBlock
OpDecorate %ssbo_out DescriptorSet 0
OpDecorate %ssbo_out Binding 1
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
%type_f64             = OpTypeFloat 64
%type_f64_uptr        = OpTypePointer Uniform %type_f64
%type_f64_fptr        = OpTypePointer Function %type_f64
%type_f64_vec2        = OpTypeVector %type_f64 2
%type_f64_vec3        = OpTypeVector %type_f64 3
%type_f64_vec4        = OpTypeVector %type_f64 4
%type_f64_vec4_iptr   = OpTypePointer Input %type_f64_vec4
%type_f64_vec4_optr   = OpTypePointer Output %type_f64_vec4
%type_f64_mat2x2      = OpTypeMatrix %type_f64_vec2 2
%type_f64_arr_1       = OpTypeArray %type_f64 %c_i32_1
%type_f64_arr_2       = OpTypeArray %type_f64 %c_i32_2
%type_f32             = OpTypeFloat 32
%type_f32_arr_1       = OpTypeArray %type_f32 %c_i32_1
%type_f32_iptr        = OpTypePointer Input %type_f32
%type_f32_optr        = OpTypePointer Output %type_f32
%type_f32_vec4        = OpTypeVector %type_f32 4
%type_f32_vec4_iptr   = OpTypePointer Input %type_f32_vec4
%type_f32_vec4_optr   = OpTypePointer Output %type_f32_vec4
%BP_gl_FragCoord      = OpVariable %type_f32_vec4_iptr Input
%BP_vertex_color      = OpVariable %type_f32_vec4_iptr Input
%BP_fragColor         = OpVariable %type_f32_vec4_optr Output
%BP_vertex_result     = OpVariable %type_i32_iptr Input
%SSBO_in              = OpTypeStruct %type_f64_arr_2
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_f64_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%c_f64_n1             = OpConstant %type_f64 -1
%c_f64_n2pt58         = OpConstant %type_f64 -2.58
%c_f64_0              = OpConstant %type_f64 0.0
%c_f64_0_5            = OpConstant %type_f64 0.5
%c_f64_1              = OpConstant %type_f64 1
%c_f64_2              = OpConstant %type_f64 2
%c_f64_3              = OpConstant %type_f64 3
%c_f64_4              = OpConstant %type_f64 4
%c_f64_5              = OpConstant %type_f64 5
%c_f64_6              = OpConstant %type_f64 6
%c_f64_eps            = OpConstant %type_f64 2.2250738585072014e-308
%bc_u32_fp_exec_mode = OpConstant %type_u32 458767
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%vertex_color         = OpLoad %type_f32_vec4 %BP_vertex_color
OpStore %BP_fragColor %vertex_color
%arg1loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_0
%arg1                   = OpLoad %type_f64 %arg1loc
%arg2loc                = OpAccessChain %type_f64_uptr %ssbo_in %c_i32_0 %c_i32_1
%arg2                   = OpLoad %type_f64 %arg2loc
%boolVal           = OpFOrdGreaterThanEqual %type_bool %arg1 %arg2
%result            = OpSelect %type_f64 %boolVal %c_f64_1 %c_f64_0
%outloc               = OpAccessChain %type_f64_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
