                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32 %Image
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
           %func_img = OpFunctionParameter %Image
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
           %call_img = OpLoad %Image %InputData
                %res = OpFunctionCall %void %read_func %index %call_img
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32 %Image
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
           %func_img = OpFunctionParameter %Image
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
           %call_img = OpLoad %Image %InputData
                %res = OpFunctionCall %void %read_func %index %call_img
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32 %Image
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
           %func_img = OpFunctionParameter %Image
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
           %call_img = OpLoad %Image %InputData
                %res = OpFunctionCall %void %read_func %index %call_img
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32 %Image
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
           %func_img = OpFunctionParameter %Image
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
           %call_img = OpLoad %Image %InputData
                %res = OpFunctionCall %void %read_func %index %call_img
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32 %Image
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
           %func_img = OpFunctionParameter %Image
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
           %call_img = OpLoad %Image %InputData
                %res = OpFunctionCall %void %read_func %index %call_img
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba32f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32 %Image
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
           %func_img = OpFunctionParameter %Image
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
           %call_img = OpLoad %Image %InputData
                %res = OpFunctionCall %void %read_func %index %call_img
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba16f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba16f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba16f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba16f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba16f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba16f
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 0 0 0 2 Rgba16ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 1 0 0 2 Rgba16ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 2 0 0 2 Rgba16ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 0 0 0 2 Rgba16ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 1 0 0 2 Rgba16ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 2 0 0 2 Rgba16ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 0 0 0 2 Rgba16i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 1 0 0 2 Rgba16i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 2 0 0 2 Rgba16i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 0 0 0 2 Rgba16i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 1 0 0 2 Rgba16i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 2 0 0 2 Rgba16i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 0 0 0 2 Rgba32ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 1 0 0 2 Rgba32ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 2 0 0 2 Rgba32ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 0 0 0 2 Rgba32ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 1 0 0 2 Rgba32ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 2 0 0 2 Rgba32ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 0 0 0 2 Rgba32i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 1 0 0 2 Rgba32i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 2 0 0 2 Rgba32i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 0 0 0 2 Rgba32i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 1 0 0 2 Rgba32i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 2 0 0 2 Rgba32i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 0 0 0 2 Rgba8ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 1 0 0 2 Rgba8ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %u32 2D 2 0 0 2 Rgba8ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 0 0 0 2 Rgba8ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 1 0 0 2 Rgba8ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4u32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4u32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %u32 2D 2 0 0 2 Rgba8ui
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4u32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 0 0 0 2 Rgba8i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 1 0 0 2 Rgba8i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %i32 2D 2 0 0 2 Rgba8i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 0 0 0 2 Rgba8i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 1 0 0 2 Rgba8i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4i32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4i32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %i32 2D 2 0 0 2 Rgba8i
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4i32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba8
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba8
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output BufferBlock
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer Uniform %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer Uniform %Output
         %OutputData = OpVariable %_ptr_Uniform_Output Uniform
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba8
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 0 0 0 2 Rgba8
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 1 0 0 2 Rgba8
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
                       OpCapability Shader
                  %1 = OpExtInstImport "GLSL.std.450"
                       OpMemoryModel Logical GLSL450
                       OpEntryPoint GLCompute %main "main" %id %InputData %OutputData
                       OpExecutionMode %main LocalSize 1 1 1
                       OpSource GLSL 430
                       OpDecorate %id BuiltIn GlobalInvocationId
                       OpDecorate %_arr_v4type_u32_64 ArrayStride 16
                       OpMemberDecorate %Output 0 Offset 0
                       OpDecorate %Output Block
                       OpDecorate %InputData DescriptorSet 0
                       OpDecorate %InputData Binding 0
                       OpDecorate %OutputData DescriptorSet 0
                       OpDecorate %OutputData Binding 1
               %void = OpTypeVoid
                  %3 = OpTypeFunction %void
                %u32 = OpTypeInt 32 0
                %i32 = OpTypeInt 32 1
                %f32 = OpTypeFloat 32
 %_ptr_Function_uint = OpTypePointer Function %u32
              %v3u32 = OpTypeVector %u32 3
   %_ptr_Input_v3u32 = OpTypePointer Input %v3u32
                 %id = OpVariable %_ptr_Input_v3u32 Input
            %c_f32_0 = OpConstant %f32 0.0
            %c_u32_0 = OpConstant %u32 0
            %c_i32_0 = OpConstant %i32 0
    %_ptr_Input_uint = OpTypePointer Input %u32
              %v2u32 = OpTypeVector %u32 2
              %v2f32 = OpTypeVector %f32 2
              %v4f32 = OpTypeVector %f32 4
              %v4u32 = OpTypeVector %u32 4
              %v4i32 = OpTypeVector %i32 4
           %uint_128 = OpConstant %u32 128
           %c_u32_64 = OpConstant %u32 64
            %c_u32_8 = OpConstant %u32 8
            %c_f32_8 = OpConstant %f32 8.0
        %c_v2f32_8_8 = OpConstantComposite %v2f32 %c_f32_8 %c_f32_8
 %_arr_v4type_u32_64 = OpTypeArray %v4f32 %c_u32_64
%_ptr_Uniform_v4type = OpTypePointer StorageBuffer %v4f32
             %Output = OpTypeStruct %_arr_v4type_u32_64
%_ptr_Uniform_Output = OpTypePointer StorageBuffer %Output
         %OutputData = OpVariable %_ptr_Uniform_Output StorageBuffer
              %Image = OpTypeImage %f32 2D 2 0 0 2 Rgba8
           %ImagePtr = OpTypePointer UniformConstant %Image
          %InputData = OpVariable %ImagePtr UniformConstant
     %read_func_type = OpTypeFunction %void %u32
          %read_func = OpFunction %void None %read_func_type
           %func_ndx = OpFunctionParameter %u32
          %funcentry = OpLabel
                %row = OpUMod %u32 %func_ndx %c_u32_8
                %col = OpUDiv %u32 %func_ndx %c_u32_8
              %coord = OpCompositeConstruct %v2u32 %row %col
             %coordf = OpConvertUToF %v2f32 %coord
       %normalcoordf = OpFDiv %v2f32 %coordf %c_v2f32_8_8
           %func_img = OpLoad %Image %InputData
              %color = OpImageRead %v4f32 %func_img %coord Nontemporal
                 %36 = OpAccessChain %_ptr_Uniform_v4type %OutputData %c_u32_0 %func_ndx
                       OpStore %36 %color
                       OpReturn
                       OpFunctionEnd
               %main = OpFunction %void None %3
                  %5 = OpLabel
                  %i = OpVariable %_ptr_Function_uint Function
                 %14 = OpAccessChain %_ptr_Input_uint %id %c_u32_0
                 %15 = OpLoad %u32 %14
                       OpStore %i %15
              %index = OpLoad %u32 %14
                %res = OpFunctionCall %void %read_func %index
                       OpReturn
                       OpFunctionEnd
