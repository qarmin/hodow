                       OpCapability Shader
                       OpExtension "SPV_KHR_storage_buffer_storage_class"
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint Fragment %main "main" %fragColor %vtxColor %inData
                       OpExecutionMode %main OriginUpperLeft
                       OpSource GLSL 430
                       OpDecorate %fragColor Location 0
                       OpDecorate %vtxColor Location 1
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %dataOutput DescriptorSet 0
                       OpDecorate %dataOutput Binding 0
                       OpDecorate %inData Location 2
                       OpDecorate %floatArray ArrayStride 4
${extraDecorations}               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                     %u32 = OpTypeInt 32 0
                     %f32 = OpTypeFloat 32
                   %v4f32 = OpTypeVector %f32 4
                  %matrix = OpTypeMatrix %v4f32 2
                 %c_u32_0 = OpConstant %u32 0
                 %c_u32_8 = OpConstant %u32 8
              %floatArray = OpTypeArray %f32 %c_u32_8
           %inputPtr = OpTypePointer Input %${type}
             %inData = OpVariable %inputPtr Input
  %_ptr_Output_v4f32 = OpTypePointer Output %v4f32
          %fragColor = OpVariable %_ptr_Output_v4f32 Output
${vec4ptrDeclInput}           %vtxColor = OpVariable %${vec4ptrInput} Input
             %Output = OpTypeStruct %${type}
        %_ptr_Output = OpTypePointer StorageBuffer %Output
         %dataOutput = OpVariable %_ptr_Output StorageBuffer
          %outputPtr = OpTypePointer StorageBuffer %${type}
               %main = OpFunction %void None %3
              %entry = OpLabel
          %colorData = OpLoad %v4f32 %vtxColor
                       OpStore %fragColor %colorData
          %inputData = OpLoad %${type} %inData
      %outputDataPtr = OpAccessChain %outputPtr %dataOutput %c_u32_0
                       OpStore %outputDataPtr %inputData
                       OpReturn
                       OpFunctionEnd
