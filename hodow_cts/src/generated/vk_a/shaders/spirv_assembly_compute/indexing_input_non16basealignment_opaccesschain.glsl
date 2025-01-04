                             OpCapability Shader
                             OpCapability VariablePointersStorageBuffer
                             OpExtension "SPV_KHR_variable_pointers"
                             OpExtension "SPV_KHR_storage_buffer_storage_class"
                        %1 = OpExtInstImport "GLSL.std.450"
                             OpMemoryModel Logical GLSL450
                             OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                             OpExecutionMode %main LocalSize 1 1 1
                             OpSource GLSL 430
                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                             OpDecorate %input_array ArrayStride 4
                             OpDecorate %output_array ArrayStride 4
                             OpDecorate %runtimearr_struct1 ArrayStride 72
                             OpDecorate %_ptr_struct1_sb ArrayStride 72
                             OpMemberDecorate %Output 0 Offset 0
                             OpDecorate %Output Block
                             OpDecorate %dataOutput DescriptorSet 0
                             OpDecorate %dataOutput Binding 1
                             OpMemberDecorate %struct0 0 Offset 0
                             OpMemberDecorate %struct1 0 Offset 0
                             OpDecorate %struct0 Block
                             OpDecorate %dataInput DescriptorSet 0
                             OpDecorate %dataInput Binding 0
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                      %u32 = OpTypeInt 32 0
                      %i32 = OpTypeInt 32 1
     %_ptr_Function_uint32 = OpTypePointer Function %u32
                 %v3uint32 = OpTypeVector %u32 3
      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32
    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input
        %_ptr_Input_uint32 = OpTypePointer Input %u32
                    %float = OpTypeFloat 32
%uint_0 = OpConstant %u32 0
%uint_1 = OpConstant %u32 1
%uint_2 = OpConstant %u32 2
%uint_3 = OpConstant %u32 3
%uint_4 = OpConstant %u32 4
%uint_5 = OpConstant %u32 5
%uint_6 = OpConstant %u32 6
%uint_7 = OpConstant %u32 7
%uint_8 = OpConstant %u32 8
%uint_9 = OpConstant %u32 9
%uint_10 = OpConstant %u32 10
%uint_11 = OpConstant %u32 11
%uint_12 = OpConstant %u32 12
%uint_13 = OpConstant %u32 13
%uint_14 = OpConstant %u32 14
%uint_15 = OpConstant %u32 15
%uint_16 = OpConstant %u32 16
%uint_17 = OpConstant %u32 17
%uint_18 = OpConstant %u32 18
                  %uint_32 = OpConstant %u32 32
              %input_array = OpTypeArray %float %uint_18
             %output_array = OpTypeArray %float %uint_32
                   %Output = OpTypeStruct %output_array
           %_ptr_sb_Output = OpTypePointer StorageBuffer %Output
               %dataOutput = OpVariable %_ptr_sb_Output StorageBuffer
                  %struct1 = OpTypeStruct %input_array
       %runtimearr_struct1 = OpTypeRuntimeArray %struct1
                  %struct0 = OpTypeStruct %runtimearr_struct1
          %_ptr_struct0_sb = OpTypePointer StorageBuffer %struct0
          %_ptr_struct1_sb = OpTypePointer StorageBuffer %struct1
            %_ptr_float_sb = OpTypePointer StorageBuffer %float
                %dataInput = OpVariable %_ptr_struct0_sb StorageBuffer
                     %main = OpFunction %void None %3
                    %entry = OpLabel
                     %base = OpAccessChain %_ptr_struct1_sb %dataInput %uint_0 %uint_0
                %invid_ptr = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %uint_0
                    %invid = OpLoad %u32 %invid_ptr
%dataPtr0 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_0
%acc0 = OpLoad %float %dataPtr0
%dataPtr1 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_1
%tmp1 = OpLoad %float %dataPtr1
%acc1 = OpFAdd %float %tmp1 %acc0
%dataPtr2 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_2
%tmp2 = OpLoad %float %dataPtr2
%acc2 = OpFAdd %float %tmp2 %acc1
%dataPtr3 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_3
%tmp3 = OpLoad %float %dataPtr3
%acc3 = OpFAdd %float %tmp3 %acc2
%dataPtr4 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_4
%tmp4 = OpLoad %float %dataPtr4
%acc4 = OpFAdd %float %tmp4 %acc3
%dataPtr5 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_5
%tmp5 = OpLoad %float %dataPtr5
%acc5 = OpFAdd %float %tmp5 %acc4
%dataPtr6 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_6
%tmp6 = OpLoad %float %dataPtr6
%acc6 = OpFAdd %float %tmp6 %acc5
%dataPtr7 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_7
%tmp7 = OpLoad %float %dataPtr7
%acc7 = OpFAdd %float %tmp7 %acc6
%dataPtr8 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_8
%tmp8 = OpLoad %float %dataPtr8
%acc8 = OpFAdd %float %tmp8 %acc7
%dataPtr9 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_9
%tmp9 = OpLoad %float %dataPtr9
%acc9 = OpFAdd %float %tmp9 %acc8
%dataPtr10 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_10
%tmp10 = OpLoad %float %dataPtr10
%acc10 = OpFAdd %float %tmp10 %acc9
%dataPtr11 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_11
%tmp11 = OpLoad %float %dataPtr11
%acc11 = OpFAdd %float %tmp11 %acc10
%dataPtr12 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_12
%tmp12 = OpLoad %float %dataPtr12
%acc12 = OpFAdd %float %tmp12 %acc11
%dataPtr13 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_13
%tmp13 = OpLoad %float %dataPtr13
%acc13 = OpFAdd %float %tmp13 %acc12
%dataPtr14 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_14
%tmp14 = OpLoad %float %dataPtr14
%acc14 = OpFAdd %float %tmp14 %acc13
%dataPtr15 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_15
%tmp15 = OpLoad %float %dataPtr15
%acc15 = OpFAdd %float %tmp15 %acc14
%dataPtr16 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_16
%tmp16 = OpLoad %float %dataPtr16
%acc16 = OpFAdd %float %tmp16 %acc15
%dataPtr17 = OpAccessChain %_ptr_float_sb %dataInput %uint_0 %invid %uint_0 %uint_17
%tmp17 = OpLoad %float %dataPtr17
%acc17 = OpFAdd %float %tmp17 %acc16
                   %outPtr = OpAccessChain %_ptr_float_sb %dataOutput %uint_0 %invid
                             OpStore %outPtr %acc17
                             OpReturn
                             OpFunctionEnd
