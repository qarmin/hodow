#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 45
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf0"
               OpMemberName %14 0 "injected"
               OpName %16 ""
               OpName %37 "m"
               OpDecorate %9 Location 0
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %37 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %13 = OpTypeVector %6 2
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Uniform %6
         %24 = OpConstant %19 1
         %27 = OpTypeBool
         %35 = OpConstantFalse %27
         %36 = OpTypePointer Function %17
         %38 = OpConstant %17 1
         %44 = OpConstantTrue %27
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %37 = OpVariable %36 Function
               OpStore %9 %12
         %22 = OpAccessChain %21 %16 %18 %20
         %23 = OpLoad %6 %22
         %25 = OpAccessChain %21 %16 %18 %24
         %26 = OpLoad %6 %25
         %28 = OpFOrdGreaterThan %27 %23 %26
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %30
         %29 = OpLabel
               OpBranch %31
         %31 = OpLabel
               OpLoopMerge %33 %34 None
               OpBranch %32
         %32 = OpLabel
               OpBranch %34
         %34 = OpLabel
               OpBranchConditional %35 %31 %33
         %33 = OpLabel
               OpStore %37 %38
               OpBranch %39
         %39 = OpLabel
               OpLoopMerge %41 %42 None
               OpBranch %43
         %43 = OpLabel
               OpBranchConditional %44 %40 %41
         %40 = OpLabel
               OpStore %9 %12
               OpBranch %42
         %42 = OpLabel
               OpBranch %39
         %41 = OpLabel
               OpBranch %30
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
