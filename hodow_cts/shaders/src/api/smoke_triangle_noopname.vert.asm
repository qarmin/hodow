OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %4 "main" %20 %22 %26
OpSource ESSL 310
OpMemberDecorate %18 0 BuiltIn Position
OpMemberDecorate %18 1 BuiltIn PointSize
OpDecorate %18 Block
OpDecorate %22 Location 0
OpDecorate %26 Location 2
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 4
%8 = OpTypeStruct %7
%9 = OpTypePointer Function %8
%11 = OpTypeInt 32 1
%12 = OpConstant %11 0
%13 = OpConstant %6 1
%14 = OpConstant %6 0
%15 = OpConstantComposite %7 %13 %14 %13 %13
%16 = OpTypePointer Function %7
%18 = OpTypeStruct %7 %6
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypePointer Input %7
%22 = OpVariable %21 Input
%24 = OpTypePointer Output %7
%26 = OpVariable %24 Output
%4 = OpFunction %2 None %3
%5 = OpLabel
%10 = OpVariable %9 Function
%17 = OpAccessChain %16 %10 %12
OpStore %17 %15
%23 = OpLoad %7 %22
%25 = OpAccessChain %24 %20 %12
OpStore %25 %23
%27 = OpAccessChain %16 %10 %12
%28 = OpLoad %7 %27
OpStore %26 %28
OpReturn
OpFunctionEnd
