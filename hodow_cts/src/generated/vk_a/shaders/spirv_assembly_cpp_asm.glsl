                          OpCapability Shader
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                          OpExecutionMode %main LocalSize 1 1 1
                          OpSource GLSL 430
                          OpDecorate %_arr_float_uint_128 ArrayStride 4
                          OpMemberDecorate %Output 0 Offset 0
                          OpDecorate %Output BufferBlock
                          OpDecorate %dataOutput DescriptorSet 0
                          OpDecorate %dataOutput Binding 0
                          OpDecorate %f Aliased
                          OpDecorate %g Aliased
                          OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                  %void = OpTypeVoid
             %void_func = OpTypeFunction %void
                 %float = OpTypeFloat 32
   %_ptr_Function_float = OpTypePointer Function %float
            %func0_decl = OpTypeFunction %float %_ptr_Function_float %_ptr_Function_float
               %float_0 = OpConstant %float 0
               %float_5 = OpConstant %float 5
               %float_2 = OpConstant %float 2
                  %uint = OpTypeInt 32 0
              %uint_128 = OpConstant %uint 128
   %_arr_float_uint_128 = OpTypeArray %float %uint_128
                %Output = OpTypeStruct %_arr_float_uint_128
   %_ptr_Uniform_Output = OpTypePointer Uniform %Output
            %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                   %int = OpTypeInt 32 1
                 %int_0 = OpConstant %int 0
                %v3uint = OpTypeVector %uint 3
     %_ptr_Input_v3uint = OpTypePointer Input %v3uint
 %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
                %uint_0 = OpConstant %uint 0
       %_ptr_Input_uint = OpTypePointer Input %uint
    %_ptr_Uniform_float = OpTypePointer Uniform %float
                  %main = OpFunction %void None %void_func
                 %entry = OpLabel
                     %a = OpVariable %_ptr_Function_float Function %float_0
                     %b = OpVariable %_ptr_Function_float Function %float_0
                     %o = OpVariable %_ptr_Function_float Function %float_0
                  %ret0 = OpFunctionCall %float %func %a %a
                          OpStore %o %ret0
                  %ret1 = OpFunctionCall %float %func %a %b
                 %o_val = OpLoad %float %o
                   %sum = OpFAdd %float %o_val %ret1
            %inv_id_ptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                %inv_id = OpLoad %uint %inv_id_ptr
               %out_ptr = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %inv_id
                          OpStore %out_ptr %sum
                          OpReturn
                          OpFunctionEnd
                  %func = OpFunction %float None %func0_decl
                     %f = OpFunctionParameter %_ptr_Function_float
                     %g = OpFunctionParameter %_ptr_Function_float
            %func_entry = OpLabel
                          OpStore %g %float_5
                          OpStore %f %float_2
                   %ret = OpLoad %float %g
                          OpReturnValue %ret
                          OpFunctionEnd
                          OpCapability Shader
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                          OpExecutionMode %main LocalSize 1 1 1
                          OpSource GLSL 430
                          OpDecorate %_arr_float_uint_128 ArrayStride 4
                          OpMemberDecorate %Output 0 Offset 0
                          OpDecorate %Output BufferBlock
                          OpDecorate %dataOutput DescriptorSet 0
                          OpDecorate %dataOutput Binding 0
                          OpDecorate %f0 Aliased
                          OpDecorate %f1 Aliased
                          OpDecorate %a Aliased
                          OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                  %void = OpTypeVoid
             %void_func = OpTypeFunction %void
                 %float = OpTypeFloat 32
   %_ptr_Function_float = OpTypePointer Function %float
    %_ptr_Private_float = OpTypePointer Private %float
            %func0_decl = OpTypeFunction %float %_ptr_Private_float
            %func1_decl = OpTypeFunction %float %_ptr_Function_float
               %float_0 = OpConstant %float 0
               %float_5 = OpConstant %float 5
               %float_2 = OpConstant %float 2
                  %uint = OpTypeInt 32 0
              %uint_128 = OpConstant %uint 128
   %_arr_float_uint_128 = OpTypeArray %float %uint_128
                %Output = OpTypeStruct %_arr_float_uint_128
   %_ptr_Uniform_Output = OpTypePointer Uniform %Output
            %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                   %int = OpTypeInt 32 1
                 %int_0 = OpConstant %int 0
                %v3uint = OpTypeVector %uint 3
     %_ptr_Input_v3uint = OpTypePointer Input %v3uint
 %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
                %uint_0 = OpConstant %uint 0
       %_ptr_Input_uint = OpTypePointer Input %uint
    %_ptr_Uniform_float = OpTypePointer Uniform %float
                     %a = OpVariable %_ptr_Private_float Private %float_0
                  %main = OpFunction %void None %void_func
                 %entry = OpLabel
                     %b = OpVariable %_ptr_Function_float Function %float_0
                     %o = OpVariable %_ptr_Function_float Function %float_0
                  %ret0 = OpFunctionCall %float %func0 %a
                          OpStore %o %ret0
                  %ret1 = OpFunctionCall %float %func1 %b
                 %o_val = OpLoad %float %o
                   %sum = OpFAdd %float %o_val %ret1
            %inv_id_ptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                %inv_id = OpLoad %uint %inv_id_ptr
               %out_ptr = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %inv_id
                          OpStore %out_ptr %sum
                          OpReturn
                          OpFunctionEnd
                 %func0 = OpFunction %float None %func0_decl
                    %f0 = OpFunctionParameter %_ptr_Private_float
           %func0_entry = OpLabel
                          OpStore %a %float_5
                          OpStore %f0 %float_2
             %func0_ret = OpLoad %float %a
                          OpReturnValue %func0_ret
                          OpFunctionEnd
                 %func1 = OpFunction %float None %func1_decl
                    %f1 = OpFunctionParameter %_ptr_Function_float
           %func1_entry = OpLabel
                          OpStore %a %float_5
                          OpStore %f1 %float_2
             %func1_ret = OpLoad %float %a
                          OpReturnValue %func1_ret
                          OpFunctionEnd
                          OpCapability Shader
                          OpCapability VariablePointersStorageBuffer
                          OpExtension "SPV_KHR_storage_buffer_storage_class"
                          OpExtension "SPV_KHR_variable_pointers"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                          OpExecutionMode %main LocalSize 1 1 1
                          OpSource GLSL 430
                          OpMemberDecorate %Output 0 Offset 0
                          OpMemberDecorate %Output 1 Offset 256
                          OpDecorate %arr_vec4_16 ArrayStride 16
                          OpDecorate %arr_vec4_rt ArrayStride 16
                          OpDecorate %Output Block
                          OpDecorate %dataOutput DescriptorSet 0
                          OpDecorate %dataOutput Binding 0
                          OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                  %void = OpTypeVoid
             %void_func = OpTypeFunction %void
                 %float = OpTypeFloat 32
   %_ptr_Function_float = OpTypePointer Function %float
               %float_5 = OpConstant %float 5
               %float_2 = OpConstant %float 2
                  %uint = OpTypeInt 32 0
    %_ptr_Function_uint = OpTypePointer Function %uint
               %uint_16 = OpConstant %uint 16
                  %vec4 = OpTypeVector %float 4
                %vec4_5 = OpConstantComposite %vec4 %float_5 %float_5 %float_5 %float_5
                %vec4_2 = OpConstantComposite %vec4 %float_2 %float_2 %float_2 %float_2
           %arr_vec4_16 = OpTypeArray %vec4 %uint_16
           %arr_vec4_rt = OpTypeRuntimeArray %vec4
       %arr_vec4_16_ptr = OpTypePointer StorageBuffer %arr_vec4_16
       %arr_vec4_rt_ptr = OpTypePointer StorageBuffer %arr_vec4_rt
            %func0_decl = OpTypeFunction %void %arr_vec4_16_ptr %_ptr_Function_uint
            %func1_decl = OpTypeFunction %void %arr_vec4_rt_ptr %_ptr_Function_uint
                %Output = OpTypeStruct %arr_vec4_16 %arr_vec4_rt
        %_ptr_sb_Output = OpTypePointer StorageBuffer %Output
            %dataOutput = OpVariable %_ptr_sb_Output StorageBuffer
                   %int = OpTypeInt 32 1
                 %int_0 = OpConstant %int 0
                 %int_1 = OpConstant %int 1
                %v3uint = OpTypeVector %uint 3
     %_ptr_Input_v3uint = OpTypePointer Input %v3uint
 %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
                %uint_0 = OpConstant %uint 0
       %_ptr_Input_uint = OpTypePointer Input %uint
          %_ptr_sb_vec4 = OpTypePointer StorageBuffer %vec4
                  %main = OpFunction %void None %void_func
                 %entry = OpLabel
                   %idx = OpVariable %_ptr_Function_uint Function
            %inv_id_ptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                %inv_id = OpLoad %uint %inv_id_ptr
                          OpStore %idx %inv_id
                  %ptr0 = OpAccessChain %arr_vec4_16_ptr %dataOutput %int_0
                  %ptr1 = OpAccessChain %arr_vec4_rt_ptr %dataOutput %int_1
                  %ret0 = OpFunctionCall %void %func0 %ptr0 %idx
                  %ret1 = OpFunctionCall %void %func1 %ptr1 %idx
                          OpReturn
                          OpFunctionEnd
                 %func0 = OpFunction %void None %func0_decl
                    %f0 = OpFunctionParameter %arr_vec4_16_ptr
                    %i0 = OpFunctionParameter %_ptr_Function_uint
           %func0_entry = OpLabel
                  %idx0 = OpLoad %uint %i0
              %out_ptr0 = OpAccessChain %_ptr_sb_vec4 %f0 %idx0
                          OpStore %out_ptr0 %vec4_5
                          OpReturn
                          OpFunctionEnd
                 %func1 = OpFunction %void None %func1_decl
                    %f1 = OpFunctionParameter %arr_vec4_rt_ptr
                    %i1 = OpFunctionParameter %_ptr_Function_uint
           %func1_entry = OpLabel
                  %idx1 = OpLoad %uint %i1
              %out_ptr1 = OpAccessChain %_ptr_sb_vec4 %f1 %idx1
                          OpStore %out_ptr1 %vec4_2
                          OpReturn
                          OpFunctionEnd
                          OpCapability Shader
                          OpCapability VariablePointersStorageBuffer
                          OpExtension "SPV_KHR_variable_pointers"
                          OpExtension "SPV_KHR_storage_buffer_storage_class"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                          OpExecutionMode %main LocalSize 1 1 1
                          OpSource GLSL 430
                          OpMemberDecorate %Output 0 Offset 0
                          OpMemberDecorate %Output 1 Offset 256
                          OpDecorate %arr_vec4_16 ArrayStride 16
                          OpDecorate %arr_vec4_rt ArrayStride 16
                          OpDecorate %Output Block
                          OpDecorate %dataOutput DescriptorSet 0
                          OpDecorate %dataOutput Binding 0
                          OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                  %void = OpTypeVoid
             %void_func = OpTypeFunction %void
                 %float = OpTypeFloat 32
   %_ptr_Function_float = OpTypePointer Function %float
               %float_5 = OpConstant %float 5
               %float_2 = OpConstant %float 2
                  %uint = OpTypeInt 32 0
    %_ptr_Function_uint = OpTypePointer Function %uint
               %uint_16 = OpConstant %uint 16
                  %vec4 = OpTypeVector %float 4
                %vec4_5 = OpConstantComposite %vec4 %float_5 %float_5 %float_5 %float_5
                %vec4_2 = OpConstantComposite %vec4 %float_2 %float_2 %float_2 %float_2
           %arr_vec4_16 = OpTypeArray %vec4 %uint_16
           %arr_vec4_rt = OpTypeRuntimeArray %vec4
       %arr_vec4_16_ptr = OpTypePointer StorageBuffer %arr_vec4_16
       %arr_vec4_rt_ptr = OpTypePointer StorageBuffer %arr_vec4_rt
            %func0_decl = OpTypeFunction %void %arr_vec4_16_ptr %_ptr_Function_uint
            %func1_decl = OpTypeFunction %void %arr_vec4_rt_ptr %_ptr_Function_uint
                %Output = OpTypeStruct %arr_vec4_16 %arr_vec4_rt
        %_ptr_sb_Output = OpTypePointer StorageBuffer %Output
            %dataOutput = OpVariable %_ptr_sb_Output StorageBuffer
                   %int = OpTypeInt 32 1
                 %int_0 = OpConstant %int 0
                 %int_1 = OpConstant %int 1
                %v3uint = OpTypeVector %uint 3
     %_ptr_Input_v3uint = OpTypePointer Input %v3uint
 %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
                %uint_0 = OpConstant %uint 0
       %_ptr_Input_uint = OpTypePointer Input %uint
          %_ptr_sb_vec4 = OpTypePointer StorageBuffer %vec4
                  %main = OpFunction %void None %void_func
                 %entry = OpLabel
                   %idx = OpVariable %_ptr_Function_uint Function
            %inv_id_ptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                %inv_id = OpLoad %uint %inv_id_ptr
                          OpStore %idx %inv_id
                  %ptr0 = OpAccessChain %arr_vec4_16_ptr %dataOutput %int_0
                  %ptr1 = OpAccessChain %arr_vec4_rt_ptr %dataOutput %int_1
                  %ret0 = OpFunctionCall %void %func0 %ptr0 %idx
                  %ret1 = OpFunctionCall %void %func1 %ptr1 %idx
                          OpReturn
                          OpFunctionEnd
                 %func0 = OpFunction %void None %func0_decl
                    %f0 = OpFunctionParameter %arr_vec4_16_ptr
                    %i0 = OpFunctionParameter %_ptr_Function_uint
           %func0_entry = OpLabel
                  %idx0 = OpLoad %uint %i0
              %out_ptr0 = OpAccessChain %_ptr_sb_vec4 %f0 %idx0
                          OpStore %out_ptr0 %vec4_5
                          OpReturn
                          OpFunctionEnd
                 %func1 = OpFunction %void None %func1_decl
                    %f1 = OpFunctionParameter %arr_vec4_rt_ptr
                    %i1 = OpFunctionParameter %_ptr_Function_uint
           %func1_entry = OpLabel
                  %idx1 = OpLoad %uint %i1
              %out_ptr1 = OpAccessChain %_ptr_sb_vec4 %f1 %idx1
                          OpStore %out_ptr1 %vec4_2
                          OpReturn
                          OpFunctionEnd
                          OpCapability Shader
                          OpCapability VariablePointers
                          OpCapability WorkgroupMemoryExplicitLayoutKHR
                          OpExtension "SPV_KHR_variable_pointers"
                          OpExtension "SPV_KHR_storage_buffer_storage_class"
                          OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %dataOutput %sharedData
                          OpExecutionMode %main LocalSize 16 1 1
                          OpSource GLSL 430
                          OpMemberDecorate %Output 0 Offset 0
                          OpMemberDecorate %Output 1 Offset 256
                          OpMemberDecorate %struct 0 Offset 0
                          OpMemberDecorate %struct 1 Offset 256
                          OpDecorate %struct Block
                          OpDecorate %arr_vec4_16 ArrayStride 16
                          OpDecorate %arr_vec4_rt ArrayStride 16
                          OpDecorate %Output Block
                          OpDecorate %dataOutput DescriptorSet 0
                          OpDecorate %dataOutput Binding 0
                          OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                  %void = OpTypeVoid
             %void_func = OpTypeFunction %void
                 %float = OpTypeFloat 32
   %_ptr_Function_float = OpTypePointer Function %float
                  %uint = OpTypeInt 32 0
    %_ptr_Function_uint = OpTypePointer Function %uint
                %uint_1 = OpConstant %uint 1
                %uint_2 = OpConstant %uint 2
                %uint_5 = OpConstant %uint 5
               %uint_16 = OpConstant %uint 16
              %uint_264 = OpConstant %uint 264
                  %vec4 = OpTypeVector %float 4
           %arr_vec4_16 = OpTypeArray %vec4 %uint_16
           %arr_vec4_rt = OpTypeRuntimeArray %vec4
    %arr_vec4_16_sb_ptr = OpTypePointer StorageBuffer %arr_vec4_16
    %arr_vec4_rt_sb_ptr = OpTypePointer StorageBuffer %arr_vec4_rt
    %arr_vec4_16_wg_ptr = OpTypePointer Workgroup %arr_vec4_16
             %func_decl = OpTypeFunction %void %arr_vec4_16_wg_ptr %_ptr_Function_uint
                %Output = OpTypeStruct %arr_vec4_16 %arr_vec4_rt
                %struct = OpTypeStruct %arr_vec4_16 %arr_vec4_16
        %_ptr_sb_struct = OpTypePointer StorageBuffer %Output
        %_ptr_wg_struct = OpTypePointer Workgroup %struct
            %dataOutput = OpVariable %_ptr_sb_struct StorageBuffer
            %sharedData = OpVariable %_ptr_wg_struct Workgroup
                   %int = OpTypeInt 32 1
                 %int_0 = OpConstant %int 0
                 %int_1 = OpConstant %int 1
                %v3uint = OpTypeVector %uint 3
     %_ptr_Input_v3uint = OpTypePointer Input %v3uint
  %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                %uint_0 = OpConstant %uint 0
       %_ptr_Input_uint = OpTypePointer Input %uint
          %_ptr_sb_vec4 = OpTypePointer StorageBuffer %vec4
          %_ptr_wg_vec4 = OpTypePointer Workgroup %vec4
                  %main = OpFunction %void None %void_func
                 %entry = OpLabel
                   %idx = OpVariable %_ptr_Function_uint Function
            %inv_id_ptr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                %inv_id = OpLoad %uint %inv_id_ptr
                          OpStore %idx %inv_id
                  %ptr0 = OpAccessChain %arr_vec4_16_wg_ptr %sharedData %int_0
                  %ptr1 = OpAccessChain %arr_vec4_16_wg_ptr %sharedData %int_1
                  %ret0 = OpFunctionCall %void %func0 %ptr0 %idx
                  %ret1 = OpFunctionCall %void %func1 %ptr1 %idx
                          OpControlBarrier %uint_2 %uint_2 %uint_264
          %inv_id_plus1 = OpIAdd %uint %inv_id %uint_1
            %inv_id_mod = OpUMod %uint %inv_id_plus1 %uint_16
       %shared_arr1_ptr = OpAccessChain %_ptr_wg_vec4 %sharedData %int_1 %inv_id_mod
      %shared_arr1_data = OpLoad %vec4 %shared_arr1_ptr
               %outPtr0 = OpAccessChain %_ptr_sb_vec4 %dataOutput %int_0 %inv_id
                          OpStore %outPtr0 %shared_arr1_data
       %shared_arr0_ptr = OpAccessChain %_ptr_wg_vec4 %sharedData %int_0 %inv_id_mod
      %shared_arr0_data = OpLoad %vec4 %shared_arr0_ptr
               %outPtr1 = OpAccessChain %_ptr_sb_vec4 %dataOutput %int_1 %inv_id
                          OpStore %outPtr1 %shared_arr0_data
                          OpReturn
                          OpFunctionEnd
                 %func0 = OpFunction %void None %func_decl
                    %f0 = OpFunctionParameter %arr_vec4_16_wg_ptr
                    %i0 = OpFunctionParameter %_ptr_Function_uint
           %func0_entry = OpLabel
                  %idx0 = OpLoad %uint %i0
              %out_ptr0 = OpAccessChain %_ptr_wg_vec4 %f0 %idx0
             %idxFloat0 = OpConvertUToF %float %idx0
              %outData0 = OpCompositeConstruct %vec4 %idxFloat0 %idxFloat0 %idxFloat0 %idxFloat0
                          OpStore %out_ptr0 %outData0
                          OpReturn
                          OpFunctionEnd
                 %func1 = OpFunction %void None %func_decl
                    %f1 = OpFunctionParameter %arr_vec4_16_wg_ptr
                    %i1 = OpFunctionParameter %_ptr_Function_uint
           %func1_entry = OpLabel
                  %idx1 = OpLoad %uint %i1
              %out_ptr1 = OpAccessChain %_ptr_wg_vec4 %f1 %idx1
              %idxPlus5 = OpIAdd %uint %idx1 %uint_5
             %idxFloat1 = OpConvertUToF %float %idxPlus5
              %outData1 = OpCompositeConstruct %vec4 %idxFloat1 %idxFloat1 %idxFloat1 %idxFloat1
                          OpStore %out_ptr1 %outData1
                          OpReturn
                          OpFunctionEnd
