                        OpCapability Shader
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint Fragment %main "main" %dataIn %fragColor %vtxColor
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 450
                        OpName %main "main"
                        OpName %Output "Output"
                        OpMemberName %Output 0 "dataOut"
                        OpName %dataOutput "dataOutput"
${OPNAME_FRAG}                        OpName %fragColor "fragColor"
                        OpName %vtxColor "vtxColor"
                        OpMemberDecorate %Output 0 Offset 0
                        OpDecorate %Output BufferBlock
                        OpDecorate %dataOutput DescriptorSet 0
                        OpDecorate %dataOutput Binding 0
                        OpDecorate %dataIn Location 0
                        OpDecorate %fragColor Location 0
                        OpDecorate %vtxColor Location 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
               %float = OpTypeFloat 32
              %Output = OpTypeStruct %float
 %_ptr_Uniform_Output = OpTypePointer Uniform %Output
          %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %int = OpTypeInt 32 1
               %int_0 = OpConstant %int 0
    %_ptr_Input_float = OpTypePointer Input %float
              %dataIn = OpVariable %_ptr_Input_float Input
  %_ptr_Uniform_float = OpTypePointer Uniform %float
             %v4float = OpTypeVector %float 4
 %_ptr_Output_v4float = OpTypePointer Output %v4float
           %fragColor = OpVariable %_ptr_Output_v4float Output
  %_ptr_Input_v4float = OpTypePointer Input %v4float
            %vtxColor = OpVariable %_ptr_Input_v4float Input
                %main = OpFunction %void None %3
                   %5 = OpLabel
                  %14 = OpLoad %float %dataIn
                  %16 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0
                        OpStore %16 %14
                  %22 = OpLoad %v4float %vtxColor
                        OpStore %fragColor %22
                        OpReturn
                        OpFunctionEnd
