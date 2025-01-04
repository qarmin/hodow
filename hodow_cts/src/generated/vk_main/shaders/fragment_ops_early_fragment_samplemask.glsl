#version 440

layout(location = 0) in highp vec4 position;

out gl_PerVertex {
   vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 440

layout(early_fragment_tests) in;
layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    gl_SampleMask[0] = 0x0;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
    discard;
}
#version 440


layout(location = 0) out highp vec4 fragColor;

layout(binding = 0) coherent buffer Output {
    uint result;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.result, 1u);
    gl_SampleMask[0] = 0x0;
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
    discard;
}
; SPIR - V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 30
; Schema: 0
OpCapability Shader
OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %19 %25
OpExecutionMode %4 OriginUpperLeft
OpExecutionMode %4 EarlyAndLateFragmentTestsAMD
OpMemberDecorate %7 0 Coherent
OpMemberDecorate %7 0 Offset 0
OpDecorate %7 BufferBlock
OpDecorate %9 DescriptorSet 0
OpDecorate %9 Binding 0
OpDecorate %19 BuiltIn SampleMask
OpDecorate %25 Location 0
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%7 = OpTypeStruct %6
%8 = OpTypePointer Uniform %7
%9 = OpVariable %8 Uniform
%10 = OpTypeInt 32 1
%11 = OpConstant %10 0
%12 = OpTypePointer Uniform %6
%14 = OpConstant %6 1
%15 = OpConstant %6 0
%17 = OpTypeArray %10 %14
%18 = OpTypePointer Output %17
%19 = OpVariable %18 Output
%20 = OpTypePointer Output %10
%22 = OpTypeFloat 32
%23 = OpTypeVector %22 4
%24 = OpTypePointer Output %23
%25 = OpVariable %24 Output
%26 = OpConstant %22 1
%27 = OpConstant %22 0
%28 = OpConstantComposite %23 %26 %26 %27 %26
%4 = OpFunction %2 None %3
%5 = OpLabel
%13 = OpAccessChain %12 %9 %11
%16 = OpAtomicIAdd %6 %13 %14 %15 %14
%21 = OpAccessChain %20 %19 %11
OpStore %21 %11
OpStore %25 %28
OpKill
OpFunctionEnd
; SPIR - V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 30
; Schema: 0
OpCapability Shader
OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %19 %25
OpExecutionMode %4 OriginUpperLeft
OpExecutionMode %4 EarlyAndLateFragmentTestsAMD
OpExecutionMode %4 DepthReplacing
OpExecutionMode %4 DepthGreater
OpMemberDecorate %7 0 Coherent
OpMemberDecorate %7 0 Offset 0
OpDecorate %7 BufferBlock
OpDecorate %9 DescriptorSet 0
OpDecorate %9 Binding 0
OpDecorate %19 BuiltIn SampleMask
OpDecorate %25 Location 0
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%7 = OpTypeStruct %6
%8 = OpTypePointer Uniform %7
%9 = OpVariable %8 Uniform
%10 = OpTypeInt 32 1
%11 = OpConstant %10 0
%12 = OpTypePointer Uniform %6
%14 = OpConstant %6 1
%15 = OpConstant %6 0
%17 = OpTypeArray %10 %14
%18 = OpTypePointer Output %17
%19 = OpVariable %18 Output
%20 = OpTypePointer Output %10
%22 = OpTypeFloat 32
%23 = OpTypeVector %22 4
%24 = OpTypePointer Output %23
%25 = OpVariable %24 Output
%26 = OpConstant %22 1
%27 = OpConstant %22 0
%28 = OpConstantComposite %23 %26 %26 %27 %26
%4 = OpFunction %2 None %3
%5 = OpLabel
%13 = OpAccessChain %12 %9 %11
%16 = OpAtomicIAdd %6 %13 %14 %15 %14
%21 = OpAccessChain %20 %19 %11
OpStore %21 %11
OpStore %25 %28
OpKill
OpFunctionEnd
