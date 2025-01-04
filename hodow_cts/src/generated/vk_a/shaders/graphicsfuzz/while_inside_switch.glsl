#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 45
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3 %4
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %3 "gl_FragCoord"
               OpName %4 "_GLF_color"
               OpName %5 "buf0"
               OpMemberName %5 0 "injectionSwitch"
               OpName %6 ""
               OpDecorate %3 BuiltIn FragCoord
               OpDecorate %4 Location 0
               OpMemberDecorate %5 0 Offset 0
               OpDecorate %5 Block
               OpDecorate %6 DescriptorSet 0
               OpDecorate %6 Binding 0
          %7 = OpTypeVoid
          %8 = OpTypeFunction %7
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 4
         %11 = OpTypePointer Input %10
          %3 = OpVariable %11 Input
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 0
         %14 = OpTypePointer Input %9
         %15 = OpConstant %9 10
         %16 = OpTypeBool
         %17 = OpTypePointer Output %10
          %4 = OpVariable %17 Output
         %18 = OpConstant %9 1
         %19 = OpConstant %9 0
         %20 = OpConstantComposite %10 %18 %19 %19 %18
         %21 = OpTypeVector %9 2
          %5 = OpTypeStruct %21
         %22 = OpTypePointer Uniform %5
          %6 = OpVariable %22 Uniform
         %23 = OpTypeInt 32 1
         %24 = OpConstant %23 0
         %25 = OpTypePointer Uniform %9
          %2 = OpFunction %7 None %8
         %26 = OpLabel
               OpBranch %27
         %27 = OpLabel
               OpLoopMerge %28 %29 None
               OpBranch %30
         %30 = OpLabel
         %31 = OpAccessChain %14 %3 %13
         %32 = OpLoad %9 %31
         %33 = OpFOrdLessThan %16 %32 %15
               OpSelectionMerge %34 None
               OpBranchConditional %33 %35 %34
         %35 = OpLabel
               OpStore %4 %20
               OpBranch %28
         %34 = OpLabel
         %36 = OpAccessChain %25 %6 %24 %13
         %37 = OpLoad %9 %36
         %38 = OpConvertFToS %23 %37
               OpSelectionMerge %39 None
               OpSwitch %38 %39 0 %40
         %40 = OpLabel
               OpBranch %41
         %41 = OpLabel
               OpLoopMerge %42 %43 None
               OpBranch %44
         %44 = OpLabel
               OpTerminateInvocation
         %43 = OpLabel
               OpBranch %41
         %42 = OpLabel
               OpUnreachable
         %39 = OpLabel
               OpStore %4 %20
               OpBranch %28
         %29 = OpLabel
               OpBranch %27
         %28 = OpLabel
               OpReturn
               OpFunctionEnd
