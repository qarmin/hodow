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
