#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 47
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %31 %44
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %6 "f("
               OpName %15 "buf0"
               OpMemberName %15 0 "injectionSwitch"
               OpName %17 ""
               OpName %31 "gl_FragCoord"
               OpName %44 "_GLF_color"
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %31 BuiltIn FragCoord
               OpDecorate %44 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
         %12 = OpTypeFloat 32
         %13 = OpConstant %12 1
         %14 = OpTypeVector %12 2
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpTypeInt 32 1
         %19 = OpConstant %18 0
         %20 = OpTypeInt 32 0
         %21 = OpConstant %20 1
         %22 = OpTypePointer Uniform %12
         %25 = OpTypeBool
         %29 = OpTypeVector %12 4
         %30 = OpTypePointer Input %29
         %31 = OpVariable %30 Input
         %32 = OpTypePointer Input %12
         %35 = OpConstant %12 0
         %41 = OpConstantFalse %25
         %43 = OpTypePointer Output %29
         %44 = OpVariable %43 Output
         %45 = OpConstantComposite %29 %13 %35 %35 %13
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %42 = OpFunctionCall %2 %6
               OpStore %44 %45
               OpReturn
               OpFunctionEnd
          %6 = OpFunction %2 None %3
          %7 = OpLabel
               OpBranch %8
          %8 = OpLabel
               OpLoopMerge %10 %38 None
               OpBranch %9
          %9 = OpLabel
         %23 = OpAccessChain %22 %17 %19 %21
         %24 = OpLoad %12 %23
         %26 = OpFOrdGreaterThan %25 %13 %24
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %28
         %27 = OpLabel
         %33 = OpAccessChain %32 %31 %21
         %34 = OpLoad %12 %33
         %36 = OpFOrdLessThan %25 %34 %35
               OpSelectionMerge %46 None
               OpBranchConditional %36 %37 %38
         %37 = OpLabel
               OpBranch %38
         %46 = OpLabel
               OpBranch %38
         %38 = OpLabel
               OpBranchConditional %41 %8 %10
         %28 = OpLabel
               OpTerminateInvocation
         %10 = OpLabel
               OpReturn
               OpFunctionEnd
