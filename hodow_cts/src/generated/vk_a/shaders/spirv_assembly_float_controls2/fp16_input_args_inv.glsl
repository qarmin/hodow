OpCapability Shader
OpCapability FloatControls2
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
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
%type_u32             = OpTypeInt 32 0
%type_i32             = OpTypeInt 32 1
%type_i32_fptr        = OpTypePointer Function %type_i32
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_u32_vec3        = OpTypeVector %type_u32 3
%type_u32_vec3_ptr    = OpTypePointer Input %type_u32_vec3
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
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
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%id                   = OpVariable %type_u32_vec3_ptr Input
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
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 InverseSqrt %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FloatControls2
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %result FPFastMathMode NotNaN|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
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
%type_u32             = OpTypeInt 32 0
%type_i32             = OpTypeInt 32 1
%type_i32_fptr        = OpTypePointer Function %type_i32
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_u32_vec3        = OpTypeVector %type_u32 3
%type_u32_vec3_ptr    = OpTypePointer Input %type_u32_vec3
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
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
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%id                   = OpVariable %type_u32_vec3_ptr Input
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
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 InverseSqrt %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FloatControls2
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
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
%type_u32             = OpTypeInt 32 0
%type_i32             = OpTypeInt 32 1
%type_i32_fptr        = OpTypePointer Function %type_i32
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_u32_vec3        = OpTypeVector %type_u32 3
%type_u32_vec3_ptr    = OpTypePointer Input %type_u32_vec3
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
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
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%id                   = OpVariable %type_u32_vec3_ptr Input
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
%bc_u32_fp_exec_mode = OpConstant %type_u32 458761
%main                 = OpFunction %type_void None %type_voidf
%label                = OpLabel
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 InverseSqrt %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FloatControls2
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %result FPFastMathMode NotNaN|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
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
%type_u32             = OpTypeInt 32 0
%type_i32             = OpTypeInt 32 1
%type_i32_fptr        = OpTypePointer Function %type_i32
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_u32_vec3        = OpTypeVector %type_u32 3
%type_u32_vec3_ptr    = OpTypePointer Input %type_u32_vec3
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
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
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%id                   = OpVariable %type_u32_vec3_ptr Input
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
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 InverseSqrt %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FloatControls2
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
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
%type_u32             = OpTypeInt 32 0
%type_i32             = OpTypeInt 32 1
%type_i32_fptr        = OpTypePointer Function %type_i32
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_u32_vec3        = OpTypeVector %type_u32 3
%type_u32_vec3_ptr    = OpTypePointer Input %type_u32_vec3
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
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
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%id                   = OpVariable %type_u32_vec3_ptr Input
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
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 InverseSqrt %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FloatControls2
OpCapability Float16
OpExtension "SPV_KHR_float_controls2"
%std450            = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpExecutionModeId %main FPFastMathDefault %type_f16 %bc_u32_fp_exec_mode
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %result FPFastMathMode NotInf|NSZ|AllowRecip|AllowContract|AllowReassoc|AllowTransform
OpMemberDecorate %SSBO_in 0 Offset 0
OpDecorate %SSBO_in BufferBlock
OpDecorate %ssbo_in DescriptorSet 0
OpDecorate %ssbo_in Binding 0
OpDecorate %ssbo_in NonWritable
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
%type_u32             = OpTypeInt 32 0
%type_i32             = OpTypeInt 32 1
%type_i32_fptr        = OpTypePointer Function %type_i32
%type_u32_vec2        = OpTypeVector %type_u32 2
%type_u32_vec3        = OpTypeVector %type_u32 3
%type_u32_vec3_ptr    = OpTypePointer Input %type_u32_vec3
%c_i32_0              = OpConstant %type_i32 0
%c_i32_1              = OpConstant %type_i32 1
%c_i32_2              = OpConstant %type_i32 2
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
%type_u32_uptr       = OpTypePointer Uniform %type_u32
%type_u32_arr_1      = OpTypeArray %type_u32 %c_i32_1
%SSBO_in              = OpTypeStruct %type_u32_arr_1
%up_SSBO_in           = OpTypePointer Uniform %SSBO_in
%ssbo_in              = OpVariable %up_SSBO_in Uniform
%SSBO_out             = OpTypeStruct %type_u32_arr_1
%up_SSBO_out          = OpTypePointer Uniform %SSBO_out
%ssbo_out             = OpVariable %up_SSBO_out Uniform
%id                   = OpVariable %type_u32_vec3_ptr Input
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
%argloc            = OpAccessChain %type_u32_uptr %ssbo_in %c_i32_0 %c_i32_0
%inval             = OpLoad %type_u32 %argloc
%arg               = OpBitcast %type_f16_vec2 %inval
%arg1              = OpCompositeExtract %type_f16 %arg 0
%arg2              = OpCompositeExtract %type_f16 %arg 1
%result             = OpExtInst %type_f16 %std450 InverseSqrt %arg1
%result_f16_vec2   = OpCompositeConstruct %type_f16_vec2 %result %c_f16_0
%result_u32 = OpBitcast %type_u32 %result_f16_vec2
%outloc            = OpAccessChain %type_u32_uptr %ssbo_out %c_i32_0 %c_i32_0
OpStore %outloc %result_u32
OpReturn
OpFunctionEnd
