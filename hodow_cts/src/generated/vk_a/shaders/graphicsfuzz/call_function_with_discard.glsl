#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 35
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %25
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %6 "func("
               OpName %10 "buf0"
               OpMemberName %10 0 "one"
               OpName %12 ""
               OpName %25 "_GLF_color"
               OpMemberDecorate %10 0 Offset 0
               OpDecorate %10 Block
               OpDecorate %12 DescriptorSet 0
               OpDecorate %12 Binding 0
               OpDecorate %25 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %8 = OpTypeFloat 32
          %9 = OpConstant %8 1
         %10 = OpTypeStruct %8
         %11 = OpTypePointer Uniform %10
         %12 = OpVariable %11 Uniform
         %13 = OpTypeInt 32 1
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %8
         %18 = OpTypeBool
         %23 = OpTypeVector %8 4
         %24 = OpTypePointer Output %23
         %25 = OpVariable %24 Output
         %26 = OpConstant %8 0
         %27 = OpConstantComposite %23 %26 %26 %26 %26
         %33 = OpConstantFalse %18
         %34 = OpConstantComposite %23 %9 %26 %26 %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpStore %25 %27
               OpBranch %28
         %28 = OpLabel
         %32 = OpFunctionCall %2 %6
               OpLoopMerge %30 %28 None
               OpBranchConditional %33 %28 %30
         %30 = OpLabel
               OpStore %25 %34
               OpReturn
               OpFunctionEnd
          %6 = OpFunction %2 None %3
          %7 = OpLabel
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %8 %16
         %19 = OpFOrdGreaterThan %18 %9 %17
               OpSelectionMerge %21 None
               OpBranchConditional %19 %20 %21
         %20 = OpLabel
               OpTerminateInvocation
         %21 = OpLabel
               OpReturn
               OpFunctionEnd
