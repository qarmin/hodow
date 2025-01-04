#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 31
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %25
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "buf0"
               OpMemberName %9 0 "one"
               OpName %11 ""
               OpName %25 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %25 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpConstant %6 1
          %8 = OpConstant %6 3
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpConstant %6 0
         %13 = OpTypePointer Uniform %6
         %18 = OpTypeBool
         %22 = OpTypeFloat 32
         %23 = OpTypeVector %22 4
         %24 = OpTypePointer Output %23
         %25 = OpVariable %24 Output
         %26 = OpConstant %22 1
         %27 = OpConstant %22 0
         %28 = OpConstantComposite %23 %26 %27 %27 %26
         %30 = OpConstantComposite %23 %27 %27 %27 %27
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpAccessChain %13 %11 %12
         %15 = OpLoad %6 %14
         %16 = OpISub %6 %8 %15
         %17 = OpIAdd %6 %7 %16
         %19 = OpIEqual %18 %17 %8
               OpSelectionMerge %21 None
               OpBranchConditional %19 %20 %29
         %20 = OpLabel
               OpStore %25 %28
               OpBranch %21
         %29 = OpLabel
               OpStore %25 %30
               OpBranch %21
         %21 = OpLabel
               OpReturn
               OpFunctionEnd
