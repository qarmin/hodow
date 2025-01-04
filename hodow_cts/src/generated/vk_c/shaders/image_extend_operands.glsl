OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba16ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba8ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba16i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba16i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba16i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba16i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba8i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba8i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba8i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba8i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R32i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgb10a2ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgb10a2ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgb10a2ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgb10a2ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg16ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R16ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R16ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg8ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R8ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R8ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg32i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg16i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg16i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg16i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg16i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R16i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R16i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R16i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R16i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R16i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg8i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg8i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg8i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rg8i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rg8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R8i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %src_image_ptr RelaxedPrecision
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R8i
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R8i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u32 2D 0 0 0 2 Rgba32ui
%type_dst_image                     = OpTypeImage %type_u32 2D 0 0 0 2 R8i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_i32 2D 0 0 0 2 R8i
%type_dst_image                     = OpTypeImage %type_i32 2D 0 0 0 2 Rgba32i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i32 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_i64 2D 0 0 0 2 R64i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i64 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u64 2D 0 0 0 2 R64i
%type_dst_image                     = OpTypeImage %type_u64 2D 0 0 0 2 R64ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u64 %src_image %coord SignExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_i64 2D 0 0 0 2 R64i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i64 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_src_image                     = OpTypeImage %type_u64 2D 0 0 0 2 R64ui
%type_dst_image                     = OpTypeImage %type_u64 2D 0 0 0 2 R64i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_src_image   = OpTypePointer UniformConstant %type_src_image
%type_ptr_uniform_const_dst_image   = OpTypePointer UniformConstant %type_dst_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_src_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_dst_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_src_image %src_image_ptr
%dst_image                          = OpLoad %type_dst_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u64 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value SignExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_i64 2D 0 0 0 2 R64i
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_i64 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_u64 2D 0 0 0 2 R64ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u64 %src_image %coord ZeroExtend
                                      OpImageWrite %dst_image %coord %value 
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_u64 2D 0 0 0 2 R64ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u64 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value ZeroExtend
                                      OpReturn
                                      OpFunctionEnd
OpCapability Shader
OpCapability StorageImageExtendedFormats
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %src_image_ptr %dst_image_ptr
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %src_image_ptr DescriptorSet 0
OpDecorate %src_image_ptr Binding 0
OpDecorate %src_image_ptr NonWritable
OpDecorate %dst_image_ptr DescriptorSet 0
OpDecorate %dst_image_ptr Binding 1
OpDecorate %dst_image_ptr NonReadable
%type_void                          = OpTypeVoid
%type_i32                           = OpTypeInt 32 1
%type_u32                           = OpTypeInt 32 0
%type_vec2_i32                      = OpTypeVector %type_i32 2
%type_vec2_u32                      = OpTypeVector %type_u32 2
%type_vec3_i32                      = OpTypeVector %type_i32 3
%type_vec3_u32                      = OpTypeVector %type_u32 3
%type_vec4_i32                      = OpTypeVector %type_i32 4
%type_vec4_u32                      = OpTypeVector %type_u32 4
%type_i64                           = OpTypeInt 64 1
%type_u64                           = OpTypeInt 64 0
%type_vec3_i64                      = OpTypeVector %type_i64 3
%type_vec3_u64                      = OpTypeVector %type_u64 3
%type_vec4_i64                      = OpTypeVector %type_i64 4
%type_vec4_u64                      = OpTypeVector %type_u64 4
%type_fun_void                      = OpTypeFunction %type_void
%type_image                     = OpTypeImage %type_u64 2D 0 0 0 2 R64ui
%type_ptr_in_vec3_u32               = OpTypePointer Input %type_vec3_u32
%type_ptr_in_u32                    = OpTypePointer Input %type_u32
%type_ptr_uniform_const_image   = OpTypePointer UniformConstant %type_image
%id                                 = OpVariable %type_ptr_in_vec3_u32 Input
%src_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%dst_image_ptr                      = OpVariable %type_ptr_uniform_const_image UniformConstant
%main                               = OpFunction %type_void None %type_fun_void
%label                              = OpLabel
%src_image                          = OpLoad %type_image %src_image_ptr
%dst_image                          = OpLoad %type_image %dst_image_ptr
%idvec                              = OpLoad %type_vec3_u32 %id
%id_xy                              = OpVectorShuffle %type_vec2_u32 %idvec %idvec 0 1
%coord                              = OpBitcast %type_vec2_i32 %id_xy
%value                              = OpImageRead %type_vec4_u64 %src_image %coord 
                                      OpImageWrite %dst_image %coord %value Nontemporal
                                      OpReturn
                                      OpFunctionEnd
