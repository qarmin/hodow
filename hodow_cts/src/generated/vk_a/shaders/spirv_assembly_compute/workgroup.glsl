                                     OpCapability Shader
OpCapability Float64
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 8
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 8
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%f64 = OpTypeFloat 64
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %f64 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %f64 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %f64
                   %_ptr_Workgroup = OpTypePointer Workgroup %f64
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %f64 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %f64 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %f64 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 4
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 4
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%f32 = OpTypeFloat 32
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %f32 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %f32 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %f32
                   %_ptr_Workgroup = OpTypePointer Workgroup %f32
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %f32 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %f32 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %f32 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpCapability Float16
OpExtension "SPV_KHR_16bit_storage"
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 2
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 2
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%f16 = OpTypeFloat 16
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %f16 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %f16 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %f16
                   %_ptr_Workgroup = OpTypePointer Workgroup %f16
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %f16 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %f16 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %f16 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
OpCapability Int64
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 8
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 8
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%i64 = OpTypeInt 64 1
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %i64 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %i64 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %i64
                   %_ptr_Workgroup = OpTypePointer Workgroup %i64
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %i64 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %i64 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %i64 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 4
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 4
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1

                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %i32 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %i32 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %i32
                   %_ptr_Workgroup = OpTypePointer Workgroup %i32
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %i32 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %i32 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %i32 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
OpCapability Int16
OpExtension "SPV_KHR_16bit_storage"
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 2
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 2
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%i16 = OpTypeInt 16 1
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %i16 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %i16 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %i16
                   %_ptr_Workgroup = OpTypePointer Workgroup %i16
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %i16 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %i16 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %i16 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpCapability Int8
OpExtension "SPV_KHR_8bit_storage"
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 1
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 1
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%i8 = OpTypeInt 8 1
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %i8 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %i8 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %i8
                   %_ptr_Workgroup = OpTypePointer Workgroup %i8
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %i8 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %i8 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %i8 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
OpCapability Int64
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 8
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 8
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%u64 = OpTypeInt 64 0
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %u64 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %u64 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %u64
                   %_ptr_Workgroup = OpTypePointer Workgroup %u64
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %u64 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %u64 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %u64 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 4
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 4
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1

                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %u32 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %u32 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %u32
                   %_ptr_Workgroup = OpTypePointer Workgroup %u32
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %u32 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %u32 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %u32 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
OpCapability Int16
OpExtension "SPV_KHR_16bit_storage"
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 2
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 2
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%u16 = OpTypeInt 16 0
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %u16 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %u16 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %u16
                   %_ptr_Workgroup = OpTypePointer Workgroup %u16
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %u16 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %u16 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %u16 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
                                     OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpCapability Int8
OpExtension "SPV_KHR_8bit_storage"
                                %1 = OpExtInstImport "GLSL.std.450"
                                     OpMemoryModel Logical GLSL450
                                     OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID
                                     OpExecutionMode %main LocalSize 16 4 2
                                     OpSource GLSL 430
                                     OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
                                     OpDecorate %_arr_uint_128_0 ArrayStride 1
                                     OpMemberDecorate %Input 0 Offset 0
                                     OpDecorate %Input BufferBlock
                                     OpDecorate %dataInput DescriptorSet 0
                                     OpDecorate %dataInput Binding 0
                                     OpDecorate %_arr_uint_128_1 ArrayStride 1
                                     OpMemberDecorate %Output 0 Offset 0
                                     OpDecorate %Output BufferBlock
                                     OpDecorate %dataOutput DescriptorSet 0
                                     OpDecorate %dataOutput Binding 1
                                     OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                             %void = OpTypeVoid
                                %3 = OpTypeFunction %void
                              %u32 = OpTypeInt 32 0
               %_ptr_Function_uint = OpTypePointer Function %u32
                           %v3uint = OpTypeVector %u32 3
                %_ptr_Input_v3uint = OpTypePointer Input %v3uint
             %gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
                           %uint_2 = OpConstant %u32 2
                  %_ptr_Input_uint = OpTypePointer Input %u32
                          %uint_64 = OpConstant %u32 64
                           %uint_1 = OpConstant %u32 1
                          %uint_16 = OpConstant %u32 16
                           %uint_0 = OpConstant %u32 0
                         %uint_127 = OpConstant %u32 127
                           %uint_4 = OpConstant %u32 4
                              %i32 = OpTypeInt 32 1
%u8 = OpTypeInt 8 0
                         %uint_128 = OpConstant %u32 128
                    %_arr_uint_128 = OpTypeArray %u8 %uint_128
     %_ptr_Workgroup__arr_uint_128 = OpTypePointer Workgroup %_arr_uint_128
                       %sharedData = OpVariable %_ptr_Workgroup__arr_uint_128 Workgroup
                  %_arr_uint_128_0 = OpTypeArray %u8 %uint_128
                            %Input = OpTypeStruct %_arr_uint_128_0
               %_ptr_Uniform_Input = OpTypePointer Uniform %Input
                        %dataInput = OpVariable %_ptr_Uniform_Input Uniform
                            %int_0 = OpConstant %i32 0
                     %_ptr_Uniform = OpTypePointer Uniform %u8
                   %_ptr_Workgroup = OpTypePointer Workgroup %u8
                         %uint_264 = OpConstant %u32 264
                  %_arr_uint_128_1 = OpTypeArray %u8 %uint_128
                           %Output = OpTypeStruct %_arr_uint_128_1
              %_ptr_Uniform_Output = OpTypePointer Uniform %Output
                       %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
                 %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_16 %uint_4 %uint_2
                             %main = OpFunction %void None %3
                                %5 = OpLabel
                              %idx = OpVariable %_ptr_Function_uint Function
                               %14 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_2
                               %15 = OpLoad %u32 %14
                               %17 = OpIMul %u32 %15 %uint_64
                               %19 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_1
                               %20 = OpLoad %u32 %19
                               %22 = OpIMul %u32 %20 %uint_16
                               %23 = OpIAdd %u32 %17 %22
                               %25 = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
                               %26 = OpLoad %u32 %25
                               %27 = OpIAdd %u32 %23 %26
                                     OpStore %idx %27
                               %33 = OpLoad %u32 %idx
                               %39 = OpLoad %u32 %idx
                               %41 = OpAccessChain %_ptr_Uniform %dataInput %int_0 %39
                               %42 = OpLoad %u8 %41
                               %44 = OpAccessChain %_ptr_Workgroup %sharedData %33
                                     OpStore %44 %42
                                     OpMemoryBarrier %uint_1 %uint_264
                                     OpControlBarrier %uint_2 %uint_2 %uint_264
                               %50 = OpLoad %u32 %idx
                               %52 = OpLoad %u32 %idx
                               %53 = OpISub %u32 %uint_127 %52
                               %54 = OpAccessChain %_ptr_Workgroup %sharedData %53
                               %55 = OpLoad %u8 %54
                               %56 = OpAccessChain %_ptr_Uniform %dataOutput %int_0 %50
                                     OpStore %56 %55
                                     OpReturn
                                     OpFunctionEnd
