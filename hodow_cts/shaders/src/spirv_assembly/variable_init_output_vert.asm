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
                            OpDecorate %floatArray ArrayStride 4
                    %void = OpTypeVoid
                       %3 = OpTypeFunction %void
                     %u32 = OpTypeInt 32 0
                     %f32 = OpTypeFloat 32
                   %v4f32 = OpTypeVector %f32 4
                  %matrix = OpTypeMatrix %v4f32 2
                 %c_u32_0 = OpConstant %u32 0
                 %c_u32_8 = OpConstant %u32 8
              %floatArray = OpTypeArray %f32 %c_u32_8
                   %f32_1 = OpConstant %f32 1
        %_ptr_f32_private = OpTypePointer Private %f32
            %f32_global_1 = OpVariable %_ptr_f32_private Private %f32_1
                 %v4f32_1 = OpConstantComposite %v4f32 %f32_1 %f32_1 %f32_1 %f32_1
      %_ptr_v4f32_private = OpTypePointer Private %v4f32
          %v4f32_global_1 = OpVariable %_ptr_v4f32_private Private %v4f32_1
                %matrix_1 = OpConstantComposite %matrix %v4f32_1 %v4f32_1
     %_ptr_matrix_private = OpTypePointer Private %matrix
         %matrix_global_1 = OpVariable %_ptr_matrix_private Private %matrix_1
            %floatArray_1 = OpConstantComposite %floatArray %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1 %f32_1
 %_ptr_floatArray_private = OpTypePointer Private %floatArray
     %floatArray_global_1 = OpVariable %_ptr_floatArray_private Private %floatArray_1
                 %c_u32_1 = OpConstant %u32 1
          %_arr_f32_u32_1 = OpTypeArray %f32 %c_u32_1
            %gl_PerVertex = OpTypeStruct %v4f32 %f32 %_arr_f32_u32_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
                       %_ = OpVariable %_ptr_Output_gl_PerVertex Output
               %outputPtr = OpTypePointer Output %${type}
                 %outData = OpVariable %outputPtr Output %${initSource}
        %_ptr_Input_v4f32 = OpTypePointer Input %v4f32
                %position = OpVariable %_ptr_Input_v4f32 Input
${vec4ptrDeclOutput}                %vtxColor = OpVariable %${vec4ptrOutput} Output
                   %color = OpVariable %_ptr_Input_v4f32 Input
                    %main = OpFunction %void None %3
                   %entry = OpLabel
                 %posData = OpLoad %v4f32 %position
            %posOutputPtr = OpAccessChain %${vec4ptrOutput} %_ %c_u32_0
                            OpStore %posOutputPtr %posData
               %colorData = OpLoad %v4f32 %color
                            OpStore %vtxColor %colorData
                            OpReturn
                            OpFunctionEnd
