               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCcw

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %u "u"  ; id %8
               OpName %gl_TessCoord "gl_TessCoord"  ; id %11
               OpName %v "v"  ; id %17
               OpName %omu "omu"  ; id %21
               OpName %omv "omv"  ; id %25
               OpName %gl_PerVertex "gl_PerVertex"  ; id %30
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %_ ""  ; id %32
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %38
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %42
               OpName %gl_PatchVerticesIn "gl_PatchVerticesIn"  ; id %74

               ; Annotations
               OpDecorate %gl_TessCoord BuiltIn TessCoord
               OpMemberDecorate %gl_PerVertex 0 BuiltIn Position
               OpMemberDecorate %gl_PerVertex 1 BuiltIn PointSize
               OpMemberDecorate %gl_PerVertex 2 BuiltIn ClipDistance
               OpMemberDecorate %gl_PerVertex 3 BuiltIn CullDistance
               OpDecorate %gl_PerVertex Block
               OpMemberDecorate %gl_PerVertex_0 0 BuiltIn Position
               OpMemberDecorate %gl_PerVertex_0 1 BuiltIn PointSize
               OpMemberDecorate %gl_PerVertex_0 2 BuiltIn ClipDistance
               OpMemberDecorate %gl_PerVertex_0 3 BuiltIn CullDistance
               OpDecorate %gl_PerVertex_0 Block
               OpDecorate %gl_PatchVerticesIn BuiltIn PatchVertices

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
%_ptr_Function_float = OpTypePointer Function %float
    %v3float = OpTypeVector %float 3
%_ptr_Input_v3float = OpTypePointer Input %v3float
%gl_TessCoord = OpVariable %_ptr_Input_v3float Input
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 0
%_ptr_Input_float = OpTypePointer Input %float
     %uint_1 = OpConstant %uint 1
    %float_1 = OpConstant %float 1
    %v4float = OpTypeVector %float 4
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_ptr_Output_gl_PerVertex = OpTypePointer Output %gl_PerVertex
          %_ = OpVariable %_ptr_Output_gl_PerVertex Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
      %int_1 = OpConstant %int 1
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Input_int = OpTypePointer Input %int
%gl_PatchVerticesIn = OpVariable %_ptr_Input_int Input
      %int_4 = OpConstant %int 4
       %bool = OpTypeBool
%float_0_300000012 = OpConstant %float 0.300000012
%_ptr_Output_float = OpTypePointer Output %float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %u = OpVariable %_ptr_Function_float Function
          %v = OpVariable %_ptr_Function_float Function
        %omu = OpVariable %_ptr_Function_float Function
        %omv = OpVariable %_ptr_Function_float Function
         %15 = OpAccessChain %_ptr_Input_float %gl_TessCoord %uint_0
         %16 = OpLoad %float %15
               OpStore %u %16
         %19 = OpAccessChain %_ptr_Input_float %gl_TessCoord %uint_1
         %20 = OpLoad %float %19
               OpStore %v %20
         %23 = OpLoad %float %u
         %24 = OpFSub %float %float_1 %23
               OpStore %omu %24
         %26 = OpLoad %float %v
         %27 = OpFSub %float %float_1 %26
               OpStore %omv %27
         %35 = OpLoad %float %omu
         %36 = OpLoad %float %omv
         %37 = OpFMul %float %35 %36
         %44 = OpAccessChain %_ptr_Input_v4float %gl_in %int_0 %int_0
         %45 = OpLoad %v4float %44
         %46 = OpVectorTimesScalar %v4float %45 %37
         %47 = OpLoad %float %u
         %48 = OpLoad %float %omv
         %49 = OpFMul %float %47 %48
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %int_2 %int_0
         %52 = OpLoad %v4float %51
         %53 = OpVectorTimesScalar %v4float %52 %49
         %54 = OpFAdd %v4float %46 %53
         %55 = OpLoad %float %u
         %56 = OpLoad %float %v
         %57 = OpFMul %float %55 %56
         %59 = OpAccessChain %_ptr_Input_v4float %gl_in %int_3 %int_0
         %60 = OpLoad %v4float %59
         %61 = OpVectorTimesScalar %v4float %60 %57
         %62 = OpFAdd %v4float %54 %61
         %63 = OpLoad %float %omu
         %64 = OpLoad %float %v
         %65 = OpFMul %float %63 %64
         %67 = OpAccessChain %_ptr_Input_v4float %gl_in %int_1 %int_0
         %68 = OpLoad %v4float %67
         %69 = OpVectorTimesScalar %v4float %68 %65
         %70 = OpFAdd %v4float %62 %69
         %72 = OpAccessChain %_ptr_Output_v4float %_ %int_0
               OpStore %72 %70
         %75 = OpLoad %int %gl_PatchVerticesIn
         %78 = OpSGreaterThan %bool %75 %int_4
               OpSelectionMerge %80 None
               OpBranchConditional %78 %79 %80
         %79 = OpLabel
         %83 = OpAccessChain %_ptr_Output_float %_ %int_0 %uint_1
         %84 = OpLoad %float %83
         %85 = OpFAdd %float %84 %float_0_300000012
         %86 = OpAccessChain %_ptr_Output_float %_ %int_0 %uint_1
               OpStore %86 %85
               OpBranch %80
         %80 = OpLabel
               OpReturn
               OpFunctionEnd
