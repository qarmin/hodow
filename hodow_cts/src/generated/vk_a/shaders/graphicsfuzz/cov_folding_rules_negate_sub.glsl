#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 34
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "x"
               OpName %10 "buf0"
               OpMemberName %10 0 "one"
               OpName %12 ""
               OpName %28 "_GLF_color"
               OpMemberDecorate %10 0 Offset 0
               OpDecorate %10 Block
               OpDecorate %12 DescriptorSet 0
               OpDecorate %12 Binding 0
               OpDecorate %28 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 5
         %10 = OpTypeStruct %6
         %11 = OpTypePointer Uniform %10
         %12 = OpVariable %11 Uniform
         %13 = OpConstant %6 0
         %14 = OpTypePointer Uniform %6
         %20 = OpConstant %6 -4
         %21 = OpTypeBool
         %25 = OpTypeFloat 32
         %26 = OpTypeVector %25 4
         %27 = OpTypePointer Output %26
         %28 = OpVariable %27 Output
         %29 = OpConstant %25 1
         %30 = OpConstant %25 0
         %31 = OpConstantComposite %26 %29 %30 %30 %29
         %33 = OpConstantComposite %26 %30 %30 %30 %30
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %15 = OpAccessChain %14 %12 %13
         %16 = OpLoad %6 %15
         %17 = OpISub %6 %9 %16
         %18 = OpSNegate %6 %17
               OpStore %8 %18
         %19 = OpLoad %6 %8
         %22 = OpIEqual %21 %19 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %32
         %23 = OpLabel
               OpStore %28 %31
               OpBranch %24
         %32 = OpLabel
               OpStore %28 %33
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd
