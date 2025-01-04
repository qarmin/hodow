#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 46
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %43
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "drawShape("
               OpName %11 "computePoint("
               OpName %22 "buf0"
               OpMemberName %22 0 "injectionSwitch"
               OpName %24 ""
               OpName %43 "_GLF_color"
               OpMemberDecorate %22 0 Offset 0
               OpDecorate %22 Block
               OpDecorate %24 DescriptorSet 0
               OpDecorate %24 Binding 0
               OpDecorate %43 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %14 = OpConstant %6 1
         %15 = OpConstantComposite %7 %14 %14 %14
         %21 = OpTypeVector %6 2
         %22 = OpTypeStruct %21
         %23 = OpTypePointer Uniform %22
         %24 = OpVariable %23 Uniform
         %25 = OpTypeInt 32 1
         %26 = OpConstant %25 0
         %27 = OpTypeInt 32 0
         %28 = OpConstant %27 0
         %29 = OpTypePointer Uniform %6
         %32 = OpConstant %27 1
         %35 = OpTypeBool
         %41 = OpTypeVector %6 4
         %42 = OpTypePointer Output %41
         %43 = OpVariable %42 Output
         %44 = OpConstant %6 0
         %45 = OpConstantComposite %41 %14 %44 %44 %14
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %30 = OpAccessChain %29 %24 %26 %28
         %31 = OpLoad %6 %30
         %33 = OpAccessChain %29 %24 %26 %32
         %34 = OpLoad %6 %33
         %36 = OpFOrdGreaterThan %35 %31 %34
               OpSelectionMerge %38 None
               OpBranchConditional %36 %37 %38
         %37 = OpLabel
         %39 = OpFunctionCall %7 %9
         %40 = OpFunctionCall %7 %11
               OpBranch %38
         %38 = OpLabel
               OpStore %43 %45
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
               OpTerminateInvocation
               OpFunctionEnd
         %11 = OpFunction %7 None %8
         %12 = OpLabel
         %18 = OpFunctionCall %7 %9
               OpReturnValue %15
               OpFunctionEnd
