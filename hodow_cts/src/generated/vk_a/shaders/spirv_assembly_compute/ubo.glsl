                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %dataOutput DescriptorSet 0
                       OpDecorate %dataOutput Binding 1
                       OpDecorate %_arr_mat2v2 ArrayStride 32
                       OpMemberDecorate %Input 0 ColMajor
                       OpMemberDecorate %Input 0 Offset 0
                       OpMemberDecorate %Input 0 MatrixStride 16
                       OpDecorate %Input Block
                       OpDecorate %dataInput DescriptorSet 0
                       OpDecorate %dataInput Binding 0
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
 %_ptr_Function_uint = OpTypePointer Function %u32
             %v3uint = OpTypeVector %u32 3
  %_ptr_Input_v3uint = OpTypePointer Input %v3uint
                 %id = OpVariable %_ptr_Input_v3uint Input
                %i32 = OpTypeInt 32 1
              %int_0 = OpConstant %i32 0
              %int_1 = OpConstant %i32 1
             %uint_0 = OpConstant %u32 0
             %uint_1 = OpConstant %u32 1
             %uint_2 = OpConstant %u32 2
             %uint_3 = OpConstant %u32 3
    %_ptr_Input_uint = OpTypePointer Input %u32
                %f32 = OpTypeFloat 32
            %v4float = OpTypeVector %f32 4
           %uint_128 = OpConstant %u32 128
            %_arr_v4 = OpTypeArray %v4float %uint_128
             %Output = OpTypeStruct %_arr_v4
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %dataOutput = OpVariable %_ptr_Uniform_Output Uniform
            %v2float = OpTypeVector %f32 2
        %mat2v2float = OpTypeMatrix %v2float 2
        %_arr_mat2v2 = OpTypeArray %mat2v2float %uint_128
              %Input = OpTypeStruct %_arr_mat2v2
 %_ptr_Uniform_Input = OpTypePointer Uniform %Input
          %dataInput = OpVariable %_ptr_Uniform_Input Uniform
 %_ptr_Uniform_float = OpTypePointer Uniform %f32
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %uint_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
                %idx = OpLoad %u32 %i
                 %34 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_0 %uint_0
                 %35 = OpLoad %f32 %34
                 %36 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_0
                       OpStore %36 %35
                 %40 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_0 %uint_1
                 %41 = OpLoad %f32 %40
                 %42 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_1
                       OpStore %42 %41
                 %46 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_1 %uint_0
                 %47 = OpLoad %f32 %46
                 %49 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_2
                       OpStore %49 %47
                 %52 = OpAccessChain %_ptr_Uniform_float %dataInput %int_0 %idx %int_1 %uint_1
                 %53 = OpLoad %f32 %52
                 %55 = OpAccessChain %_ptr_Uniform_float %dataOutput %int_0 %idx %uint_3
                       OpStore %55 %53
                       OpReturn
                       OpFunctionEnd
