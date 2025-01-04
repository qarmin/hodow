                         OpCapability Shader
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 4
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 128
                %outputArray = OpTypeArray %f32 %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %f32
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
              %dataPtr = OpTypePointer Private %f32
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
             %f1 = OpVariable %dataPtr Private %f32_1
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
     %outputData = OpLoad %f32 %f1
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 16
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 32
                %outputArray = OpTypeArray %v4f32 %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %v4f32
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
              %dataPtr = OpTypePointer Private %v4f32
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
             %f1 = OpVariable %dataPtr Private %v4f32_1
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
     %outputData = OpLoad %v4f32 %f1
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 32
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 16
                %outputArray = OpTypeArray %matrix %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %matrix
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
              %dataPtr = OpTypePointer Private %matrix
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
             %f1 = OpVariable %dataPtr Private %matrix_1
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
     %outputData = OpLoad %matrix %f1
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 32
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 16
                %outputArray = OpTypeArray %floatArray %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %floatArray
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
              %dataPtr = OpTypePointer Private %floatArray
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
             %f1 = OpVariable %dataPtr Private %floatArray_1
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
     %outputData = OpLoad %floatArray %f1
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 64
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 8
                %outputArray = OpTypeArray %struct %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %struct
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
              %dataPtr = OpTypePointer Private %struct
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
             %f1 = OpVariable %dataPtr Private %struct_1
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
     %outputData = OpLoad %struct %f1
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                   OpCapability VariablePointers
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                   OpExtension "SPV_KHR_variable_pointers"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 4
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 128
                %outputArray = OpTypeArray %f32 %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %f32
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
        %_ptr_f32_global = OpTypePointer Workgroup %f32
           %f32_global_1 = OpVariable %_ptr_f32_global Workgroup
              %dataPtr = OpTypePointer Private %f32
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
     %dataPtrPtr = OpTypePointer Private %_ptr_f32_global
             %f1 = OpVariable %dataPtrPtr Private %f32_global_1
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
  %outputDataPtr = OpLoad %_ptr_f32_global %f1
                   OpStore %f32_global_1 %f32_1
     %outputData = OpLoad %f32 %outputDataPtr
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                   OpCapability VariablePointers
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                   OpExtension "SPV_KHR_variable_pointers"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 16
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 32
                %outputArray = OpTypeArray %v4f32 %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %v4f32
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
        %_ptr_v4f32_global = OpTypePointer Workgroup %v4f32
           %v4f32_global_1 = OpVariable %_ptr_v4f32_global Workgroup
              %dataPtr = OpTypePointer Private %v4f32
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
     %dataPtrPtr = OpTypePointer Private %_ptr_v4f32_global
             %f1 = OpVariable %dataPtrPtr Private %v4f32_global_1
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
  %outputDataPtr = OpLoad %_ptr_v4f32_global %f1
                   OpStore %v4f32_global_1 %v4f32_1
     %outputData = OpLoad %v4f32 %outputDataPtr
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                   OpCapability VariablePointers
                   OpCapability WorkgroupMemoryExplicitLayoutKHR
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                   OpExtension "SPV_KHR_variable_pointers"
                   OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %dataOutput %f1 %floatArray_global_1
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 32
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                         OpMemberDecorate %_wg_block_floatArray 0 Offset 0
                         OpDecorate %_wg_block_floatArray Block
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 16
                %outputArray = OpTypeArray %floatArray %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %floatArray
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
        %_ptr_floatArray_global = OpTypePointer Workgroup %floatArray
  %_wg_block_floatArray = OpTypeStruct %floatArray
%_ptr_wg_block_floatArray = OpTypePointer Workgroup %_wg_block_floatArray
           %floatArray_global_1 = OpVariable %_ptr_wg_block_floatArray Workgroup
              %dataPtr = OpTypePointer Private %floatArray
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
     %dataPtrPtr = OpTypePointer Private %_ptr_floatArray_global
             %f1 = OpVariable %dataPtrPtr Private
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
   %wgMemberPtr = OpAccessChain %_ptr_floatArray_global %floatArray_global_1 %int_0
                   OpStore %f1 %wgMemberPtr
  %outputDataPtr = OpLoad %_ptr_floatArray_global %f1
                   OpStore %wgMemberPtr %floatArray_1
     %outputData = OpLoad %floatArray %outputDataPtr
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                   OpCapability VariablePointers
                   OpCapability WorkgroupMemoryExplicitLayoutKHR
                         OpExtension "SPV_KHR_storage_buffer_storage_class"
                   OpExtension "SPV_KHR_variable_pointers"
                   OpExtension "SPV_KHR_workgroup_memory_explicit_layout"
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %dataOutput %f1 %struct_global_1
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
OpDecorate %outputArray ArrayStride 64
                               OpMemberDecorate %Output 0 Offset 0
                               OpDecorate %Output Block
                               OpDecorate %dataOutput DescriptorSet 0
                               OpDecorate %dataOutput Binding 0
                         OpMemberDecorate %_wg_block_struct 0 Offset 0
                         OpDecorate %_wg_block_struct Block
                               OpDecorate %floatArray ArrayStride 4
                               OpMemberDecorate %struct 0 Offset 0
                               OpMemberDecorate %struct 1 Offset 32
                               OpMemberDecorate %struct 2 Offset 48
                               OpMemberDecorate %struct 3 Offset 52
                               OpMemberDecorate %struct 4 Offset 56
                               OpMemberDecorate %struct 5 Offset 60
                 %void = OpTypeVoid
             %voidFunc = OpTypeFunction %void
                  %f32 = OpTypeFloat 32
                  %u32 = OpTypeInt 32 0
              %c_u32_0 = OpConstant %u32 0
                %v4f32 = OpTypeVector %f32 4
                      %f32_1 = OpConstant %f32 1
                    %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
                     %matrix = OpTypeMatrix %v4f32 2
                   %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
                    %c_u32_8 = OpConstant %u32 8
                 %floatArray = OpTypeArray %f32 %c_u32_8
               %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                     %struct = OpTypeStruct %floatArray %v4f32 %f32 %f32 %f32 %f32
                   %struct_1 = OpConstantComposite %struct %floatArray_1 %v4f32_1 %f32_1 %f32_1 %f32_1 %f32_1
                %numElements = OpConstant %u32 8
                %outputArray = OpTypeArray %struct %numElements
                     %Output = OpTypeStruct %outputArray
                %_ptr_Output = OpTypePointer StorageBuffer %Output
                      %sbPtr = OpTypePointer StorageBuffer %struct
                 %dataOutput = OpVariable %_ptr_Output StorageBuffer
        %_ptr_struct_global = OpTypePointer Workgroup %struct
  %_wg_block_struct = OpTypeStruct %struct
%_ptr_wg_block_struct = OpTypePointer Workgroup %_wg_block_struct
           %struct_global_1 = OpVariable %_ptr_wg_block_struct Workgroup
              %dataPtr = OpTypePointer Private %struct
   %_ptr_Function_uint = OpTypePointer Function %u32
               %v3uint = OpTypeVector %u32 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
      %_ptr_Input_uint = OpTypePointer Input %u32
                  %int = OpTypeInt 32 1
                %int_0 = OpConstant %int 0
     %dataPtrPtr = OpTypePointer Private %_ptr_struct_global
             %f1 = OpVariable %dataPtrPtr Private
                 %main = OpFunction %void None %voidFunc
                %entry = OpLabel
        %invocationPtr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %c_u32_0
           %invocation = OpLoad %u32 %invocationPtr
   %wgMemberPtr = OpAccessChain %_ptr_struct_global %struct_global_1 %int_0
                   OpStore %f1 %wgMemberPtr
  %outputDataPtr = OpLoad %_ptr_struct_global %f1
                   OpStore %wgMemberPtr %struct_1
     %outputData = OpLoad %struct %outputDataPtr
            %outputPtr = OpAccessChain %sbPtr %dataOutput %int_0 %invocation
                         OpStore %outputPtr %outputData
                         OpReturn
                         OpFunctionEnd
