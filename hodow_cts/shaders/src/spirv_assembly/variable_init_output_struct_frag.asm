                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Fragment %main "main" %fragColor %vtxColor %inData
                            OpExecutionMode %main OriginUpperLeft
                            OpSource GLSL 430
                            OpDecorate %fragColor Location 0
                            OpDecorate %vtxColor Location 1
                            OpMemberDecorate %Data 0 ColMajor
                            OpMemberDecorate %Data 0 Offset 0
                            OpMemberDecorate %Data 0 MatrixStride 16
                            OpMemberDecorate %Data 1 Offset 32
                            OpMemberDecorate %Data 2 Offset 48
                            OpMemberDecorate %Data 3 Offset 52
                            OpMemberDecorate %Data 4 Offset 56
                            OpMemberDecorate %Data 5 Offset 60
                            OpMemberDecorate %Output 0 Offset 0
                            OpDecorate %Output Block
                            OpDecorate %dataOutput DescriptorSet 0
                            OpDecorate %dataOutput Binding 0
                            OpDecorate %inData Location 2
                    %void = OpTypeVoid
                %voidFunc = OpTypeFunction %void
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
     %_ptr_Output_v4float = OpTypePointer Output %v4float
               %fragColor = OpVariable %_ptr_Output_v4float Output
      %_ptr_Input_v4float = OpTypePointer Input %v4float
                %vtxColor = OpVariable %_ptr_Input_v4float Input
             %mat2v4float = OpTypeMatrix %v4float 2
                    %Data = OpTypeStruct %mat2v4float %v4float %float %float %float %float
                  %Output = OpTypeStruct %Data
             %_ptr_Output = OpTypePointer StorageBuffer %Output
              %dataOutput = OpVariable %_ptr_Output StorageBuffer
                     %int = OpTypeInt 32 1
                   %int_0 = OpConstant %int 0
               %DataInput = OpTypeStruct %Data
    %_ptr_Input_DataInput = OpTypePointer Input %DataInput
                  %inData = OpVariable %_ptr_Input_DataInput Input
         %_ptr_Input_Data = OpTypePointer Input %Data
               %_ptr_Data = OpTypePointer StorageBuffer %Data
                    %main = OpFunction %void None %voidFunc
                   %entry = OpLabel
               %colorData = OpLoad %v4float %vtxColor
                            OpStore %fragColor %colorData
            %inputDataPtr = OpAccessChain %_ptr_Input_Data %inData %int_0
               %inputData = OpLoad %Data %inputDataPtr
           %outputDataPtr = OpAccessChain %_ptr_Data %dataOutput %int_0
                            OpStore %outputDataPtr %inputData
                            OpReturn
                            OpFunctionEnd
