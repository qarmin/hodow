
                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdNotEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdLessThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdLessThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdGreaterThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdGreaterThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordNotEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordLessThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordLessThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordGreaterThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordGreaterThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdNotEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdLessThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdLessThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdGreaterThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFOrdGreaterThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordNotEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordLessThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordLessThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordGreaterThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        OpCapability SignedZeroInfNanPreserve
                        OpExtension "SPV_KHR_float_controls"
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 20
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeFloat 64
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpFUnordGreaterThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdNotEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdLessThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdLessThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdGreaterThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdGreaterThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordNotEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordLessThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordLessThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordGreaterThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordGreaterThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdNotEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdLessThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdLessThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdGreaterThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFOrdGreaterThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordNotEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordLessThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordLessThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordGreaterThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Float64
                          OpCapability SignedZeroInfNanPreserve
                          OpExtension "SPV_KHR_float_controls"
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 5
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeFloat 64
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpFUnordGreaterThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 16
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 1
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpIEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 16
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 1
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpINotEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 16
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 1
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpSLessThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 16
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 1
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpSLessThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 16
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 1
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpSGreaterThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 16
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 1
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpSGreaterThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 4
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 1
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpIEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 4
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 1
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpINotEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 4
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 1
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpSLessThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 4
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 1
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpSLessThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 4
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 1
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpSGreaterThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 4
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 1
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpSGreaterThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 12
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 0
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpIEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 12
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 0
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpINotEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 12
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 0
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpULessThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 12
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 0
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpULessThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 12
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 0
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpUGreaterThan %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                        OpCapability Shader
                        OpCapability Int64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint GLCompute %main "main"
                        
                        OpExecutionMode %main LocalSize 1 1 1
                        OpName %main "main"
                        OpName %i "i"
                        OpName %Output1 "Output1"
                        OpMemberName %Output1 0 "values"
                        OpName %output1 "output1"
                        OpName %Input1 "Input1"
                        OpMemberName %Input1 0 "values"
                        OpName %input1 "input1"
                        OpName %Input2 "Input2"
                        OpMemberName %Input2 0 "values"
                        OpName %input2 "input2"
                        OpDecorate %_runtimearr_int ArrayStride 4
                        OpMemberDecorate %Output1 0 Offset 0
                        OpDecorate %Output1 BufferBlock
                        OpDecorate %output1 DescriptorSet 0
                        OpDecorate %output1 Binding 2
                        OpDecorate %_runtimearr_tinput ArrayStride 8
                        OpMemberDecorate %Input1 0 Offset 0
                        OpDecorate %Input1 BufferBlock
                        OpDecorate %input1 DescriptorSet 0
                        OpDecorate %input1 Binding 0
                        OpDecorate %_runtimearr_tinput_0 ArrayStride 8
                        OpMemberDecorate %Input2 0 Offset 0
                        OpDecorate %Input2 BufferBlock
                        OpDecorate %input2 DescriptorSet 0
                        OpDecorate %input2 Binding 1
                %void = OpTypeVoid
                   %3 = OpTypeFunction %void
                 %int = OpTypeInt 32 1
   %_ptr_Function_int = OpTypePointer Function %int
               %int_0 = OpConstant %int 0
              %niters = OpConstant %int 12
                %bool = OpTypeBool
     %_runtimearr_int = OpTypeRuntimeArray %int
             %Output1 = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
             %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
              %tinput = OpTypeInt 64 0
  %_runtimearr_tinput = OpTypeRuntimeArray %tinput
              %Input1 = OpTypeStruct %_runtimearr_tinput
 %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
              %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_tinput = OpTypePointer Uniform %tinput
%_runtimearr_tinput_0 = OpTypeRuntimeArray %tinput
              %Input2 = OpTypeStruct %_runtimearr_tinput_0
 %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
              %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
               %int_1 = OpConstant %int 1
    %_ptr_Uniform_int = OpTypePointer Uniform %int
                %main = OpFunction %void None %3
                   %5 = OpLabel
                   %i = OpVariable %_ptr_Function_int Function
                        OpStore %i %int_0
                        OpBranch %10
                  %10 = OpLabel
                        OpLoopMerge %12 %13 None
                        OpBranch %14
                  %14 = OpLabel
                  %15 = OpLoad %int %i
                  %18 = OpSLessThan %bool %15 %niters
                        OpBranchConditional %18 %11 %12
                  %11 = OpLabel
                  %23 = OpLoad %int %i
                  %29 = OpLoad %int %i
                  %31 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %29
                  %32 = OpLoad %tinput %31
                  %37 = OpLoad %int %i
                  %38 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %37
                  %39 = OpLoad %tinput %38
                  %40 = OpUGreaterThanEqual %bool %32 %39
                  %42 = OpSelect %int %40 %int_1 %int_0
                  %44 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %23
                        OpStore %44 %42
                        OpBranch %13
                  %13 = OpLabel
                  %45 = OpLoad %int %i
                  %46 = OpIAdd %int %45 %int_1
                        OpStore %i %46
                        OpBranch %10
                  %12 = OpLabel
                        OpReturn
                        OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 3
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 0
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpIEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 3
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 0
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpINotEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 3
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 0
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpULessThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 3
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 0
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpULessThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 3
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 0
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpUGreaterThan %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd

                          OpCapability Shader
                          OpCapability Int64
                          
                          
                     %1 = OpExtInstImport "GLSL.std.450"
                          OpMemoryModel Logical GLSL450
                          OpEntryPoint GLCompute %main "main"
                          
                          OpExecutionMode %main LocalSize 1 1 1
                          OpName %main "main"
                          OpName %i "i"
                          OpName %Output1 "Output1"
                          OpMemberName %Output1 0 "values"
                          OpName %output1 "output1"
                          OpName %Input1 "Input1"
                          OpMemberName %Input1 0 "values"
                          OpName %input1 "input1"
                          OpName %Input2 "Input2"
                          OpMemberName %Input2 0 "values"
                          OpName %input2 "input2"
                          OpDecorate %_runtimearr_v4int ArrayStride 16
                          OpMemberDecorate %Output1 0 Offset 0
                          OpDecorate %Output1 BufferBlock
                          OpDecorate %output1 DescriptorSet 0
                          OpDecorate %output1 Binding 2
                          OpDecorate %_runtimearr_v4tinput ArrayStride 32
                          OpMemberDecorate %Input1 0 Offset 0
                          OpDecorate %Input1 BufferBlock
                          OpDecorate %input1 DescriptorSet 0
                          OpDecorate %input1 Binding 0
                          OpDecorate %_runtimearr_v4tinput_0 ArrayStride 32
                          OpMemberDecorate %Input2 0 Offset 0
                          OpDecorate %Input2 BufferBlock
                          OpDecorate %input2 DescriptorSet 0
                          OpDecorate %input2 Binding 1
                  %void = OpTypeVoid
                     %3 = OpTypeFunction %void
                   %int = OpTypeInt 32 1
     %_ptr_Function_int = OpTypePointer Function %int
                 %int_0 = OpConstant %int 0
                %niters = OpConstant %int 3
                  %bool = OpTypeBool
                 %v4int = OpTypeVector %int 4
     %_runtimearr_v4int = OpTypeRuntimeArray %v4int
               %Output1 = OpTypeStruct %_runtimearr_v4int
  %_ptr_Uniform_Output1 = OpTypePointer Uniform %Output1
               %output1 = OpVariable %_ptr_Uniform_Output1 Uniform
                %tinput = OpTypeInt 64 0
              %v4tinput = OpTypeVector %tinput 4
  %_runtimearr_v4tinput = OpTypeRuntimeArray %v4tinput
                %Input1 = OpTypeStruct %_runtimearr_v4tinput
   %_ptr_Uniform_Input1 = OpTypePointer Uniform %Input1
                %input1 = OpVariable %_ptr_Uniform_Input1 Uniform
 %_ptr_Uniform_v4tinput = OpTypePointer Uniform %v4tinput
%_runtimearr_v4tinput_0 = OpTypeRuntimeArray %v4tinput
                %Input2 = OpTypeStruct %_runtimearr_v4tinput_0
   %_ptr_Uniform_Input2 = OpTypePointer Uniform %Input2
                %input2 = OpVariable %_ptr_Uniform_Input2 Uniform
                %v4bool = OpTypeVector %bool 4
                 %int_1 = OpConstant %int 1
                    %45 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                    %46 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
    %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                  %main = OpFunction %void None %3
                     %5 = OpLabel
                     %i = OpVariable %_ptr_Function_int Function
                          OpStore %i %int_0
                          OpBranch %10
                    %10 = OpLabel
                          OpLoopMerge %12 %13 None
                          OpBranch %14
                    %14 = OpLabel
                    %15 = OpLoad %int %i
                    %18 = OpSLessThan %bool %15 %niters
                          OpBranchConditional %18 %11 %12
                    %11 = OpLabel
                    %24 = OpLoad %int %i
                    %31 = OpLoad %int %i
                    %33 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %31
                    %34 = OpLoad %v4tinput %33
                    %39 = OpLoad %int %i
                    %40 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %39
                    %41 = OpLoad %v4tinput %40
                    %43 = OpUGreaterThanEqual %v4bool %34 %41
                    %47 = OpSelect %v4int %43 %46 %45
                    %49 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %24
                          OpStore %49 %47
                          OpBranch %13
                    %13 = OpLabel
                    %50 = OpLoad %int %i
                    %51 = OpIAdd %int %50 %int_1
                          OpStore %i %51
                          OpBranch %10
                    %12 = OpLabel
                          OpReturn
                          OpFunctionEnd
