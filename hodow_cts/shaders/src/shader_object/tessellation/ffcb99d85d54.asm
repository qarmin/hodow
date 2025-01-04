               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Vertex %main "main" %gl_VertexIndex %_
               OpSource GLSL 450
               OpName %main "main"
               OpName %pos "pos"
               OpName %gl_VertexIndex "gl_VertexIndex"
               OpName %gl_PerVertex "gl_PerVertex"
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %_ ""
               OpDecorate %gl_VertexIndex BuiltIn VertexIndex
               OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
               OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
               OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
               OpMemberDecorate %gl_PerVertex 3 BuiltIn CullDistance
               OpDecorate %gl_PerVertex Block
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v2float = OpTypeVector %float 2
%_ptr_Function_v2float = OpTypePointer Function %v2float
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_VertexIndex = OpVariable %_ptr_Input_int Input
      %int_1 = OpConstant %int 1
    %v4float = OpTypeVector %float 4
       %uint = OpTypeInt 32 0
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
          %_ = OpVariable %_ptr_Output_gl_PerVertex Output
      %int_0 = OpConstant %int 0
  %float_0_5 = OpConstant %float 0.5
    %float_0 = OpConstant %float 0
    %float_1 = OpConstant %float 1
%_ptr_Output_v4float = OpTypePointer Output %v4float
       %main = OpFunction %void None %3
          %5 = OpLabel
        %pos = OpVariable %_ptr_Function_v2float Function
         %13 = OpLoad %int %gl_VertexIndex
         %15 = OpBitwiseAnd %int %13 %int_1
         %16 = OpConvertSToF %float %15
         %17 = OpLoad %int %gl_VertexIndex
         %18 = OpShiftRightArithmetic %int %17 %int_1
         %19 = OpBitwiseAnd %int %18 %int_1
         %20 = OpConvertSToF %float %19
         %21 = OpCompositeConstruct %v2float %16 %20
               OpStore %pos %21
         %30 = OpLoad %v2float %pos
         %32 = OpCompositeConstruct %v2float %float_0_5 %float_0_5
         %33 = OpFSub %v2float %30 %32
         %36 = OpCompositeExtract %float %33 0
         %37 = OpCompositeExtract %float %33 1
         %38 = OpCompositeConstruct %v4float %36 %37 %float_0 %float_1
         %40 = OpAccessChain %_ptr_Output_v4float %_ %int_0
               OpStore %40 %38
               OpReturn
               OpFunctionEnd
