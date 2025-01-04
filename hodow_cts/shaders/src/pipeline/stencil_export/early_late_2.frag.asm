; SPIR-V
; Version: 1.0
; Bound: 36
; Schema: 0
OpCapability Shader
OpCapability StencilExportEXT
OpExtension "SPV_EXT_shader_stencil_export"
OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %12 %31
OpExecutionMode %4 StencilRefReplacingEXT
OpExecutionMode %4 OriginUpperLeft
OpExecutionMode %4 EarlyAndLateFragmentTestsAMD
OpExecutionMode %4 StencilRefGreaterBackAMD
OpDecorate %12 BuiltIn FragCoord
OpDecorate %31 BuiltIn FragStencilRefEXT
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 1
%7 = OpTypePointer Function %6
%9 = OpTypeFloat 32
%10 = OpTypeVector %9 4
%11 = OpTypePointer Input %10
%12 = OpVariable %11 Input
%13 = OpTypeInt 32 0
%14 = OpConstant %13 0
%15 = OpTypePointer Input %9
%19 = OpConstant %6 4
%21 = OpConstant %6 2
%24 = OpConstant %13 1
%30 = OpTypePointer Output %6
%31 = OpVariable %30 Output
%4 = OpFunction %2 None %3
%5 = OpLabel
%8 = OpVariable %7 Function
%23 = OpVariable %7 Function
%16 = OpAccessChain %15 %12 %14
%17 = OpLoad %9 %16
%18 = OpConvertFToS %6 %17
%20 = OpShiftRightArithmetic %6 %18 %19
%22 = OpSMod %6 %20 %21
OpStore %8 %22
%25 = OpAccessChain %15 %12 %24
%26 = OpLoad %9 %25
%27 = OpConvertFToS %6 %26
%28 = OpShiftRightArithmetic %6 %27 %19
%29 = OpSMod %6 %28 %21
OpStore %23 %29
%32 = OpLoad %6 %8
%33 = OpLoad %6 %23
%34 = OpIAdd %6 %32 %33
%35 = OpSMod %6 %34 %21
OpStore %31 %35
OpReturn
OpFunctionEnd
