OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpFAdd        %float32 %test_x       %test_y

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpFAdd        %float32 %test_x       %test_y

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %frag_color
OpExecutionMode %main OriginUpperLeft
OpDecorate %frag_color Location 0
%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%float32      = OpTypeFloat    32
%vec4_float32 = OpTypeVector   %float32 4
%c_float32_0    = OpConstant %float32 0
%c_float32_1    = OpConstant %float32 1
%c_output_color = OpConstantComposite %vec4_float32 %c_float32_1 %c_float32_0 %c_float32_0 %c_float32_1
%vec4_float32_output_ptr = OpTypePointer Output %vec4_float32
%frag_color = OpVariable %vec4_float32_output_ptr Output
%main       = OpFunction %void None %void_func
%label_main = OpLabel
              OpStore %frag_color %c_output_color
              OpReturn
              OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpFAdd        %float32 %test_x       %test_y

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpFAdd        %float32 %test_x       %test_y

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec2_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec2_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec2_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec2_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec2_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec2_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec3_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec3_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec3_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec3_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec3_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec3_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec4_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec4_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec4_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec4_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec4_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_EXT_mesh_shader"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID  %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32       0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%out_array           = OpTypeArray %vec4_float32 %c_uint32_16
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint MeshEXT %main "main" %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main OutputVertices 3
OpExecutionMode %main OutputPrimitivesEXT 1
OpExecutionMode %main OutputTrianglesEXT
OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position
OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize
OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance
OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance
OpDecorate       %gl_MeshPerVertexEXT Block
OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn PrimitiveTriangleIndicesEXT
%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%float32      = OpTypeFloat    32
%vec3_uint32  = OpTypeVector   %uint32  3
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant          %uint32  0
%c_uint32_1     = OpConstant          %uint32  1
%c_uint32_2     = OpConstant          %uint32  2
%c_uint32_3     = OpConstant          %uint32  3
%c_uint32_4     = OpConstant          %uint32  4
%c_uint32_16    = OpConstant          %uint32  16
%c_uint32_32    = OpConstant          %uint32  32
%c_uint32_128   = OpConstant          %uint32  128
%c_float32_0    = OpConstant          %float32 0
%c_float32_0_5  = OpConstant          %float32 0.5
%c_float32_n0_5 = OpConstant          %float32 -0.5
%c_float32_10   = OpConstant          %float32 10
%c_float32_20   = OpConstant          %float32 20
%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0
%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0
%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2
%array_float32_1     = OpTypeArray %float32     %c_uint32_1
%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1
%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1
%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3
%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32
%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32
%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1
%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3
%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output
%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1
%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0
                      OpStore       %position_loc_0          %c_vertex_0
%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0
                      OpStore       %position_loc_1          %c_vertex_1
%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0
                      OpStore       %position_loc_2          %c_vertex_2
%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0
                      OpStore       %indices_loc             %c_indices
                      OpReturn
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpFMul        %float32 %c_float32_10 %masked_ndx_float32

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpFAdd        %float32 %test_x       %test_y

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 4
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%float32_storage_buffer_ptr = OpTypePointer StorageBuffer %float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpFAdd        %float32 %test_x       %test_y

%store_value = OpGroupNonUniformQuadBroadcast %float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 8
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec2_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec2_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec2_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec2_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec2_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec3_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec3_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec3_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec3_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec3_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 16 1 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %ndx_uint32
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupLinearKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupLinearKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_2

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
OpCapability MeshShadingEXT
OpCapability ComputeDerivativeGroupQuadsKHR


OpCapability DerivativeControl
OpCapability GroupNonUniformQuad
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_compute_shader_derivatives"
OpExtension "SPV_EXT_mesh_shader"
OpMemoryModel Logical GLSL450
OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var %gl_LocalInvocationID %gl_SubgroupID %gl_SubgroupInvocationID 
OpExecutionMode %main LocalSize 4 4 1
OpExecutionMode %main DerivativeGroupQuadsKHR
OpDecorate      %gl_LocalInvocationID    BuiltIn     LocalInvocationId
OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId
OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId
OpDecorate      %out_array               ArrayStride 16
OpMemberDecorate %out_x 0 Offset 0
OpDecorate       %out_x Block
OpDecorate       %out_x_var DescriptorSet 0
OpDecorate       %out_x_var Binding       0
OpMemberDecorate %out_y 0 Offset 0
OpDecorate       %out_y Block
OpDecorate       %out_y_var DescriptorSet 0
OpDecorate       %out_y_var Binding       1
OpMemberDecorate %out_f 0 Offset 0
OpDecorate       %out_f Block
OpDecorate       %out_f_var DescriptorSet 0
OpDecorate       %out_f_var Binding       2

%void         = OpTypeVoid
%void_func    = OpTypeFunction %void
%uint32       = OpTypeInt      32      0
%vec3_uint32  = OpTypeVector   %uint32  3
%float32      = OpTypeFloat    32
%vec2_float32 = OpTypeVector   %float32 2
%vec3_float32 = OpTypeVector   %float32 3
%vec4_float32 = OpTypeVector   %float32 4
%c_uint32_0     = OpConstant %uint32  0
%c_uint32_1     = OpConstant %uint32  1
%c_uint32_2     = OpConstant %uint32  2
%c_uint32_3     = OpConstant %uint32  3
%c_uint32_4     = OpConstant %uint32  4
%c_uint32_16    = OpConstant %uint32  16
%c_uint32_32    = OpConstant %uint32  32
%c_uint32_128   = OpConstant %uint32  128
%c_float32_2    = OpConstant %float32 2
%c_float32_3    = OpConstant %float32 3
%c_float32_4    = OpConstant %float32 4
%c_float32_10   = OpConstant %float32 10
%c_float32_20   = OpConstant %float32 20
%c_float32_0_08 = OpConstant %float32 0.08
%c_float32_0_10 = OpConstant %float32 0.10
%c_float32_0_12 = OpConstant %float32 0.12
%out_array = OpTypeArray %vec4_float32 %c_uint32_16
%out_x = OpTypeStruct %out_array
%out_y = OpTypeStruct %out_array
%out_f = OpTypeStruct %out_array
%uint32_input_ptr              = OpTypePointer Input         %uint32
%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32
%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x
%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y
%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f
%vec4_float32_storage_buffer_ptr = OpTypePointer StorageBuffer %vec4_float32
%gl_LocalInvocationID    = OpVariable %vec3_uint32_input_ptr    Input
%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input
%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input
%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer
%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer
%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer

%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0
%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x
%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1
%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y
%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4

%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32
%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1
%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1
%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32
%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32
%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32
%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32
%scalar_value       = OpFAdd               %float32      %test_x       %test_y
%test_value = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value

%store_value = OpGroupNonUniformQuadBroadcast %vec4_float32 %c_uint32_3 %test_value %c_uint32_3

%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr %out_x_var %c_uint32_0 %linear_ndx
             OpStore       %out_x_loc                     %store_value

                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1
                      OpFunctionEnd
