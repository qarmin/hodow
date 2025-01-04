
                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdNotEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdLessThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdLessThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdGreaterThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdGreaterThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordNotEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordLessThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordLessThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordGreaterThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordGreaterThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdNotEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdLessThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdLessThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdGreaterThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFOrdGreaterThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordNotEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordLessThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordLessThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordGreaterThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpFUnordGreaterThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdNotEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdLessThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdLessThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdGreaterThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdGreaterThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordNotEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordLessThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordLessThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordGreaterThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordGreaterThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdNotEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdLessThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdLessThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdGreaterThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFOrdGreaterThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordNotEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordLessThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordLessThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordGreaterThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Float64
                            OpCapability SignedZeroInfNanPreserve
                            OpExtension "SPV_KHR_float_controls"
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            OpExecutionMode %main SignedZeroInfNanPreserve 64
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpFUnordGreaterThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpIEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpINotEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpSLessThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpSLessThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpSGreaterThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpSGreaterThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpIEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpINotEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpSLessThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpSLessThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpSGreaterThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpSGreaterThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpIEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpINotEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpULessThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpULessThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpUGreaterThan %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
        %_ptr_Uniform_int = OpTypePointer Uniform %int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %39 = OpLoad %int %i
                      %45 = OpLoad %int %i
                      %47 = OpAccessChain %_ptr_Uniform_tinput %input1 %int_0 %45
                      %48 = OpLoad %tinput %47
                      %53 = OpLoad %int %i
                      %54 = OpAccessChain %_ptr_Uniform_tinput %input2 %int_0 %53
                      %55 = OpLoad %tinput %54
                      %56 = OpUGreaterThanEqual %bool %48 %55
                      %57 = OpSelect %int %56 %int_1 %int_0
                      %59 = OpAccessChain %_ptr_Uniform_int %output1 %int_0 %39
                            OpStore %59 %57
                            OpBranch %29
                      %29 = OpLabel
                      %60 = OpLoad %int %i
                      %61 = OpIAdd %int %60 %int_1
                            OpStore %i %61
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpIEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpINotEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpULessThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpULessThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpUGreaterThan %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                            OpCapability Shader
                            OpCapability Int64
                            
                            
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_
                            
                            OpName %main "main"
                            OpName %gl_PerVertex "gl_PerVertex"
                            OpMemberName %gl_PerVertex 0 "gl_Position"
                            OpMemberName %gl_PerVertex 1 "gl_PointSize"
                            OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                            OpName %_ ""
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
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
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
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_1 = OpConstant %int 1
                 %float_1 = OpConstant %float 1
       %_ptr_Output_float = OpTypePointer Output %float
                   %int_0 = OpConstant %int 0
                 %float_0 = OpConstant %float 0
                      %21 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_1
     %_ptr_Output_v4float = OpTypePointer Output %v4float
       %_ptr_Function_int = OpTypePointer Function %int
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
                      %60 = OpConstantComposite %v4int %int_0 %int_0 %int_0 %int_0
                      %61 = OpConstantComposite %v4int %int_1 %int_1 %int_1 %int_1
      %_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
                    %main = OpFunction %void None %3
                       %5 = OpLabel
                       %i = OpVariable %_ptr_Function_int Function
                      %18 = OpAccessChain %_ptr_Output_float %_ %int_1
                            OpStore %18 %float_1
                      %23 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %23 %21
                            OpStore %i %int_0
                            OpBranch %26
                      %26 = OpLabel
                            OpLoopMerge %28 %29 None
                            OpBranch %30
                      %30 = OpLabel
                      %31 = OpLoad %int %i
                      %34 = OpSLessThan %bool %31 %niters
                            OpBranchConditional %34 %27 %28
                      %27 = OpLabel
                      %40 = OpLoad %int %i
                      %47 = OpLoad %int %i
                      %49 = OpAccessChain %_ptr_Uniform_v4tinput %input1 %int_0 %47
                      %50 = OpLoad %v4tinput %49
                      %55 = OpLoad %int %i
                      %56 = OpAccessChain %_ptr_Uniform_v4tinput %input2 %int_0 %55
                      %57 = OpLoad %v4tinput %56
                      %59 = OpUGreaterThanEqual %v4bool %50 %57
                      %62 = OpSelect %v4int %59 %61 %60
                      %64 = OpAccessChain %_ptr_Uniform_v4int %output1 %int_0 %40
                            OpStore %64 %62
                            OpBranch %29
                      %29 = OpLabel
                      %65 = OpLoad %int %i
                      %66 = OpIAdd %int %65 %int_1
                            OpStore %i %66
                            OpBranch %26
                      %28 = OpLabel
                            OpReturn
                            OpFunctionEnd

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
#version 430

layout(location = 0) out vec4 out_color;

void main()
{
        gl_PointSize = 1;
        gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        out_color = vec4(0.0, 0.0, 0.0, 1.0);
}

                        OpCapability Shader
                        OpCapability Float64
                        
                        
                   %1 = OpExtInstImport "GLSL.std.450"
                        OpMemoryModel Logical GLSL450
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        OpExecutionMode %main SignedZeroInfNanPreserve 64
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          OpExecutionMode %main SignedZeroInfNanPreserve 64
                          OpExecutionMode %main OriginUpperLeft
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                        OpEntryPoint Fragment %main "main"
                        
                        OpExecutionMode %main OriginUpperLeft
                        OpSource GLSL 430
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
                          OpEntryPoint Fragment %main "main"
                          
                          OpExecutionMode %main OriginUpperLeft
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
