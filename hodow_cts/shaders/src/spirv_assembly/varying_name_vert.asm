                             OpCapability Shader
                        %1 = OpExtInstImport "GLSL.std.450"
                             OpMemoryModel Logical GLSL450
                             OpEntryPoint Vertex %main "main" %_ %position %vtxColor %color %dataOut
                             OpSource GLSL 450
                             OpName %main "main"
                             OpName %gl_PerVertex "gl_PerVertex"
                             OpMemberName %gl_PerVertex 0 "gl_Position"
                             OpMemberName %gl_PerVertex 1 "gl_PointSize"
                             OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
                             OpMemberName %gl_PerVertex 3 "gl_CullDistance"
                             OpName %_ ""
                             OpName %position "position"
                             OpName %vtxColor "vtxColor"
                             OpName %color "color"
${OPNAME_VERT}                             OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
                             OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
                             OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
                             OpMemberDecorate %gl_PerVertex 3 BuiltIn CullDistance
                             OpDecorate %gl_PerVertex Block
                             OpDecorate %position Location 0
                             OpDecorate %vtxColor Location 1
                             OpDecorate %color Location 1
                             OpDecorate %dataOut Location 0
                     %void = OpTypeVoid
                        %3 = OpTypeFunction %void
                    %float = OpTypeFloat 32
                  %v4float = OpTypeVector %float 4
                     %uint = OpTypeInt 32 0
                   %uint_1 = OpConstant %uint 1
        %_arr_float_uint_1 = OpTypeArray %float %uint_1
             %gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
 %_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                        %_ = OpVariable %_ptr_Output_gl_PerVertex Output
                      %int = OpTypeInt 32 1
                    %int_0 = OpConstant %int 0
       %_ptr_Input_v4float = OpTypePointer Input %v4float
                 %position = OpVariable %_ptr_Input_v4float Input
      %_ptr_Output_v4float = OpTypePointer Output %v4float
                 %vtxColor = OpVariable %_ptr_Output_v4float Output
                    %color = OpVariable %_ptr_Input_v4float Input
        %_ptr_Output_float = OpTypePointer Output %float
                  %dataOut = OpVariable %_ptr_Output_float Output
                  %float_1 = OpConstant %float 1
                     %main = OpFunction %void None %3
                        %5 = OpLabel
                       %18 = OpLoad %v4float %position
                       %20 = OpAccessChain %_ptr_Output_v4float %_ %int_0
                             OpStore %20 %18
                       %23 = OpLoad %v4float %color
                             OpStore %vtxColor %23
                             OpStore %dataOut %float_1
                             OpReturn
                             OpFunctionEnd
