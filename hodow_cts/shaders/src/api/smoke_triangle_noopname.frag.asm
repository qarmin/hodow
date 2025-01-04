OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %9 %11
OpExecutionMode %4 OriginUpperLeft
OpSource ESSL 310
OpDecorate %9 RelaxedPrecision
OpDecorate %9 Location 0
OpDecorate %11 Location 2
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 4
%8 = OpTypePointer Output %7
%9 = OpVariable %8 Output
%10 = OpTypePointer Input %7
%11 = OpVariable %10 Input
%4 = OpFunction %2 None %3
%5 = OpLabel
%12 = OpLoad %7 %11
OpStore %9 %12
OpReturn
OpFunctionEnd
