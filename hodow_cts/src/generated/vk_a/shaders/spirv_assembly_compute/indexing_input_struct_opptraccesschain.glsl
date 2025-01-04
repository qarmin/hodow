                             OpCapability Shader
                             OpCapability Int16
                             OpCapability VariablePointersStorageBuffer
                             OpExtension "SPV_KHR_variable_pointers"
                             OpExtension "SPV_KHR_storage_buffer_storage_class"
                        %1 = OpExtInstImport "GLSL.std.450"
                             OpMemoryModel Logical GLSL450
                             OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                             OpExecutionMode %main LocalSize 1 1 1
                             OpSource GLSL 430
                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                             OpDecorate %_arr_float_uint_128 ArrayStride 4
                             OpMemberDecorate %Output 0 Offset 0
                             OpDecorate %Output BufferBlock
                             OpDecorate %dataOutput DescriptorSet 0
                             OpDecorate %dataOutput Binding 2
                             OpDecorate %_arr_v4float_uint_4 ArrayStride 16
                             OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64
                             OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048
                             OpMemberDecorate %InputStruct 0 Offset 0
                             OpDecorate %InputStructArr ArrayStride 65536
                             OpDecorate %Input Block
                             OpMemberDecorate %Input 0 Offset 0
                             OpDecorate %dataInput DescriptorSet 0
                             OpDecorate %dataInput Binding 0
                             OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536
                             OpDecorate %_arr_v4uint_uint_128 ArrayStride 16
                             OpMemberDecorate %DataSelector 0 Offset 0
                             OpDecorate %DataSelector BufferBlock
                             OpDecorate %selector DescriptorSet 0
                             OpDecorate %selector Binding 1
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                      %u32 = OpTypeInt 32 0
                      %i32 = OpTypeInt 32 1
                      %u16 = OpTypeInt 16 0
                      %i16 = OpTypeInt 16 1
                    %idx_0 = OpConstant %u16 0
                    %idx_1 = OpConstant %u16 1
                    %idx_2 = OpConstant %u16 2
                    %idx_3 = OpConstant %u16 3
     %_ptr_Function_uint32 = OpTypePointer Function %u32
                 %v3uint32 = OpTypeVector %u32 3
      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32
    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input
        %_ptr_Input_uint32 = OpTypePointer Input %u32
                    %float = OpTypeFloat 32
                 %uint_128 = OpConstant %u32 128
                  %uint_32 = OpConstant %u32 32
                   %uint_2 = OpConstant %u32 2
                   %uint_4 = OpConstant %u32 4
      %_arr_float_uint_128 = OpTypeArray %float %uint_128
                   %Output = OpTypeStruct %_arr_float_uint_128
      %_ptr_Uniform_Output = OpTypePointer Uniform %Output
               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                  %v4float = OpTypeVector %float 4
      %_arr_v4float_uint_4 = OpTypeArray %v4float %uint_4
 %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32
 %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32
              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32
           %InputStructArr = OpTypeArray %InputStruct %uint_2
                    %Input = OpTypeStruct %InputStructArr
        %_ptr_buffer_Input = OpTypePointer StorageBuffer %Input
                %dataInput = OpVariable %_ptr_buffer_Input StorageBuffer
  %_ptr_buffer_InputStruct = OpTypePointer StorageBuffer %InputStruct
                 %v4uint32 = OpTypeVector %u32 4
     %_arr_v4uint_uint_128 = OpTypeArray %v4uint32 %uint_128
             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128
%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector
                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform
      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32
       %_ptr_Uniform_float = OpTypePointer Uniform %float
       %_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
                     %main = OpFunction %void None %3
                        %5 = OpLabel
                        %i = OpVariable %_ptr_Function_uint32 Function
                       %14 = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %idx_0
                       %15 = OpLoad %u32 %14
                             OpStore %i %15
                   %uint_i = OpLoad %u32 %i
                       %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_0
                       %40 = OpLoad %u32 %39
                       %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_1
                       %44 = OpLoad %u32 %43
                       %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_2
                       %48 = OpLoad %u32 %47
                       %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_3
                       %52 = OpLoad %u32 %51
                       %i0 = OpSConvert %u16 %40
                       %i1 = OpSConvert %u16 %44
                       %i2 = OpSConvert %u16 %48
                       %i3 = OpSConvert %u16 %52
        %inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %idx_0 %idx_0
                       %54 = OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %idx_1 %idx_0 %i0 %i1 %i2 %i3

                       %55 = OpLoad %float %54
                       %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %idx_0 %uint_i
                             OpStore %56 %55
                             OpReturn
                             OpFunctionEnd
                             OpCapability Shader
                             OpCapability Int16
                             OpCapability VariablePointersStorageBuffer
                             OpExtension "SPV_KHR_variable_pointers"
                             OpExtension "SPV_KHR_storage_buffer_storage_class"
                        %1 = OpExtInstImport "GLSL.std.450"
                             OpMemoryModel Logical GLSL450
                             OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                             OpExecutionMode %main LocalSize 1 1 1
                             OpSource GLSL 430
                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                             OpDecorate %_arr_float_uint_128 ArrayStride 4
                             OpMemberDecorate %Output 0 Offset 0
                             OpDecorate %Output BufferBlock
                             OpDecorate %dataOutput DescriptorSet 0
                             OpDecorate %dataOutput Binding 2
                             OpDecorate %_arr_v4float_uint_4 ArrayStride 16
                             OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64
                             OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048
                             OpMemberDecorate %InputStruct 0 Offset 0
                             OpDecorate %InputStructArr ArrayStride 65536
                             OpDecorate %Input Block
                             OpMemberDecorate %Input 0 Offset 0
                             OpDecorate %dataInput DescriptorSet 0
                             OpDecorate %dataInput Binding 0
                             OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536
                             OpDecorate %_arr_v4uint_uint_128 ArrayStride 16
                             OpMemberDecorate %DataSelector 0 Offset 0
                             OpDecorate %DataSelector BufferBlock
                             OpDecorate %selector DescriptorSet 0
                             OpDecorate %selector Binding 1
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                      %u32 = OpTypeInt 32 0
                      %i32 = OpTypeInt 32 1
                      %u16 = OpTypeInt 16 0
                      %i16 = OpTypeInt 16 1
                    %idx_0 = OpConstant %i16 0
                    %idx_1 = OpConstant %i16 1
                    %idx_2 = OpConstant %i16 2
                    %idx_3 = OpConstant %i16 3
     %_ptr_Function_uint32 = OpTypePointer Function %u32
                 %v3uint32 = OpTypeVector %u32 3
      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32
    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input
        %_ptr_Input_uint32 = OpTypePointer Input %u32
                    %float = OpTypeFloat 32
                 %uint_128 = OpConstant %u32 128
                  %uint_32 = OpConstant %u32 32
                   %uint_2 = OpConstant %u32 2
                   %uint_4 = OpConstant %u32 4
      %_arr_float_uint_128 = OpTypeArray %float %uint_128
                   %Output = OpTypeStruct %_arr_float_uint_128
      %_ptr_Uniform_Output = OpTypePointer Uniform %Output
               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                  %v4float = OpTypeVector %float 4
      %_arr_v4float_uint_4 = OpTypeArray %v4float %uint_4
 %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32
 %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32
              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32
           %InputStructArr = OpTypeArray %InputStruct %uint_2
                    %Input = OpTypeStruct %InputStructArr
        %_ptr_buffer_Input = OpTypePointer StorageBuffer %Input
                %dataInput = OpVariable %_ptr_buffer_Input StorageBuffer
  %_ptr_buffer_InputStruct = OpTypePointer StorageBuffer %InputStruct
                 %v4uint32 = OpTypeVector %u32 4
     %_arr_v4uint_uint_128 = OpTypeArray %v4uint32 %uint_128
             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128
%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector
                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform
      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32
       %_ptr_Uniform_float = OpTypePointer Uniform %float
       %_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
                     %main = OpFunction %void None %3
                        %5 = OpLabel
                        %i = OpVariable %_ptr_Function_uint32 Function
                       %14 = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %idx_0
                       %15 = OpLoad %u32 %14
                             OpStore %i %15
                   %uint_i = OpLoad %u32 %i
                       %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_0
                       %40 = OpLoad %u32 %39
                       %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_1
                       %44 = OpLoad %u32 %43
                       %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_2
                       %48 = OpLoad %u32 %47
                       %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_3
                       %52 = OpLoad %u32 %51
                       %i0 = OpSConvert %i16 %40
                       %i1 = OpSConvert %i16 %44
                       %i2 = OpSConvert %i16 %48
                       %i3 = OpSConvert %i16 %52
        %inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %idx_0 %idx_0
                       %54 = OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %idx_1 %idx_0 %i0 %i1 %i2 %i3

                       %55 = OpLoad %float %54
                       %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %idx_0 %uint_i
                             OpStore %56 %55
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
                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                             OpDecorate %_arr_float_uint_128 ArrayStride 4
                             OpMemberDecorate %Output 0 Offset 0
                             OpDecorate %Output BufferBlock
                             OpDecorate %dataOutput DescriptorSet 0
                             OpDecorate %dataOutput Binding 2
                             OpDecorate %_arr_v4float_uint_4 ArrayStride 16
                             OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64
                             OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048
                             OpMemberDecorate %InputStruct 0 Offset 0
                             OpDecorate %InputStructArr ArrayStride 65536
                             OpDecorate %Input Block
                             OpMemberDecorate %Input 0 Offset 0
                             OpDecorate %dataInput DescriptorSet 0
                             OpDecorate %dataInput Binding 0
                             OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536
                             OpDecorate %_arr_v4uint_uint_128 ArrayStride 16
                             OpMemberDecorate %DataSelector 0 Offset 0
                             OpDecorate %DataSelector BufferBlock
                             OpDecorate %selector DescriptorSet 0
                             OpDecorate %selector Binding 1
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                      %u32 = OpTypeInt 32 0
                      %i32 = OpTypeInt 32 1
                    %idx_0 = OpConstant %u32 0
                    %idx_1 = OpConstant %u32 1
                    %idx_2 = OpConstant %u32 2
                    %idx_3 = OpConstant %u32 3
     %_ptr_Function_uint32 = OpTypePointer Function %u32
                 %v3uint32 = OpTypeVector %u32 3
      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32
    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input
        %_ptr_Input_uint32 = OpTypePointer Input %u32
                    %float = OpTypeFloat 32
                 %uint_128 = OpConstant %u32 128
                  %uint_32 = OpConstant %u32 32
                   %uint_2 = OpConstant %u32 2
                   %uint_4 = OpConstant %u32 4
      %_arr_float_uint_128 = OpTypeArray %float %uint_128
                   %Output = OpTypeStruct %_arr_float_uint_128
      %_ptr_Uniform_Output = OpTypePointer Uniform %Output
               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                  %v4float = OpTypeVector %float 4
      %_arr_v4float_uint_4 = OpTypeArray %v4float %uint_4
 %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32
 %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32
              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32
           %InputStructArr = OpTypeArray %InputStruct %uint_2
                    %Input = OpTypeStruct %InputStructArr
        %_ptr_buffer_Input = OpTypePointer StorageBuffer %Input
                %dataInput = OpVariable %_ptr_buffer_Input StorageBuffer
  %_ptr_buffer_InputStruct = OpTypePointer StorageBuffer %InputStruct
                 %v4uint32 = OpTypeVector %u32 4
     %_arr_v4uint_uint_128 = OpTypeArray %v4uint32 %uint_128
             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128
%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector
                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform
      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32
       %_ptr_Uniform_float = OpTypePointer Uniform %float
       %_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
                     %main = OpFunction %void None %3
                        %5 = OpLabel
                        %i = OpVariable %_ptr_Function_uint32 Function
                       %14 = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %idx_0
                       %15 = OpLoad %u32 %14
                             OpStore %i %15
                   %uint_i = OpLoad %u32 %i
                       %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_0
                       %40 = OpLoad %u32 %39
                       %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_1
                       %44 = OpLoad %u32 %43
                       %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_2
                       %48 = OpLoad %u32 %47
                       %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_3
                       %52 = OpLoad %u32 %51
                       %i0 = OpBitcast %u32 %40
                       %i1 = OpBitcast %u32 %44
                       %i2 = OpBitcast %u32 %48
                       %i3 = OpBitcast %u32 %52
        %inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %idx_0 %idx_0
                       %54 = OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %idx_1 %idx_0 %i0 %i1 %i2 %i3

                       %55 = OpLoad %float %54
                       %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %idx_0 %uint_i
                             OpStore %56 %55
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
                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                             OpDecorate %_arr_float_uint_128 ArrayStride 4
                             OpMemberDecorate %Output 0 Offset 0
                             OpDecorate %Output BufferBlock
                             OpDecorate %dataOutput DescriptorSet 0
                             OpDecorate %dataOutput Binding 2
                             OpDecorate %_arr_v4float_uint_4 ArrayStride 16
                             OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64
                             OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048
                             OpMemberDecorate %InputStruct 0 Offset 0
                             OpDecorate %InputStructArr ArrayStride 65536
                             OpDecorate %Input Block
                             OpMemberDecorate %Input 0 Offset 0
                             OpDecorate %dataInput DescriptorSet 0
                             OpDecorate %dataInput Binding 0
                             OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536
                             OpDecorate %_arr_v4uint_uint_128 ArrayStride 16
                             OpMemberDecorate %DataSelector 0 Offset 0
                             OpDecorate %DataSelector BufferBlock
                             OpDecorate %selector DescriptorSet 0
                             OpDecorate %selector Binding 1
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                      %u32 = OpTypeInt 32 0
                      %i32 = OpTypeInt 32 1
                    %idx_0 = OpConstant %i32 0
                    %idx_1 = OpConstant %i32 1
                    %idx_2 = OpConstant %i32 2
                    %idx_3 = OpConstant %i32 3
     %_ptr_Function_uint32 = OpTypePointer Function %u32
                 %v3uint32 = OpTypeVector %u32 3
      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32
    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input
        %_ptr_Input_uint32 = OpTypePointer Input %u32
                    %float = OpTypeFloat 32
                 %uint_128 = OpConstant %u32 128
                  %uint_32 = OpConstant %u32 32
                   %uint_2 = OpConstant %u32 2
                   %uint_4 = OpConstant %u32 4
      %_arr_float_uint_128 = OpTypeArray %float %uint_128
                   %Output = OpTypeStruct %_arr_float_uint_128
      %_ptr_Uniform_Output = OpTypePointer Uniform %Output
               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                  %v4float = OpTypeVector %float 4
      %_arr_v4float_uint_4 = OpTypeArray %v4float %uint_4
 %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32
 %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32
              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32
           %InputStructArr = OpTypeArray %InputStruct %uint_2
                    %Input = OpTypeStruct %InputStructArr
        %_ptr_buffer_Input = OpTypePointer StorageBuffer %Input
                %dataInput = OpVariable %_ptr_buffer_Input StorageBuffer
  %_ptr_buffer_InputStruct = OpTypePointer StorageBuffer %InputStruct
                 %v4uint32 = OpTypeVector %u32 4
     %_arr_v4uint_uint_128 = OpTypeArray %v4uint32 %uint_128
             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128
%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector
                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform
      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32
       %_ptr_Uniform_float = OpTypePointer Uniform %float
       %_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
                     %main = OpFunction %void None %3
                        %5 = OpLabel
                        %i = OpVariable %_ptr_Function_uint32 Function
                       %14 = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %idx_0
                       %15 = OpLoad %u32 %14
                             OpStore %i %15
                   %uint_i = OpLoad %u32 %i
                       %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_0
                       %40 = OpLoad %u32 %39
                       %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_1
                       %44 = OpLoad %u32 %43
                       %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_2
                       %48 = OpLoad %u32 %47
                       %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_3
                       %52 = OpLoad %u32 %51
                       %i0 = OpBitcast %i32 %40
                       %i1 = OpBitcast %i32 %44
                       %i2 = OpBitcast %i32 %48
                       %i3 = OpBitcast %i32 %52
        %inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %idx_0 %idx_0
                       %54 = OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %idx_1 %idx_0 %i0 %i1 %i2 %i3

                       %55 = OpLoad %float %54
                       %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %idx_0 %uint_i
                             OpStore %56 %55
                             OpReturn
                             OpFunctionEnd
                             OpCapability Shader
                             OpCapability Int64
                             OpCapability VariablePointersStorageBuffer
                             OpExtension "SPV_KHR_variable_pointers"
                             OpExtension "SPV_KHR_storage_buffer_storage_class"
                        %1 = OpExtInstImport "GLSL.std.450"
                             OpMemoryModel Logical GLSL450
                             OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                             OpExecutionMode %main LocalSize 1 1 1
                             OpSource GLSL 430
                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                             OpDecorate %_arr_float_uint_128 ArrayStride 4
                             OpMemberDecorate %Output 0 Offset 0
                             OpDecorate %Output BufferBlock
                             OpDecorate %dataOutput DescriptorSet 0
                             OpDecorate %dataOutput Binding 2
                             OpDecorate %_arr_v4float_uint_4 ArrayStride 16
                             OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64
                             OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048
                             OpMemberDecorate %InputStruct 0 Offset 0
                             OpDecorate %InputStructArr ArrayStride 65536
                             OpDecorate %Input Block
                             OpMemberDecorate %Input 0 Offset 0
                             OpDecorate %dataInput DescriptorSet 0
                             OpDecorate %dataInput Binding 0
                             OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536
                             OpDecorate %_arr_v4uint_uint_128 ArrayStride 16
                             OpMemberDecorate %DataSelector 0 Offset 0
                             OpDecorate %DataSelector BufferBlock
                             OpDecorate %selector DescriptorSet 0
                             OpDecorate %selector Binding 1
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                      %u32 = OpTypeInt 32 0
                      %i32 = OpTypeInt 32 1
                      %u64 = OpTypeInt 64 0
                      %i64 = OpTypeInt 64 1
                    %idx_0 = OpConstant %u64 0
                    %idx_1 = OpConstant %u64 1
                    %idx_2 = OpConstant %u64 2
                    %idx_3 = OpConstant %u64 3
     %_ptr_Function_uint32 = OpTypePointer Function %u32
                 %v3uint32 = OpTypeVector %u32 3
      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32
    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input
        %_ptr_Input_uint32 = OpTypePointer Input %u32
                    %float = OpTypeFloat 32
                 %uint_128 = OpConstant %u32 128
                  %uint_32 = OpConstant %u32 32
                   %uint_2 = OpConstant %u32 2
                   %uint_4 = OpConstant %u32 4
      %_arr_float_uint_128 = OpTypeArray %float %uint_128
                   %Output = OpTypeStruct %_arr_float_uint_128
      %_ptr_Uniform_Output = OpTypePointer Uniform %Output
               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                  %v4float = OpTypeVector %float 4
      %_arr_v4float_uint_4 = OpTypeArray %v4float %uint_4
 %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32
 %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32
              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32
           %InputStructArr = OpTypeArray %InputStruct %uint_2
                    %Input = OpTypeStruct %InputStructArr
        %_ptr_buffer_Input = OpTypePointer StorageBuffer %Input
                %dataInput = OpVariable %_ptr_buffer_Input StorageBuffer
  %_ptr_buffer_InputStruct = OpTypePointer StorageBuffer %InputStruct
                 %v4uint32 = OpTypeVector %u32 4
     %_arr_v4uint_uint_128 = OpTypeArray %v4uint32 %uint_128
             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128
%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector
                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform
      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32
       %_ptr_Uniform_float = OpTypePointer Uniform %float
       %_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
                     %main = OpFunction %void None %3
                        %5 = OpLabel
                        %i = OpVariable %_ptr_Function_uint32 Function
                       %14 = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %idx_0
                       %15 = OpLoad %u32 %14
                             OpStore %i %15
                   %uint_i = OpLoad %u32 %i
                       %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_0
                       %40 = OpLoad %u32 %39
                       %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_1
                       %44 = OpLoad %u32 %43
                       %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_2
                       %48 = OpLoad %u32 %47
                       %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_3
                       %52 = OpLoad %u32 %51
                       %i0 = OpSConvert %u64 %40
                       %i1 = OpSConvert %u64 %44
                       %i2 = OpSConvert %u64 %48
                       %i3 = OpSConvert %u64 %52
        %inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %idx_0 %idx_0
                       %54 = OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %idx_1 %idx_0 %i0 %i1 %i2 %i3

                       %55 = OpLoad %float %54
                       %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %idx_0 %uint_i
                             OpStore %56 %55
                             OpReturn
                             OpFunctionEnd
                             OpCapability Shader
                             OpCapability Int64
                             OpCapability VariablePointersStorageBuffer
                             OpExtension "SPV_KHR_variable_pointers"
                             OpExtension "SPV_KHR_storage_buffer_storage_class"
                        %1 = OpExtInstImport "GLSL.std.450"
                             OpMemoryModel Logical GLSL450
                             OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                             OpExecutionMode %main LocalSize 1 1 1
                             OpSource GLSL 430
                             OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                             OpDecorate %_arr_float_uint_128 ArrayStride 4
                             OpMemberDecorate %Output 0 Offset 0
                             OpDecorate %Output BufferBlock
                             OpDecorate %dataOutput DescriptorSet 0
                             OpDecorate %dataOutput Binding 2
                             OpDecorate %_arr_v4float_uint_4 ArrayStride 16
                             OpDecorate %_arr_mat4v4float_uint_32 ArrayStride 64
                             OpDecorate %_arr__arr_mat4v4float_uint_32_uint_32 ArrayStride 2048
                             OpMemberDecorate %InputStruct 0 Offset 0
                             OpDecorate %InputStructArr ArrayStride 65536
                             OpDecorate %Input Block
                             OpMemberDecorate %Input 0 Offset 0
                             OpDecorate %dataInput DescriptorSet 0
                             OpDecorate %dataInput Binding 0
                             OpDecorate %_ptr_buffer_InputStruct ArrayStride 65536
                             OpDecorate %_arr_v4uint_uint_128 ArrayStride 16
                             OpMemberDecorate %DataSelector 0 Offset 0
                             OpDecorate %DataSelector BufferBlock
                             OpDecorate %selector DescriptorSet 0
                             OpDecorate %selector Binding 1
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                      %u32 = OpTypeInt 32 0
                      %i32 = OpTypeInt 32 1
                      %u64 = OpTypeInt 64 0
                      %i64 = OpTypeInt 64 1
                    %idx_0 = OpConstant %i64 0
                    %idx_1 = OpConstant %i64 1
                    %idx_2 = OpConstant %i64 2
                    %idx_3 = OpConstant %i64 3
     %_ptr_Function_uint32 = OpTypePointer Function %u32
                 %v3uint32 = OpTypeVector %u32 3
      %_ptr_Input_v3uint32 = OpTypePointer Input %v3uint32
    %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint32 Input
        %_ptr_Input_uint32 = OpTypePointer Input %u32
                    %float = OpTypeFloat 32
                 %uint_128 = OpConstant %u32 128
                  %uint_32 = OpConstant %u32 32
                   %uint_2 = OpConstant %u32 2
                   %uint_4 = OpConstant %u32 4
      %_arr_float_uint_128 = OpTypeArray %float %uint_128
                   %Output = OpTypeStruct %_arr_float_uint_128
      %_ptr_Uniform_Output = OpTypePointer Uniform %Output
               %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                  %v4float = OpTypeVector %float 4
      %_arr_v4float_uint_4 = OpTypeArray %v4float %uint_4
 %_arr_mat4v4float_uint_32 = OpTypeArray %_arr_v4float_uint_4 %uint_32
 %_arr__arr_mat4v4float_uint_32_uint_32 = OpTypeArray %_arr_mat4v4float_uint_32 %uint_32
              %InputStruct = OpTypeStruct %_arr__arr_mat4v4float_uint_32_uint_32
           %InputStructArr = OpTypeArray %InputStruct %uint_2
                    %Input = OpTypeStruct %InputStructArr
        %_ptr_buffer_Input = OpTypePointer StorageBuffer %Input
                %dataInput = OpVariable %_ptr_buffer_Input StorageBuffer
  %_ptr_buffer_InputStruct = OpTypePointer StorageBuffer %InputStruct
                 %v4uint32 = OpTypeVector %u32 4
     %_arr_v4uint_uint_128 = OpTypeArray %v4uint32 %uint_128
             %DataSelector = OpTypeStruct %_arr_v4uint_uint_128
%_ptr_Uniform_DataSelector = OpTypePointer Uniform %DataSelector
                 %selector = OpVariable %_ptr_Uniform_DataSelector Uniform
      %_ptr_Uniform_uint32 = OpTypePointer Uniform %u32
       %_ptr_Uniform_float = OpTypePointer Uniform %float
       %_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
                     %main = OpFunction %void None %3
                        %5 = OpLabel
                        %i = OpVariable %_ptr_Function_uint32 Function
                       %14 = OpAccessChain %_ptr_Input_uint32 %gl_GlobalInvocationID %idx_0
                       %15 = OpLoad %u32 %14
                             OpStore %i %15
                   %uint_i = OpLoad %u32 %i
                       %39 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_0
                       %40 = OpLoad %u32 %39
                       %43 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_1
                       %44 = OpLoad %u32 %43
                       %47 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_2
                       %48 = OpLoad %u32 %47
                       %51 = OpAccessChain %_ptr_Uniform_uint32 %selector %idx_0 %uint_i %idx_3
                       %52 = OpLoad %u32 %51
                       %i0 = OpSConvert %i64 %40
                       %i1 = OpSConvert %i64 %44
                       %i2 = OpSConvert %i64 %48
                       %i3 = OpSConvert %i64 %52
        %inputFirstElement = OpAccessChain %_ptr_buffer_InputStruct %dataInput %idx_0 %idx_0
                       %54 = OpPtrAccessChain %_ptr_StorageBuffer_float %inputFirstElement %idx_1 %idx_0 %i0 %i1 %i2 %i3

                       %55 = OpLoad %float %54
                       %56 = OpAccessChain %_ptr_Uniform_float %dataOutput %idx_0 %uint_i
                             OpStore %56 %55
                             OpReturn
                             OpFunctionEnd
