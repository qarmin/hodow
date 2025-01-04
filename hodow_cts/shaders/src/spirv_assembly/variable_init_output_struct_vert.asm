                            OpCapability Shader
                       %1 = OpExtInstImport "GLSL.std.450"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint Vertex %main "main" %_ %position %vtxColor %color %outData
                            OpSource GLSL 430
                            OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                            OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                            OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                            OpDecorate %gl_PerVertex Block
                            OpDecorate %position Location 0
                            OpDecorate %vtxColor Location 1
                            OpDecorate %color Location 1
                            OpDecorate %outData Location 2
                            OpMemberDecorate %Data 0 ColMajor
                            OpMemberDecorate %Data 0 Offset 0
                            OpMemberDecorate %Data 0 MatrixStride 16
                            OpMemberDecorate %Data 1 Offset 32
                            OpMemberDecorate %Data 2 Offset 48
                            OpMemberDecorate %Data 3 Offset 52
                            OpMemberDecorate %Data 4 Offset 56
                            OpMemberDecorate %Data 5 Offset 60
                    %void = OpTypeVoid
                %voidFunc = OpTypeFunction %void
                   %float = OpTypeFloat 32
                 %v4float = OpTypeVector %float 4
                    %uint = OpTypeInt 32 0
                  %uint_1 = OpConstant %uint 1
       %_arr_float_uint_1 = OpTypeArray %float %uint_1
            %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                     %int = OpTypeInt 32 1
                   %int_0 = OpConstant %int 0
      %_ptr_Input_v4float = OpTypePointer Input %v4float
                %position = OpVariable %_ptr_Input_v4float Input
     %_ptr_Output_v4float = OpTypePointer Output %v4float
                %vtxColor = OpVariable %_ptr_Output_v4float Output
                   %color = OpVariable %_ptr_Input_v4float Input
             %mat2v4float = OpTypeMatrix %v4float 2
                    %Data = OpTypeStruct %mat2v4float %v4float %float %float %float %float
              %DataOutput = OpTypeStruct %Data
  %_ptr_Output_DataOutput = OpTypePointer Output %DataOutput
                 %float_1 = OpConstant %float 1
                  %vec4_1 = OpConstantComposite %v4float %float_1 %float_1 %float_1 %float_1
                %matrix_1 = OpConstantComposite %mat2v4float %vec4_1 %vec4_1
 %_ptr_Output_mat2v4float = OpTypePointer Output %mat2v4float
       %_ptr_Output_float = OpTypePointer Output %float
                  %data_1 = OpConstantComposite %Data %matrix_1 %vec4_1 %float_1 %float_1 %float_1 %float_1
                %struct_1 = OpConstantComposite %DataOutput %data_1
     %_ptr_struct_private = OpTypePointer Private %DataOutput
         %struct_global_1 = OpVariable %_ptr_struct_private Private %struct_1
                 %outData = OpVariable %_ptr_Output_DataOutput Output %${initSource}
                    %main = OpFunction %void None %voidFunc
                   %entry = OpLabel
                 %posData = OpLoad %v4float %position
                  %posPtr = OpAccessChain %_ptr_Output_v4float %_ %int_0
                            OpStore %posPtr %posData
               %colorData = OpLoad %v4float %color
                            OpStore %vtxColor %colorData
                            OpReturn
                            OpFunctionEnd
