OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_i64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_i64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int64 2D 0 0 0 1 R64i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_i64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_i64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_i64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_i64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int64 2D 0 0 0 1 R64i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_i64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_i64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 R32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 R32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 R16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 R16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 R8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 R8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_u64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_u64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint64 2D 0 0 0 1 R64ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_u64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_u64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_u64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_u64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint64 2D 0 0 0 1 R64ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_u64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_u64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 R32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 R32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 R16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 R16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 R8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 R8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 R8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rg32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rg32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rg16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rg16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rg8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rg8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rg32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rg32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rg16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rg16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rg8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rg8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rg8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rgba32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rgba32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rgba16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rgba16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rgba8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 0 0 1 Rgba8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rgba32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rgba32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rgba16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rgba16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rgba8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 0 0 1 Rgba8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 0 0 1 Rgba8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec2 %local_coord_x_bias %local_coord_y_bias
%local_coord_biased = OpFAdd %type_vec2 %local_texCoord_xy %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_i64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_i64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int64 2D 0 1 0 1 R64i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_i64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_i64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_i64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_i64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int64 2D 0 1 0 1 R64i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_i64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_i64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_i64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 R32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 R32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 R16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 R16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 R8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 R8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_u64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_u64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint64 2D 0 1 0 1 R64ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_u64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_u64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_int64 = OpTypeInt 64 1
%type_uint64 = OpTypeInt 64 0
%type_i64vec2 = OpTypeVector %type_int64  2
%type_i64vec3 = OpTypeVector %type_int64  3
%type_i64vec4 = OpTypeVector %type_int64  4
%type_u64vec3 = OpTypeVector %type_uint64 3
%type_u64vec4 = OpTypeVector %type_uint64 4
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_u64vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_u64vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint64 2D 0 1 0 1 R64ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_u64vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint64 %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint64 %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint64 %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint64 %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_u64vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_u64vec4 %local_sparse_op_result 1
%local_img_comp32b = OpSConvert %type_ivec4 %local_img_comp_vec4
OpStore %output_texel %local_img_comp32b
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 R32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 R32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 R16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 R16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 R8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 R8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 R8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rg32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rg32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rg16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rg16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rg8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rg8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rg32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rg32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rg16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rg16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rg8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rg8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rg8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rgba32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rgba32i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rgba16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rgba16i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rgba8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_ivec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_ivec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_ivec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_int 2D 0 1 0 1 Rgba8i
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_ivec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_int %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_int %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_int %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_int %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_ivec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_ivec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rgba32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rgba32ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rgba16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rgba16ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rgba8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_uvec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_uvec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_uvec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_uint 2D 0 1 0 1 Rgba8ui
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_uvec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_uint %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_uint %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_uint %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_uint %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_uvec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_uvec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba16
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba8
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba16Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency 
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability SampledCubeArray
OpCapability ImageCubeArray
OpCapability SparseResidency
OpCapability StorageImageExtendedFormats
%ext_import = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %func_main "main" %varying_texCoord %output_texel %output_residency  %uniformconst_image_sparse %uniformblock_instance
OpExecutionMode %func_main OriginUpperLeft
OpSource GLSL 440
OpName %func_main "main"
OpName %varying_texCoord "varying_texCoord"
OpName %output_texel "out_texel"
OpName %output_residency "out_residency"
OpName %type_uniformblock "LodBlock"
OpMemberName %type_uniformblock 0 "lod"
OpMemberName %type_uniformblock 1 "size"
OpName %uniformblock_instance "lodInstance"
OpName %uniformconst_image_sparse "u_imageSparse"
OpDecorate %varying_texCoord Location 0
OpDecorate %output_texel     Location 0
OpDecorate %output_residency Location 1
OpDecorate         %type_uniformblock Block
OpMemberDecorate %type_uniformblock 0 Offset 0
OpMemberDecorate %type_uniformblock 1 Offset 8
OpDecorate %uniformconst_image_sparse DescriptorSet 0
OpDecorate %uniformconst_image_sparse Binding 0
%type_void = OpTypeVoid
%type_void_func = OpTypeFunction %type_void
%type_bool = OpTypeBool
%type_int = OpTypeInt 32 1
%type_uint = OpTypeInt 32 0
%type_float = OpTypeFloat 32
%type_vec2 = OpTypeVector %type_float 2
%type_vec3 = OpTypeVector %type_float 3
%type_vec4 = OpTypeVector %type_float 4
%type_ivec4 = OpTypeVector %type_int 4
%type_uvec4 = OpTypeVector %type_uint 4
%type_uniformblock = OpTypeStruct %type_uint %type_vec2
%type_struct_int_img_comp_vec4 = OpTypeStruct %type_int %type_vec4
%type_input_vec3 = OpTypePointer Input %type_vec3
%type_input_float = OpTypePointer Input %type_float
%type_output_img_comp_vec4 = OpTypePointer Output %type_vec4
%type_output_uint = OpTypePointer Output %type_uint
%type_function_int = OpTypePointer Function %type_int
%type_function_img_comp_vec4 = OpTypePointer Function %type_vec4
%type_function_int_img_comp_vec4 = OpTypePointer Function %type_struct_int_img_comp_vec4
%type_pushconstant_uniformblock = OpTypePointer PushConstant %type_uniformblock
%type_pushconstant_uniformblock_member_lod = OpTypePointer PushConstant %type_uint
%type_pushconstant_uniformblock_member_size = OpTypePointer PushConstant %type_vec2
%type_image_sparse = OpTypeImage %type_float 2D 0 1 0 1 Rgba8Snorm
%type_sampled_image_sparse = OpTypeSampledImage %type_image_sparse
%type_uniformconst_image_sparse = OpTypePointer UniformConstant %type_sampled_image_sparse
%varying_texCoord = OpVariable %type_input_vec3 Input
%output_texel = OpVariable %type_output_img_comp_vec4 Output
%output_residency = OpVariable %type_output_uint Output
%uniformconst_image_sparse = OpVariable %type_uniformconst_image_sparse UniformConstant
%uniformblock_instance  = OpVariable %type_pushconstant_uniformblock PushConstant
%constant_uint_0 = OpConstant %type_uint 0
%constant_uint_1 = OpConstant %type_uint 1
%constant_uint_2 = OpConstant %type_uint 2
%constant_uint_3 = OpConstant %type_uint 3
%constant_int_0 = OpConstant %type_int  0
%constant_int_1 = OpConstant %type_int  1
%constant_int_2 = OpConstant %type_int  2
%constant_int_3 = OpConstant %type_int  3
%constant_float_0 = OpConstant %type_float 0.0
%constant_float_half = OpConstant %type_float 0.5
%constant_texel_resident = OpConstant %type_uint 1
%constant_texel_not_resident = OpConstant %type_uint 2
%func_main         = OpFunction %type_void None %type_void_func
%label_func_main = OpLabel
%local_image_sparse = OpLoad %type_sampled_image_sparse %uniformconst_image_sparse
%texCoord = OpLoad %type_vec3 %varying_texCoord
%local_texCoord_x = OpCompositeExtract %type_float %texCoord 0
%local_texCoord_y = OpCompositeExtract %type_float %texCoord 1
%local_texCoord_z = OpCompositeExtract %type_float %texCoord 2
%local_texCoord_xy = OpCompositeConstruct %type_vec2 %local_texCoord_x %local_texCoord_y
%local_texCoord_xyz = OpCompositeConstruct %type_vec3 %local_texCoord_x %local_texCoord_y %local_texCoord_z
%access_uniformblock_member_uint_lod = OpAccessChain %type_pushconstant_uniformblock_member_lod %uniformblock_instance %constant_int_0
%local_uniformblock_member_uint_lod  = OpLoad %type_uint %access_uniformblock_member_uint_lod
%local_uniformblock_member_float_lod = OpConvertUToF %type_float %local_uniformblock_member_uint_lod
%access_uniformblock_member_size     = OpAccessChain %type_pushconstant_uniformblock_member_size %uniformblock_instance %constant_int_1
%local_uniformblock_member_size         = OpLoad %type_vec2 %access_uniformblock_member_size
%local_image_width = OpCompositeExtract %type_float %local_uniformblock_member_size 0
%local_image_height = OpCompositeExtract %type_float %local_uniformblock_member_size 1
%local_coord_x_bias = OpFDiv %type_float %constant_float_half %local_image_width
%local_coord_y_bias = OpFDiv %type_float %constant_float_half %local_image_height
%local_coord_bias = OpCompositeConstruct %type_vec3 %local_coord_x_bias %local_coord_y_bias %constant_float_0
%local_coord_biased = OpFAdd %type_vec3 %local_texCoord_xyz %local_coord_bias
%local_sparse_gather_result_x = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_0 Nontemporal
%local_sparse_gather_result_y = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_1 Nontemporal
%local_sparse_gather_result_z = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_2 Nontemporal
%local_sparse_gather_result_w = OpImageSparseGather %type_struct_int_img_comp_vec4 %local_image_sparse %local_coord_biased %constant_int_3 Nontemporal
%local_gather_residency_code = OpCompositeExtract %type_int %local_sparse_gather_result_x 0
%local_gather_texels_x = OpCompositeExtract %type_vec4 %local_sparse_gather_result_x 1
%local_gather_texels_y = OpCompositeExtract %type_vec4 %local_sparse_gather_result_y 1
%local_gather_texels_z = OpCompositeExtract %type_vec4 %local_sparse_gather_result_z 1
%local_gather_texels_w = OpCompositeExtract %type_vec4 %local_sparse_gather_result_w 1
%local_gather_primary_texel_x = OpCompositeExtract %type_float %local_gather_texels_x 3
%local_gather_primary_texel_y = OpCompositeExtract %type_float %local_gather_texels_y 3
%local_gather_primary_texel_z = OpCompositeExtract %type_float %local_gather_texels_z 3
%local_gather_primary_texel_w = OpCompositeExtract %type_float %local_gather_texels_w 3
%local_gather_primary_texel = OpCompositeConstruct %type_vec4 %local_gather_primary_texel_x %local_gather_primary_texel_y %local_gather_primary_texel_z %local_gather_primary_texel_w
%local_sparse_op_result = OpCompositeConstruct %type_struct_int_img_comp_vec4 %local_gather_residency_code %local_gather_primary_texel
%local_img_comp_vec4 = OpCompositeExtract %type_vec4 %local_sparse_op_result 1
OpStore %output_texel %local_img_comp_vec4
%local_residency_code = OpCompositeExtract %type_int %local_sparse_op_result 0
%local_texel_resident = OpImageSparseTexelsResident %type_bool %local_residency_code
OpSelectionMerge %branch_texel_resident None
OpBranchConditional %local_texel_resident %label_texel_resident %label_texel_not_resident
%label_texel_resident = OpLabel
OpStore %output_residency %constant_texel_resident
OpBranch %branch_texel_resident
%label_texel_not_resident = OpLabel
OpStore %output_residency %constant_texel_not_resident
OpBranch %branch_texel_resident
%branch_texel_resident = OpLabel
OpReturn
OpFunctionEnd
