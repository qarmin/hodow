OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
%var_ptr = OpSelect %outer_struct_ptr %c_bool_true %in_a %in_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
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
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
%var_ptr = OpSelect %outer_struct_ptr %c_bool_true %in_a %in_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
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
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
%in_a_copy = OpCopyObject %outer_struct_ptr %in_a
%in_b_copy = OpCopyObject %outer_struct_ptr %in_b
%var_ptr = OpSelect %outer_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
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
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %mat2x2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %mat2x2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %mat2x2_ptr       %in_a %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %mat2x2_ptr       %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %inner_struct_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpFunctionCall %inner_struct_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpPtrAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpFunctionCall %arr_v4f32_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpPtrAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %v4f32_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %v4f32_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %sb_f32ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %sb_f32ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %sb_f32ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %a_loc_first_elem = OpAccessChain %v4f32_ptr %a_loc_arr %c_i32_0 %a_loc = OpPtrAccessChain %sb_f32ptr %a_loc_first_elem %c_i32_1 %c_i32_3 
%b_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %b_loc_first_elem = OpAccessChain %v4f32_ptr %b_loc_arr %c_i32_0 %b_loc = OpPtrAccessChain %sb_f32ptr %b_loc_first_elem %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
%in_a_copy = OpCopyObject %outer_struct_ptr %in_a
%in_b_copy = OpCopyObject %outer_struct_ptr %in_b
%var_ptr = OpSelect %outer_struct_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %outer_struct_ptr %in_a %take_input_a %in_b %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %outer_struct_ptr %in_a %take_input_a %in_b %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %outer_struct_ptr %in_a %take_input_a %in_b %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
%var_ptr = OpFunctionCall %outer_struct_ptr %choose_input_func %c_bool_false %in_a %in_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
%var_ptr = OpFunctionCall %outer_struct_ptr %choose_input_func %c_bool_false %in_a %in_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
 
 
%var_ptr = OpFunctionCall %outer_struct_ptr %choose_input_func %c_bool_false %in_a %in_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%in_a_copy = OpCopyObject %mat2x2_ptr %a_loc
%in_b_copy = OpCopyObject %mat2x2_ptr %b_loc
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %mat2x2_ptr       %in_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %in_b %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %mat2x2_ptr       %in_a %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %mat2x2_ptr       %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr2_ptr         %in_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %in_b %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %inner_struct_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpFunctionCall %inner_struct_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpPtrAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %inner_struct_ptr %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpPtrAccessChain %inner_struct_ptr %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr_v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr_v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr_v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpFunctionCall %arr_v4f32_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %arr_v4f32_ptr    %in_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpPtrAccessChain %arr_v4f32_ptr    %in_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %v4f32_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpPtrAccessChain %v4f32_ptr        %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %v4f32_ptr        %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Geometry
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %sb_f32ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
OpExtension "SPV_KHR_storage_buffer_storage_class"    

OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %BP_main "main" %BP_vtxColor %BP_fragColor %BP_gl_FragCoord  
OpExecutionMode %BP_main OriginUpperLeft



OpDecorate %BP_fragColor Location 0
OpDecorate %BP_vtxColor Location 1
OpDecorate %BP_gl_FragCoord BuiltIn FragCoord

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %sb_f32ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %sb_f32ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc = OpAccessChain %sb_f32ptr        %in_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %in_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Shader
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    

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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %a_loc_first_elem = OpAccessChain %v4f32_ptr %a_loc_arr %c_i32_0 %a_loc = OpPtrAccessChain %sb_f32ptr %a_loc_first_elem %c_i32_1 %c_i32_3 
%b_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %b_loc_first_elem = OpAccessChain %v4f32_ptr %b_loc_arr %c_i32_0 %b_loc = OpPtrAccessChain %sb_f32ptr %b_loc_first_elem %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

OpCapability Tessellation
OpCapability VariablePointersStorageBuffer                

OpExtension "SPV_KHR_variable_pointers"                
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

OpDecorate %arr2_v4float        ArrayStride 16            
OpDecorate %arr2_inner_struct   ArrayStride 64            
OpDecorate %mat2x2_inner_struct ArrayStride 128        
OpDecorate %outer_struct_ptr    ArrayStride 256        
OpDecorate %v4f32_ptr           ArrayStride 16            
OpMemberDecorate            %input_buffer 0 Offset 0    
OpMemberDecorate            %input_buffer 1 Offset 256    
OpMemberDecorate            %outer_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 0 Offset 0    
OpMemberDecorate            %inner_struct 1 Offset 32    
OpDecorate                    %input_buffer Block            
OpDecorate %input            DescriptorSet 0                
OpDecorate %input            Binding 0                    
OpDecorate %input            NonWritable                    


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
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%input_buffer_ptr = OpTypePointer StorageBuffer %input_buffer            
%outer_struct_ptr = OpTypePointer StorageBuffer %outer_struct            
%mat2x2_ptr = OpTypePointer StorageBuffer %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer StorageBuffer %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer StorageBuffer %inner_struct            
%arr_v4f32_ptr = OpTypePointer StorageBuffer %arr2_v4float            
%v4f32_ptr = OpTypePointer StorageBuffer %v4f32                
%sb_f32ptr = OpTypePointer StorageBuffer %f32                    
%input = OpVariable %input_buffer_ptr StorageBuffer        
%c_bool_true = OpConstantTrue %bool                                
%c_bool_false = OpConstantFalse %bool                                
 


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
%in_a = OpAccessChain %outer_struct_ptr %input %c_i32_0
%in_b = OpAccessChain %outer_struct_ptr %input %c_i32_1
%a_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %in_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %a_loc_first_elem = OpAccessChain %v4f32_ptr %a_loc_arr %c_i32_0 %a_loc = OpPtrAccessChain %sb_f32ptr %a_loc_first_elem %c_i32_1 %c_i32_3 
%b_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %in_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %b_loc_first_elem = OpAccessChain %v4f32_ptr %b_loc_arr %c_i32_0 %b_loc = OpPtrAccessChain %sb_f32ptr %b_loc_first_elem %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc
%output_color = OpCompositeInsert %v4f32 %result_val %param 0 
OpReturnValue %output_color
OpFunctionEnd

