#version 450

layout(location = 0) in highp vec4 position;

out gl_PerVertex {
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450

layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    // This will kill half of the samples.
    gl_SampleMask[0] = 0xAAAAAAAA;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450

layout(early_fragment_tests) in;

layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    // Sample mask kills all the samples, but the sample counting has already happened.
    gl_SampleMask[0] = 0x0;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450

layout(early_fragment_tests) in;

layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    // alphaToCoverageEnable = TRUE and emitting 0 alpha kills all the samples, but the sample counting has already happened.
    fragColor = vec4(1.0, 1.0, 0.0, 0.0);
}
; SPIR - V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 23
; Schema: 0
OpCapability Shader
OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %11 %19
OpExecutionMode %4 OriginUpperLeft
OpExecutionMode %4 EarlyAndLateFragmentTestsAMD
OpExecutionMode %4 DepthReplacing
OpExecutionMode %4 DepthLess
OpDecorate %11 BuiltIn SampleMask
OpDecorate %19 Location 0
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 1
%7 = OpTypeInt 32 0
%8 = OpConstant %7 1
%9 = OpTypeArray %6 %8
%10 = OpTypePointer Output %9
%11 = OpVariable %10 Output
%12 = OpConstant %6 0
%13 = OpConstant %6 -1431655766
%14 = OpTypePointer Output %6
%16 = OpTypeFloat 32
%17 = OpTypeVector %16 4
%18 = OpTypePointer Output %17
%19 = OpVariable %18 Output
%20 = OpConstant %16 1
%21 = OpConstant %16 0
%22 = OpConstantComposite %17 %20 %20 %21 %20
%4 = OpFunction %2 None %3
%5 = OpLabel
%15 = OpAccessChain %14 %11 %12
OpStore %15 %13
OpStore %19 %22
OpReturn
OpFunctionEnd
; SPIR - V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 22
; Schema: 0
OpCapability Shader
OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %11 %18
OpExecutionMode %4 OriginUpperLeft
OpExecutionMode %4 EarlyAndLateFragmentTestsAMD
OpDecorate %11 BuiltIn SampleMask
OpDecorate %18 Location 0
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 1
%7 = OpTypeInt 32 0
%8 = OpConstant %7 1
%9 = OpTypeArray %6 %8
%10 = OpTypePointer Output %9
%11 = OpVariable %10 Output
%12 = OpConstant %6 0
%13 = OpTypePointer Output %6
%15 = OpTypeFloat 32
%16 = OpTypeVector %15 4
%17 = OpTypePointer Output %16
%18 = OpVariable %17 Output
%19 = OpConstant %15 1
%20 = OpConstant %15 0
%21 = OpConstantComposite %16 %19 %19 %20 %19
%4 = OpFunction %2 None %3
%5 = OpLabel
%14 = OpAccessChain %13 %11 %12
OpStore %14 %12
OpStore %18 %21
OpReturn
OpFunctionEnd
