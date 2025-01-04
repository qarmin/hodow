#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 29
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %23
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "one"
               OpName %10 ""
               OpName %23 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %23 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpConstant %6 -1
          %8 = OpTypeStruct %6
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpConstant %6 0
         %12 = OpTypePointer Uniform %6
         %16 = OpTypeBool
         %20 = OpTypeFloat 32
         %21 = OpTypeVector %20 4
         %22 = OpTypePointer Output %21
         %23 = OpVariable %22 Output
         %24 = OpConstant %20 1
         %25 = OpConstant %20 0
         %26 = OpConstantComposite %21 %24 %25 %25 %24
         %28 = OpConstantComposite %21 %25 %25 %25 %25
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %13 = OpAccessChain %12 %10 %11
         %14 = OpLoad %6 %13
         %15 = OpBitwiseOr %6 %7 %14
         %17 = OpIEqual %16 %15 %7
               OpSelectionMerge %19 None
               OpBranchConditional %17 %18 %27
         %18 = OpLabel
               OpStore %23 %26
               OpBranch %19
         %27 = OpLabel
               OpStore %23 %28
               OpBranch %19
         %19 = OpLabel
               OpReturn
               OpFunctionEnd
