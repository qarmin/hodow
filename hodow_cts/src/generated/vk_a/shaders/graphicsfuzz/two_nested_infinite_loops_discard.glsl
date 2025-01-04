#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 64
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %57
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "mand("
               OpName %13 "k"
               OpName %31 "buf0"
               OpMemberName %31 0 "injectionSwitch"
               OpName %33 ""
               OpName %45 "j"
               OpName %57 "_GLF_color"
               OpDecorate %13 RelaxedPrecision
               OpMemberDecorate %31 0 Offset 0
               OpDecorate %31 Block
               OpDecorate %33 DescriptorSet 0
               OpDecorate %33 Binding 0
               OpDecorate %45 RelaxedPrecision
               OpDecorate %57 Location 0
               OpDecorate %14 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeInt 32 1
         %12 = OpTypePointer Function %11
         %14 = OpConstant %11 0
         %21 = OpConstant %11 1000
         %22 = OpTypeBool
         %25 = OpConstant %11 1
         %26 = OpConstant %6 1
         %27 = OpConstantComposite %7 %26 %26 %26
         %30 = OpTypeVector %6 2
         %31 = OpTypeStruct %30
         %32 = OpTypePointer Uniform %31
         %33 = OpVariable %32 Uniform
         %34 = OpTypeInt 32 0
         %35 = OpConstant %34 0
         %36 = OpTypePointer Uniform %6
         %39 = OpConstant %34 1
         %52 = OpConstant %11 4
         %55 = OpTypeVector %6 4
         %56 = OpTypePointer Output %55
         %57 = OpVariable %56 Output
         %58 = OpConstant %6 0
         %59 = OpConstantComposite %55 %26 %58 %58 %26
         %62 = OpUndef %11
         %63 = OpConstantTrue %22
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %45 = OpVariable %12 Function
         %37 = OpAccessChain %36 %33 %14 %35
         %38 = OpLoad %6 %37
         %40 = OpAccessChain %36 %33 %14 %39
         %41 = OpLoad %6 %40
         %42 = OpFOrdGreaterThan %22 %38 %41
               OpSelectionMerge %44 None
               OpBranchConditional %42 %43 %44
         %43 = OpLabel
               OpStore %45 %14
               OpBranch %46
         %46 = OpLabel
               OpLoopMerge %48 %47 None
               OpBranchConditional %63 %47 %48
         %47 = OpLabel
         %54 = OpFunctionCall %7 %9
               OpBranch %46
         %48 = OpLabel
               OpBranch %44
         %44 = OpLabel
               OpStore %57 %59
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %13 = OpVariable %12 Function
               OpStore %13 %14
               OpBranch %15
         %15 = OpLabel
               OpLoopMerge %17 %18 None
               OpBranchConditional %63 %16 %17
         %16 = OpLabel
               OpTerminateInvocation
         %18 = OpLabel
               OpBranch %15
         %17 = OpLabel
               OpReturnValue %27
               OpFunctionEnd
