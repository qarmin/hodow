                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
                %v3f32 = OpTypeVector %f32 3
                %v4f32 = OpTypeVector %f32 4
               %Output = OpTypeStruct %v2f32
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_vec = OpTypePointer Function %v2f32
     %_ptr_Uniform_vec = OpTypePointer Uniform %v2f32
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
              %c_f32_2 = OpConstant %f32 2
              %c_f32_3 = OpConstant %f32 3
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %vec = OpVariable %_ptr_Function_vec Function
                 %tmp0 = OpUndef %v2f32
                 %tmp1 = OpCompositeInsert %v2f32 %c_f32_0 %tmp0 0
                 %tmp2 = OpCompositeInsert %v2f32 %c_f32_1 %tmp1 1
            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0
                         OpStore %vecOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
                %v3f32 = OpTypeVector %f32 3
                %v4f32 = OpTypeVector %f32 4
               %Output = OpTypeStruct %v3f32
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_vec = OpTypePointer Function %v3f32
     %_ptr_Uniform_vec = OpTypePointer Uniform %v3f32
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
              %c_f32_2 = OpConstant %f32 2
              %c_f32_3 = OpConstant %f32 3
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %vec = OpVariable %_ptr_Function_vec Function
                 %tmp0 = OpUndef %v3f32
                 %tmp1 = OpCompositeInsert %v3f32 %c_f32_0 %tmp0 0
                 %tmp2 = OpCompositeInsert %v3f32 %c_f32_1 %tmp1 1
                 %tmp3 = OpCompositeInsert %v3f32 %c_f32_2 %tmp2 2
            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0
                         OpStore %vecOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
                %v3f32 = OpTypeVector %f32 3
                %v4f32 = OpTypeVector %f32 4
               %Output = OpTypeStruct %v4f32
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_vec = OpTypePointer Function %v4f32
     %_ptr_Uniform_vec = OpTypePointer Uniform %v4f32
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
              %c_f32_2 = OpConstant %f32 2
              %c_f32_3 = OpConstant %f32 3
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %vec = OpVariable %_ptr_Function_vec Function
                 %tmp0 = OpUndef %v4f32
                 %tmp1 = OpCompositeInsert %v4f32 %c_f32_0 %tmp0 0
                 %tmp2 = OpCompositeInsert %v4f32 %c_f32_1 %tmp1 1
                 %tmp3 = OpCompositeInsert %v4f32 %c_f32_2 %tmp2 2
                 %tmp4 = OpCompositeInsert %v4f32 %c_f32_3 %tmp3 3
            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0
                         OpStore %vecOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
                %v3f32 = OpTypeVector %f32 3
                %v4f32 = OpTypeVector %f32 4
               %Output = OpTypeStruct %v2f32
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_vec = OpTypePointer Function %v2f32
     %_ptr_Uniform_vec = OpTypePointer Uniform %v2f32
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
              %c_f32_2 = OpConstant %f32 2
              %c_f32_3 = OpConstant %f32 3
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %vec = OpVariable %_ptr_Function_vec Function
                 %tmp0 = OpLoad %v2f32 %vec
                 %tmp1 = OpCompositeInsert %v2f32 %c_f32_0 %tmp0 0
                 %tmp2 = OpCompositeInsert %v2f32 %c_f32_1 %tmp1 1
            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0
                         OpStore %vecOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
                %v3f32 = OpTypeVector %f32 3
                %v4f32 = OpTypeVector %f32 4
               %Output = OpTypeStruct %v3f32
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_vec = OpTypePointer Function %v3f32
     %_ptr_Uniform_vec = OpTypePointer Uniform %v3f32
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
              %c_f32_2 = OpConstant %f32 2
              %c_f32_3 = OpConstant %f32 3
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %vec = OpVariable %_ptr_Function_vec Function
                 %tmp0 = OpLoad %v3f32 %vec
                 %tmp1 = OpCompositeInsert %v3f32 %c_f32_0 %tmp0 0
                 %tmp2 = OpCompositeInsert %v3f32 %c_f32_1 %tmp1 1
                 %tmp3 = OpCompositeInsert %v3f32 %c_f32_2 %tmp2 2
            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0
                         OpStore %vecOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
                %v3f32 = OpTypeVector %f32 3
                %v4f32 = OpTypeVector %f32 4
               %Output = OpTypeStruct %v4f32
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_vec = OpTypePointer Function %v4f32
     %_ptr_Uniform_vec = OpTypePointer Uniform %v4f32
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
              %c_f32_2 = OpConstant %f32 2
              %c_f32_3 = OpConstant %f32 3
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %vec = OpVariable %_ptr_Function_vec Function
                 %tmp0 = OpLoad %v4f32 %vec
                 %tmp1 = OpCompositeInsert %v4f32 %c_f32_0 %tmp0 0
                 %tmp2 = OpCompositeInsert %v4f32 %c_f32_1 %tmp1 1
                 %tmp3 = OpCompositeInsert %v4f32 %c_f32_2 %tmp2 2
                 %tmp4 = OpCompositeInsert %v4f32 %c_f32_3 %tmp3 3
            %vecOutPtr = OpAccessChain %_ptr_Uniform_vec %dataOutput %c_i32_0
                         OpStore %vecOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 8
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
              %mat2v2f = OpTypeMatrix %v2f32 2
               %Output = OpTypeStruct %mat2v2f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat2v2f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat2v2f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v2f32 %c_f32_1 %c_f32_0 
            %identity1 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat2v2f
                 %tmp1 = OpCompositeInsert %mat2v2f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat2v2f %identity1 %tmp1 1
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 8
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
              %mat3v2f = OpTypeMatrix %v2f32 3
               %Output = OpTypeStruct %mat3v2f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat3v2f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat3v2f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v2f32 %c_f32_1 %c_f32_0 
            %identity1 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_1 
            %identity2 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat3v2f
                 %tmp1 = OpCompositeInsert %mat3v2f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat3v2f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat3v2f %identity2 %tmp2 2
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 8
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
              %mat4v2f = OpTypeMatrix %v2f32 4
               %Output = OpTypeStruct %mat4v2f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat4v2f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat4v2f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v2f32 %c_f32_1 %c_f32_0 
            %identity1 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_1 
            %identity2 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_0 
            %identity3 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat4v2f
                 %tmp1 = OpCompositeInsert %mat4v2f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat4v2f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat4v2f %identity2 %tmp2 2
                 %tmp4 = OpCompositeInsert %mat4v2f %identity3 %tmp3 3
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v3f32 = OpTypeVector %f32 3
              %mat2v3f = OpTypeMatrix %v3f32 2
               %Output = OpTypeStruct %mat2v3f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat2v3f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat2v3f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v3f32 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_1 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat2v3f
                 %tmp1 = OpCompositeInsert %mat2v3f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat2v3f %identity1 %tmp1 1
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v3f32 = OpTypeVector %f32 3
              %mat3v3f = OpTypeMatrix %v3f32 3
               %Output = OpTypeStruct %mat3v3f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat3v3f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat3v3f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v3f32 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity2 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat3v3f
                 %tmp1 = OpCompositeInsert %mat3v3f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat3v3f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat3v3f %identity2 %tmp2 2
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v3f32 = OpTypeVector %f32 3
              %mat4v3f = OpTypeMatrix %v3f32 4
               %Output = OpTypeStruct %mat4v3f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat4v3f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat4v3f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v3f32 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity2 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_0 %c_f32_1 
            %identity3 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat4v3f
                 %tmp1 = OpCompositeInsert %mat4v3f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat4v3f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat4v3f %identity2 %tmp2 2
                 %tmp4 = OpCompositeInsert %mat4v3f %identity3 %tmp3 3
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
              %mat2v4f = OpTypeMatrix %v4f32 2
               %Output = OpTypeStruct %mat2v4f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat2v4f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat2v4f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat2v4f
                 %tmp1 = OpCompositeInsert %mat2v4f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat2v4f %identity1 %tmp1 1
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
              %mat3v4f = OpTypeMatrix %v4f32 3
               %Output = OpTypeStruct %mat3v4f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat3v4f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat3v4f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity2 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_1 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat3v4f
                 %tmp1 = OpCompositeInsert %mat3v4f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat3v4f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat3v4f %identity2 %tmp2 2
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
              %mat4v4f = OpTypeMatrix %v4f32 4
               %Output = OpTypeStruct %mat4v4f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat4v4f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat4v4f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity2 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity3 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpUndef %mat4v4f
                 %tmp1 = OpCompositeInsert %mat4v4f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat4v4f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat4v4f %identity2 %tmp2 2
                 %tmp4 = OpCompositeInsert %mat4v4f %identity3 %tmp3 3
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 8
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
              %mat2v2f = OpTypeMatrix %v2f32 2
               %Output = OpTypeStruct %mat2v2f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat2v2f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat2v2f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v2f32 %c_f32_1 %c_f32_0 
            %identity1 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat2v2f %mat
                 %tmp1 = OpCompositeInsert %mat2v2f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat2v2f %identity1 %tmp1 1
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 8
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
              %mat3v2f = OpTypeMatrix %v2f32 3
               %Output = OpTypeStruct %mat3v2f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat3v2f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat3v2f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v2f32 %c_f32_1 %c_f32_0 
            %identity1 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_1 
            %identity2 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat3v2f %mat
                 %tmp1 = OpCompositeInsert %mat3v2f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat3v2f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat3v2f %identity2 %tmp2 2
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 8
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v2f32 = OpTypeVector %f32 2
              %mat4v2f = OpTypeMatrix %v2f32 4
               %Output = OpTypeStruct %mat4v2f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat4v2f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat4v2f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v2f32 %c_f32_1 %c_f32_0 
            %identity1 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_1 
            %identity2 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_0 
            %identity3 = OpConstantComposite %v2f32 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat4v2f %mat
                 %tmp1 = OpCompositeInsert %mat4v2f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat4v2f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat4v2f %identity2 %tmp2 2
                 %tmp4 = OpCompositeInsert %mat4v2f %identity3 %tmp3 3
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v3f32 = OpTypeVector %f32 3
              %mat2v3f = OpTypeMatrix %v3f32 2
               %Output = OpTypeStruct %mat2v3f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat2v3f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat2v3f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v3f32 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_1 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat2v3f %mat
                 %tmp1 = OpCompositeInsert %mat2v3f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat2v3f %identity1 %tmp1 1
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v3f32 = OpTypeVector %f32 3
              %mat3v3f = OpTypeMatrix %v3f32 3
               %Output = OpTypeStruct %mat3v3f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat3v3f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat3v3f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v3f32 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity2 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat3v3f %mat
                 %tmp1 = OpCompositeInsert %mat3v3f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat3v3f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat3v3f %identity2 %tmp2 2
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v3f32 = OpTypeVector %f32 3
              %mat4v3f = OpTypeMatrix %v3f32 4
               %Output = OpTypeStruct %mat4v3f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat4v3f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat4v3f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v3f32 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity2 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_0 %c_f32_1 
            %identity3 = OpConstantComposite %v3f32 %c_f32_0 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat4v3f %mat
                 %tmp1 = OpCompositeInsert %mat4v3f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat4v3f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat4v3f %identity2 %tmp2 2
                 %tmp4 = OpCompositeInsert %mat4v3f %identity3 %tmp3 3
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
              %mat2v4f = OpTypeMatrix %v4f32 2
               %Output = OpTypeStruct %mat2v4f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat2v4f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat2v4f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat2v4f %mat
                 %tmp1 = OpCompositeInsert %mat2v4f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat2v4f %identity1 %tmp1 1
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp2
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
              %mat3v4f = OpTypeMatrix %v4f32 3
               %Output = OpTypeStruct %mat3v4f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat3v4f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat3v4f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity2 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_1 %c_f32_0 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat3v4f %mat
                 %tmp1 = OpCompositeInsert %mat3v4f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat3v4f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat3v4f %identity2 %tmp2 2
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp3
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpMemberDecorate %Output 0 Offset 0
                         OpMemberDecorate %Output 0 ColMajor
                         OpMemberDecorate %Output 0 MatrixStride 16
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
              %mat4v4f = OpTypeMatrix %v4f32 4
               %Output = OpTypeStruct %mat4v4f
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Function_mat = OpTypePointer Function %mat4v4f
     %_ptr_Uniform_mat = OpTypePointer Uniform %mat4v4f
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity2 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity3 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
                  %mat = OpVariable %_ptr_Function_mat Function
                 %tmp0 = OpLoad %mat4v4f %mat
                 %tmp1 = OpCompositeInsert %mat4v4f %identity0 %tmp0 0
                 %tmp2 = OpCompositeInsert %mat4v4f %identity1 %tmp1 1
                 %tmp3 = OpCompositeInsert %mat4v4f %identity2 %tmp2 2
                 %tmp4 = OpCompositeInsert %mat4v4f %identity3 %tmp3 3
            %matOutPtr = OpAccessChain %_ptr_Uniform_mat %dataOutput %c_i32_0
                         OpStore %matOutPtr %tmp4
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %_arr_mat4v4f32_uint_8 ArrayStride 64
                         OpMemberDecorate %S 0 ColMajor
                         OpMemberDecorate %S 0 Offset 0
                         OpMemberDecorate %S 0 MatrixStride 16
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
            %mat4v4f32 = OpTypeMatrix %v4f32 4
                 %uint = OpTypeInt 32 0
               %uint_8 = OpConstant %uint 8
%_arr_mat4v4f32_uint_8 = OpTypeArray %mat4v4f32 %uint_8
                    %S = OpTypeStruct %_arr_mat4v4f32_uint_8
               %Output = OpTypeStruct %S
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
 %_ptr_Function_Output = OpTypePointer Function %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity2 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity3 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
         %nestedstruct = OpVariable %_ptr_Function_Output Function
                 %tmp0 = OpUndef %Output
%tmp1 = OpCompositeInsert %Output %identity0 %tmp0 0 0 0 0
%tmp2 = OpCompositeInsert %Output %identity1 %tmp1 0 0 0 1
%tmp3 = OpCompositeInsert %Output %identity2 %tmp2 0 0 0 2
%tmp4 = OpCompositeInsert %Output %identity3 %tmp3 0 0 0 3
%tmp5 = OpCompositeInsert %Output %identity0 %tmp4 0 0 1 0
%tmp6 = OpCompositeInsert %Output %identity1 %tmp5 0 0 1 1
%tmp7 = OpCompositeInsert %Output %identity2 %tmp6 0 0 1 2
%tmp8 = OpCompositeInsert %Output %identity3 %tmp7 0 0 1 3
%tmp9 = OpCompositeInsert %Output %identity0 %tmp8 0 0 2 0
%tmp10 = OpCompositeInsert %Output %identity1 %tmp9 0 0 2 1
%tmp11 = OpCompositeInsert %Output %identity2 %tmp10 0 0 2 2
%tmp12 = OpCompositeInsert %Output %identity3 %tmp11 0 0 2 3
%tmp13 = OpCompositeInsert %Output %identity0 %tmp12 0 0 3 0
%tmp14 = OpCompositeInsert %Output %identity1 %tmp13 0 0 3 1
%tmp15 = OpCompositeInsert %Output %identity2 %tmp14 0 0 3 2
%tmp16 = OpCompositeInsert %Output %identity3 %tmp15 0 0 3 3
%tmp17 = OpCompositeInsert %Output %identity0 %tmp16 0 0 4 0
%tmp18 = OpCompositeInsert %Output %identity1 %tmp17 0 0 4 1
%tmp19 = OpCompositeInsert %Output %identity2 %tmp18 0 0 4 2
%tmp20 = OpCompositeInsert %Output %identity3 %tmp19 0 0 4 3
%tmp21 = OpCompositeInsert %Output %identity0 %tmp20 0 0 5 0
%tmp22 = OpCompositeInsert %Output %identity1 %tmp21 0 0 5 1
%tmp23 = OpCompositeInsert %Output %identity2 %tmp22 0 0 5 2
%tmp24 = OpCompositeInsert %Output %identity3 %tmp23 0 0 5 3
%tmp25 = OpCompositeInsert %Output %identity0 %tmp24 0 0 6 0
%tmp26 = OpCompositeInsert %Output %identity1 %tmp25 0 0 6 1
%tmp27 = OpCompositeInsert %Output %identity2 %tmp26 0 0 6 2
%tmp28 = OpCompositeInsert %Output %identity3 %tmp27 0 0 6 3
%tmp29 = OpCompositeInsert %Output %identity0 %tmp28 0 0 7 0
%tmp30 = OpCompositeInsert %Output %identity1 %tmp29 0 0 7 1
%tmp31 = OpCompositeInsert %Output %identity2 %tmp30 0 0 7 2
%tmp32 = OpCompositeInsert %Output %identity3 %tmp31 0 0 7 3
                         OpStore %dataOutput %tmp32
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main"
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %_arr_mat4v4f32_uint_8 ArrayStride 64
                         OpMemberDecorate %S 0 ColMajor
                         OpMemberDecorate %S 0 Offset 0
                         OpMemberDecorate %S 0 MatrixStride 16
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                  %f32 = OpTypeFloat 32
                %v4f32 = OpTypeVector %f32 4
            %mat4v4f32 = OpTypeMatrix %v4f32 4
                 %uint = OpTypeInt 32 0
               %uint_8 = OpConstant %uint 8
%_arr_mat4v4f32_uint_8 = OpTypeArray %mat4v4f32 %uint_8
                    %S = OpTypeStruct %_arr_mat4v4f32_uint_8
               %Output = OpTypeStruct %S
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
 %_ptr_Function_Output = OpTypePointer Function %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
              %c_f32_0 = OpConstant %f32 0
              %c_f32_1 = OpConstant %f32 1
                  %i32 = OpTypeInt 32 1
              %c_i32_0 = OpConstant %i32 0
            %identity0 = OpConstantComposite %v4f32 %c_f32_1 %c_f32_0 %c_f32_0 %c_f32_0 
            %identity1 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_1 %c_f32_0 %c_f32_0 
            %identity2 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_1 %c_f32_0 
            %identity3 = OpConstantComposite %v4f32 %c_f32_0 %c_f32_0 %c_f32_0 %c_f32_1 
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %main = OpFunction %void None %3
                %entry = OpLabel
         %nestedstruct = OpVariable %_ptr_Function_Output Function
                 %tmp0 = OpLoad %Output %nestedstruct
%tmp1 = OpCompositeInsert %Output %identity0 %tmp0 0 0 0 0
%tmp2 = OpCompositeInsert %Output %identity1 %tmp1 0 0 0 1
%tmp3 = OpCompositeInsert %Output %identity2 %tmp2 0 0 0 2
%tmp4 = OpCompositeInsert %Output %identity3 %tmp3 0 0 0 3
%tmp5 = OpCompositeInsert %Output %identity0 %tmp4 0 0 1 0
%tmp6 = OpCompositeInsert %Output %identity1 %tmp5 0 0 1 1
%tmp7 = OpCompositeInsert %Output %identity2 %tmp6 0 0 1 2
%tmp8 = OpCompositeInsert %Output %identity3 %tmp7 0 0 1 3
%tmp9 = OpCompositeInsert %Output %identity0 %tmp8 0 0 2 0
%tmp10 = OpCompositeInsert %Output %identity1 %tmp9 0 0 2 1
%tmp11 = OpCompositeInsert %Output %identity2 %tmp10 0 0 2 2
%tmp12 = OpCompositeInsert %Output %identity3 %tmp11 0 0 2 3
%tmp13 = OpCompositeInsert %Output %identity0 %tmp12 0 0 3 0
%tmp14 = OpCompositeInsert %Output %identity1 %tmp13 0 0 3 1
%tmp15 = OpCompositeInsert %Output %identity2 %tmp14 0 0 3 2
%tmp16 = OpCompositeInsert %Output %identity3 %tmp15 0 0 3 3
%tmp17 = OpCompositeInsert %Output %identity0 %tmp16 0 0 4 0
%tmp18 = OpCompositeInsert %Output %identity1 %tmp17 0 0 4 1
%tmp19 = OpCompositeInsert %Output %identity2 %tmp18 0 0 4 2
%tmp20 = OpCompositeInsert %Output %identity3 %tmp19 0 0 4 3
%tmp21 = OpCompositeInsert %Output %identity0 %tmp20 0 0 5 0
%tmp22 = OpCompositeInsert %Output %identity1 %tmp21 0 0 5 1
%tmp23 = OpCompositeInsert %Output %identity2 %tmp22 0 0 5 2
%tmp24 = OpCompositeInsert %Output %identity3 %tmp23 0 0 5 3
%tmp25 = OpCompositeInsert %Output %identity0 %tmp24 0 0 6 0
%tmp26 = OpCompositeInsert %Output %identity1 %tmp25 0 0 6 1
%tmp27 = OpCompositeInsert %Output %identity2 %tmp26 0 0 6 2
%tmp28 = OpCompositeInsert %Output %identity3 %tmp27 0 0 6 3
%tmp29 = OpCompositeInsert %Output %identity0 %tmp28 0 0 7 0
%tmp30 = OpCompositeInsert %Output %identity1 %tmp29 0 0 7 1
%tmp31 = OpCompositeInsert %Output %identity2 %tmp30 0 0 7 2
%tmp32 = OpCompositeInsert %Output %identity3 %tmp31 0 0 7 3
                         OpStore %dataOutput %tmp32
                         OpReturn
                         OpFunctionEnd
