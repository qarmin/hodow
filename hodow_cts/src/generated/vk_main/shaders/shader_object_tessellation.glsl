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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Quads
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
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor
               OpExecutionMode %main OriginUpperLeft
               OpSource GLSL 450
               OpName %main "main"
               OpName %outColor "outColor"
               OpDecorate %outColor Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_1 = OpConstant %float 1
         %11 = OpConstantComposite %v4float %float_1 %float_1 %float_1 %float_1
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCw
               OpExecutionMode %main PointMode

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Triangles

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCw

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCcw
               OpExecutionMode %main PointMode

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingFractionalOdd
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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCw
               OpExecutionMode %main PointMode

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 5

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCw
               OpExecutionMode %main PointMode

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Quads

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCcw
               OpExecutionMode %main PointMode

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCw

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCcw

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCw
               OpExecutionMode %main PointMode

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCw

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCcw
               OpExecutionMode %main PointMode

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCcw

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCw
               OpExecutionMode %main PointMode

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 5
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCcw

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCcw

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCw
               OpExecutionMode %main PointMode

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
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationControl %main "main" %gl_InvocationID %gl_TessLevelInner %gl_TessLevelOuter %gl_out %gl_in
               OpExecutionMode %main OutputVertices 4
               OpExecutionMode %main Quads
               OpExecutionMode %main SpacingEqual
               OpExecutionMode %main VertexOrderCcw
               OpExecutionMode %main PointMode

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %gl_InvocationID "gl_InvocationID"  ; id %8
               OpName %gl_TessLevelInner "gl_TessLevelInner"  ; id %20
               OpName %gl_TessLevelOuter "gl_TessLevelOuter"  ; id %29
               OpName %gl_PerVertex "gl_PerVertex"  ; id %39
               OpMemberName %gl_PerVertex 0 "gl_Position"
               OpMemberName %gl_PerVertex 1 "gl_PointSize"
               OpMemberName %gl_PerVertex 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex 3 "gl_CullDistance"
               OpName %gl_out "gl_out"  ; id %42
               OpName %gl_PerVertex_0 "gl_PerVertex"  ; id %44
               OpMemberName %gl_PerVertex_0 0 "gl_Position"
               OpMemberName %gl_PerVertex_0 1 "gl_PointSize"
               OpMemberName %gl_PerVertex_0 2 "gl_ClipDistance"
               OpMemberName %gl_PerVertex_0 3 "gl_CullDistance"
               OpName %gl_in "gl_in"  ; id %48

               ; Annotations
               OpDecorate %gl_InvocationID BuiltIn InvocationId
               OpDecorate %gl_TessLevelInner Patch
               OpDecorate %gl_TessLevelInner BuiltIn TessLevelInner
               OpDecorate %gl_TessLevelOuter Patch
               OpDecorate %gl_TessLevelOuter BuiltIn TessLevelOuter
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

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Input_int = OpTypePointer Input %int
%gl_InvocationID = OpVariable %_ptr_Input_int Input
      %int_0 = OpConstant %int 0
       %bool = OpTypeBool
      %float = OpTypeFloat 32
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_float_uint_2 = OpTypeArray %float %uint_2
%_ptr_Output__arr_float_uint_2 = OpTypePointer Output %_arr_float_uint_2
%gl_TessLevelInner = OpVariable %_ptr_Output__arr_float_uint_2 Output
    %float_2 = OpConstant %float 2
%_ptr_Output_float = OpTypePointer Output %float
      %int_1 = OpConstant %int 1
     %uint_4 = OpConstant %uint 4
%_arr_float_uint_4 = OpTypeArray %float %uint_4
%_ptr_Output__arr_float_uint_4 = OpTypePointer Output %_arr_float_uint_4
%gl_TessLevelOuter = OpVariable %_ptr_Output__arr_float_uint_4 Output
      %int_2 = OpConstant %int 2
      %int_3 = OpConstant %int 3
    %v4float = OpTypeVector %float 4
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1 = OpTypeArray %float %uint_1
%gl_PerVertex = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
%_arr_gl_PerVertex_uint_4 = OpTypeArray %gl_PerVertex %uint_4
%_ptr_Output__arr_gl_PerVertex_uint_4 = OpTypePointer Output %_arr_gl_PerVertex_uint_4
     %gl_out = OpVariable %_ptr_Output__arr_gl_PerVertex_uint_4 Output
%gl_PerVertex_0 = OpTypeStruct %v4float %float %_arr_float_uint_1 %_arr_float_uint_1
    %uint_32 = OpConstant %uint 32
%_arr_gl_PerVertex_0_uint_32 = OpTypeArray %gl_PerVertex_0 %uint_32
%_ptr_Input__arr_gl_PerVertex_0_uint_32 = OpTypePointer Input %_arr_gl_PerVertex_0_uint_32
      %gl_in = OpVariable %_ptr_Input__arr_gl_PerVertex_0_uint_32 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Output_v4float = OpTypePointer Output %v4float

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
          %9 = OpLoad %int %gl_InvocationID
         %12 = OpIEqual %bool %9 %int_0
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
         %23 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_0
               OpStore %23 %float_2
         %25 = OpAccessChain %_ptr_Output_float %gl_TessLevelInner %int_1
               OpStore %25 %float_2
         %30 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_0
               OpStore %30 %float_2
         %31 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_1
               OpStore %31 %float_2
         %33 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_2
               OpStore %33 %float_2
         %35 = OpAccessChain %_ptr_Output_float %gl_TessLevelOuter %int_3
               OpStore %35 %float_2
               OpBranch %14
         %14 = OpLabel
         %43 = OpLoad %int %gl_InvocationID
         %49 = OpLoad %int %gl_InvocationID
         %51 = OpAccessChain %_ptr_Input_v4float %gl_in %49 %int_0
         %52 = OpLoad %v4float %51
         %54 = OpAccessChain %_ptr_Output_v4float %gl_out %43 %int_0
               OpStore %54 %52
               OpReturn
               OpFunctionEnd
               OpCapability Tessellation
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint TessellationEvaluation %main "main" %gl_TessCoord %_ %gl_in %gl_PatchVerticesIn
               OpExecutionMode %main Triangles
               OpExecutionMode %main SpacingFractionalOdd
               OpExecutionMode %main VertexOrderCw

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
