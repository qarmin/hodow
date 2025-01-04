#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 53
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %13
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "computeColor("
               OpName %13 "_GLF_color"
               OpName %19 "_injected_loop_counter"
               OpName %29 "buf0"
               OpMemberName %29 0 "injectionSwitch"
               OpName %31 ""
               OpDecorate %13 Location 0
               OpDecorate %19 RelaxedPrecision
               OpMemberDecorate %29 0 Offset 0
               OpDecorate %29 Block
               OpDecorate %31 DescriptorSet 0
               OpDecorate %31 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeVector %6 4
         %12 = OpTypePointer Output %11
         %13 = OpVariable %12 Output
         %14 = OpConstant %6 1
         %15 = OpConstant %6 0
         %16 = OpConstantComposite %11 %14 %15 %15 %14
         %17 = OpTypeInt 32 1
         %18 = OpTypePointer Function %17
         %20 = OpConstant %17 1
         %26 = OpTypeBool
         %27 = OpConstantTrue %26
         %28 = OpTypeVector %6 2
         %29 = OpTypeStruct %28
         %30 = OpTypePointer Uniform %29
         %31 = OpVariable %30 Uniform
         %32 = OpConstant %17 0
         %33 = OpTypeInt 32 0
         %34 = OpConstant %33 0
         %35 = OpTypePointer Uniform %6
         %47 = OpConstantComposite %7 %14 %14 %14
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %51 = OpFunctionCall %7 %9
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %19 = OpVariable %18 Function
               OpStore %13 %16
               OpStore %19 %20
               OpBranch %21
         %21 = OpLabel
               OpLoopMerge %23 %45 None
               OpBranch %22
         %22 = OpLabel
         %36 = OpAccessChain %35 %31 %32 %34
         %37 = OpLoad %6 %36
         %38 = OpFOrdGreaterThan %26 %37 %14
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %40
         %39 = OpLabel
         %41 = OpAccessChain %35 %31 %32 %34
         %42 = OpLoad %6 %41
         %43 = OpFOrdGreaterThan %26 %42 %14
               OpSelectionMerge %52 None
               OpBranchConditional %43 %44 %45
         %44 = OpLabel
               OpBranch %45
         %52 = OpLabel
               OpBranch %45
         %45 = OpLabel
               OpBranch %21
         %40 = OpLabel
               OpReturnValue %47
         %23 = OpLabel
               OpUnreachable
               OpFunctionEnd
