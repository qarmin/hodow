OpCapability Shader
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %main_fun "main"
%type_void       = OpTypeVoid
%type_void_f     = OpTypeFunction %type_void
%main_fun        = OpFunction %type_void None %type_void_f
%main_label      = OpLabel
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Triangles
OpExecutionMode %main_fun SpacingEqual
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationEvaluation %main_fun "main" %var_gl_tess_coord
OpDecorate %type_run_arr_v3_f32 ArrayStride 16
OpMemberDecorate %type_struct 0 Coherent
OpMemberDecorate %type_struct 0 Offset 0
OpMemberDecorate %type_struct 1 Coherent
OpMemberDecorate %type_struct 1 Offset 16
OpDecorate %type_struct BufferBlock
OpDecorate %var_struct_ptr DescriptorSet 0
OpDecorate %var_struct_ptr Restrict
OpDecorate %var_struct_ptr Binding 1
OpDecorate %var_gl_tess_coord BuiltIn TessCoord
%type_void             = OpTypeVoid
%type_void_f           = OpTypeFunction %type_void
%type_i32              = OpTypeInt 32 1
%type_u32              = OpTypeInt 32 0
%type_i32_fp           = OpTypePointer Function %type_i32
%type_f32              = OpTypeFloat 32
%type_v3_f32           = OpTypeVector %type_f32 3
%type_run_arr_v3_f32   = OpTypeRuntimeArray %type_v3_f32
%type_struct           = OpTypeStruct %type_i32 %type_run_arr_v3_f32
%type_uni_struct_ptr   = OpTypePointer Uniform %type_struct
%type_uni_i32_ptr      = OpTypePointer Uniform %type_i32
%type_uni_v3_f32_ptr   = OpTypePointer Uniform %type_v3_f32
%type_in_v3_f32_ptr    = OpTypePointer Input %type_v3_f32
%c_i32_0               = OpConstant %type_i32 0
%c_i32_1               = OpConstant %type_i32 1
%c_u32_0               = OpConstant %type_u32 1
%c_u32_1               = OpConstant %type_u32 0
%var_struct_ptr        = OpVariable %type_uni_struct_ptr Uniform
%var_gl_tess_coord     = OpVariable %type_in_v3_f32_ptr Input
%main_fun              = OpFunction %type_void None %type_void_f
%main_label            = OpLabel
%var_i32_ptr           = OpVariable %type_i32_fp Function
%num_invocations       = OpAccessChain %type_uni_i32_ptr %var_struct_ptr %c_i32_0
%index_0               = OpAtomicIAdd %type_i32 %num_invocations %c_u32_0 %c_u32_1 %c_i32_1
                         OpStore %var_i32_ptr %index_0
%index_1               = OpLoad %type_i32 %var_i32_ptr
%gl_tess_coord         = OpLoad %type_v3_f32 %var_gl_tess_coord
%out_tess_coord        = OpAccessChain %type_uni_v3_f32_ptr %var_struct_ptr %c_i32_1 %index_1
                         OpStore %out_tess_coord %gl_tess_coord
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Triangles
OpExecutionMode %main_fun SpacingFractionalOdd
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Triangles
OpExecutionMode %main_fun SpacingFractionalEven
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Quads
OpExecutionMode %main_fun SpacingEqual
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Quads
OpExecutionMode %main_fun SpacingFractionalOdd
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Quads
OpExecutionMode %main_fun SpacingFractionalEven
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Isolines
OpExecutionMode %main_fun SpacingEqual
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Isolines
OpExecutionMode %main_fun SpacingFractionalOdd
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
OpCapability Tessellation
%glsl_ext_inst = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint TessellationControl %main_fun "main" %var_tess_level_inner %var_tess_level_outer
OpExecutionMode %main_fun OutputVertices 1
OpExecutionMode %main_fun Isolines
OpExecutionMode %main_fun SpacingFractionalEven
OpExecutionMode %main_fun PointMode
OpExecutionMode %main_fun VertexOrderCcw
OpDecorate %var_tess_level_inner Patch
OpDecorate %var_tess_level_inner BuiltIn TessLevelInner
OpMemberDecorate %type_struct_sb_levels 0 NonWritable
OpMemberDecorate %type_struct_sb_levels 0 Offset 0
OpMemberDecorate %type_struct_sb_levels 1 NonWritable
OpMemberDecorate %type_struct_sb_levels 1 Offset 4
OpMemberDecorate %type_struct_sb_levels 2 NonWritable
OpMemberDecorate %type_struct_sb_levels 2 Offset 8
OpMemberDecorate %type_struct_sb_levels 3 NonWritable
OpMemberDecorate %type_struct_sb_levels 3 Offset 12
OpMemberDecorate %type_struct_sb_levels 4 NonWritable
OpMemberDecorate %type_struct_sb_levels 4 Offset 16
OpMemberDecorate %type_struct_sb_levels 5 NonWritable
OpMemberDecorate %type_struct_sb_levels 5 Offset 20
OpDecorate %type_struct_sb_levels BufferBlock
OpDecorate %var_struct_sb_levels DescriptorSet 0
OpDecorate %var_struct_sb_levels Binding 0
OpDecorate %var_struct_sb_levels Restrict
OpDecorate %var_tess_level_outer Patch
OpDecorate %var_tess_level_outer BuiltIn TessLevelOuter
%type_void                 = OpTypeVoid
%type_void_f               = OpTypeFunction %type_void
%type_f32                  = OpTypeFloat 32
%type_u32                  = OpTypeInt 32 0
%c_u32_2                   = OpConstant %type_u32 2
%type_arr_f32_2            = OpTypeArray %type_f32 %c_u32_2
%type_arr_f32_2_ptr        = OpTypePointer Output %type_arr_f32_2
%type_i32                  = OpTypeInt 32 1
%type_struct_sb_levels     = OpTypeStruct %type_f32 %type_f32 %type_f32 %type_f32 %type_f32 %type_f32
%type_struct_sb_levels_ptr = OpTypePointer Uniform %type_struct_sb_levels
%var_struct_sb_levels      = OpVariable %type_struct_sb_levels_ptr Uniform
%type_uni_f32_ptr          = OpTypePointer Uniform %type_f32
%type_out_f32_ptr          = OpTypePointer Output %type_f32
%c_i32_0                   = OpConstant %type_i32 0
%c_i32_1                   = OpConstant %type_i32 1
%c_u32_4                   = OpConstant %type_u32 4
%c_i32_2                   = OpConstant %type_i32 2
%c_i32_3                   = OpConstant %type_i32 3
%c_i32_4                   = OpConstant %type_i32 4
%c_i32_5                   = OpConstant %type_i32 5
%type_arr_f32_4            = OpTypeArray %type_f32 %c_u32_4
%type_arr_f32_4_ptr        = OpTypePointer Output %type_arr_f32_4
%var_tess_level_inner      = OpVariable %type_arr_f32_2_ptr Output
%var_tess_level_outer      = OpVariable %type_arr_f32_4_ptr Output
%main_fun                  = OpFunction %type_void None %type_void_f
%main_label                = OpLabel
%tess_inner_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_0
%tess_inner_0              = OpLoad %type_f32 %tess_inner_0_ptr
%gl_tess_inner_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_0
                             OpStore %gl_tess_inner_0 %tess_inner_0
%tess_inner_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_1
%tess_inner_1              = OpLoad %type_f32 %tess_inner_1_ptr
%gl_tess_inner_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_inner %c_i32_1
                             OpStore %gl_tess_inner_1 %tess_inner_1
%tess_outer_0_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_2
%tess_outer_0              = OpLoad %type_f32 %tess_outer_0_ptr
%gl_tess_outer_0           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_0
                             OpStore %gl_tess_outer_0 %tess_outer_0
%tess_outer_1_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_3
%tess_outer_1              = OpLoad %type_f32 %tess_outer_1_ptr
%gl_tess_outer_1           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_1
                             OpStore %gl_tess_outer_1 %tess_outer_1
%tess_outer_2_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_4
%tess_outer_2              = OpLoad %type_f32 %tess_outer_2_ptr
%gl_tess_outer_2           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_2
                             OpStore %gl_tess_outer_2 %tess_outer_2
%tess_outer_3_ptr          = OpAccessChain %type_uni_f32_ptr %var_struct_sb_levels %c_i32_5
%tess_outer_3              = OpLoad %type_f32 %tess_outer_3_ptr
%gl_tess_outer_3           = OpAccessChain %type_out_f32_ptr %var_tess_level_outer %c_i32_3
                             OpStore %gl_tess_outer_3 %tess_outer_3
OpReturn
OpFunctionEnd
