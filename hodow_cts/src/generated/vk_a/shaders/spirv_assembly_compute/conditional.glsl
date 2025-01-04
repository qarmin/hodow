                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                         OpDecorate %_arr_uint_uint_128 ArrayStride 4
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %uint = OpTypeInt 32 0
   %_ptr_Function_uint = OpTypePointer Function %uint
               %v3uint = OpTypeVector %uint 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
               %uint_0 = OpConstant %uint 0
      %_ptr_Input_uint = OpTypePointer Input %uint
                 %bool = OpTypeBool
                 %true = OpConstantTrue %bool
                %false = OpConstantFalse %bool
             %uint_128 = OpConstant %uint 128
   %_arr_uint_uint_128 = OpTypeArray %uint %uint_128
               %Output = OpTypeStruct %_arr_uint_uint_128
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Uniform_uint = OpTypePointer Uniform %uint
          %uint_unused = OpConstant %uint 2863311530
                 %main = OpFunction %void None %3
                    %5 = OpLabel
                    %i = OpVariable %_ptr_Function_uint Function
                   %14 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                   %15 = OpLoad %uint %14
                         OpStore %i %15
               %uint_i = OpLoad %uint %i
                         OpSelectionMerge %merge None
                         OpBranchConditional %true %live %live
                 %live = OpLabel
                   %31 = OpAccessChain %_ptr_Uniform_uint %dataOutput %uint_0 %uint_i
                         OpStore %31 %uint_i
                         OpBranch %merge
                 %dead = OpLabel
                   %35 = OpAccessChain %_ptr_Uniform_uint %dataOutput %uint_0 %uint_i
                         OpStore %35 %uint_unused
                         OpBranch %merge
                %merge = OpLabel
                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                    %1 = OpExtInstImport "GLSL.std.450"
                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID
                         OpExecutionMode %main LocalSize 1 1 1
                         OpSource GLSL 430
                         OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                         OpDecorate %_arr_uint_uint_128 ArrayStride 4
                         OpMemberDecorate %Output 0 Offset 0
                         OpDecorate %Output BufferBlock
                         OpDecorate %dataOutput DescriptorSet 0
                         OpDecorate %dataOutput Binding 0
                 %void = OpTypeVoid
                    %3 = OpTypeFunction %void
                 %uint = OpTypeInt 32 0
   %_ptr_Function_uint = OpTypePointer Function %uint
               %v3uint = OpTypeVector %uint 3
    %_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
               %uint_0 = OpConstant %uint 0
      %_ptr_Input_uint = OpTypePointer Input %uint
                 %bool = OpTypeBool
                 %true = OpConstantTrue %bool
                %false = OpConstantFalse %bool
             %uint_128 = OpConstant %uint 128
   %_arr_uint_uint_128 = OpTypeArray %uint %uint_128
               %Output = OpTypeStruct %_arr_uint_uint_128
  %_ptr_Uniform_Output = OpTypePointer Uniform %Output
           %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
    %_ptr_Uniform_uint = OpTypePointer Uniform %uint
          %uint_unused = OpConstant %uint 2863311530
                 %main = OpFunction %void None %3
                    %5 = OpLabel
                    %i = OpVariable %_ptr_Function_uint Function
                   %14 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                   %15 = OpLoad %uint %14
                         OpStore %i %15
               %uint_i = OpLoad %uint %i
                         OpSelectionMerge %merge None
                         OpBranchConditional %false %live %live
                 %live = OpLabel
                   %31 = OpAccessChain %_ptr_Uniform_uint %dataOutput %uint_0 %uint_i
                         OpStore %31 %uint_i
                         OpBranch %merge
                 %dead = OpLabel
                   %35 = OpAccessChain %_ptr_Uniform_uint %dataOutput %uint_0 %uint_i
                         OpStore %35 %uint_unused
                         OpBranch %merge
                %merge = OpLabel
                         OpReturn
                         OpFunctionEnd
