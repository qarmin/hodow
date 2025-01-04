#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 43
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "i"
               OpName %34 "_GLF_color"
               OpName %40 "buf0"
               OpMemberName %40 0 "two"
               OpName %42 ""
               OpDecorate %34 Location 0
               OpMemberDecorate %40 0 Offset 0
               OpDecorate %40 Block
               OpDecorate %42 DescriptorSet 0
               OpDecorate %42 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %17 = OpConstant %6 2
         %18 = OpTypeBool
         %21 = OpConstant %6 -2
         %23 = OpConstant %6 1
         %31 = OpTypeFloat 32
         %32 = OpTypeVector %31 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
         %35 = OpConstant %31 1
         %36 = OpConstant %31 0
         %37 = OpConstantComposite %32 %35 %36 %36 %35
         %39 = OpConstantComposite %32 %36 %36 %36 %36
         %40 = OpTypeStruct %6
         %41 = OpTypePointer Uniform %40
         %42 = OpVariable %41 Uniform
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %9
               OpBranch %11
         %11 = OpLabel
               OpLoopMerge %13 %14 None
               OpBranch %15
         %15 = OpLabel
         %16 = OpLoad %6 %10
         %19 = OpSLessThan %18 %16 %17
               OpBranchConditional %19 %12 %13
         %12 = OpLabel
         %20 = OpLoad %6 %10
         %22 = OpBitwiseOr %6 %20 %21
         %24 = OpISub %6 %22 %23
               OpStore %8 %24
               OpBranch %14
         %14 = OpLabel
         %25 = OpLoad %6 %10
         %26 = OpIAdd %6 %25 %23
               OpStore %10 %26
               OpBranch %11
         %13 = OpLabel
         %27 = OpLoad %6 %8
         %28 = OpIEqual %18 %27 %21
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %38
         %29 = OpLabel
               OpStore %34 %37
               OpBranch %30
         %38 = OpLabel
               OpStore %34 %39
               OpBranch %30
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
