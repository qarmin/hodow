        OpCapability Shader
%1 =    OpExtInstImport "GLSL.std.450"
        OpMemoryModel Logical GLSL450
        OpEntryPoint Fragment %4 "main" %10
        OpExecutionMode %4 OriginUpperLeft
        OpSource ESSL 300
        OpName %4 "main"
        OpName %10 "o_color"
        OpDecorate %10 RelaxedPrecision
        OpDecorate %10 Location 0
%2 =    OpTypeVoid
%3 =    OpTypeFunction %2
%7 =    OpTypeFloat 32
%8 =    OpTypeVector %7 4
%9 =    OpTypePointer Output %8
%10 =    OpVariable %9 Output
%11 =    OpConstant %7 1065353216
%12 =    OpConstant %7 0
%13 =    OpConstantComposite %8 %11 %12 %11 %11
%4 =    OpFunction %2 None %3
%5 =    OpLabel
        OpStore %10 %13
        OpBranch %6
%6 =    OpLabel
        OpReturn
        OpFunctionEnd
