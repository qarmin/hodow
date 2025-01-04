#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 32
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %26
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "buf0"
               OpMemberName %9 0 "three"
               OpName %11 ""
               OpName %26 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %26 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpConstant %6 10
          %8 = OpConstant %6 2
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpConstant %6 0
         %13 = OpTypePointer Uniform %6
         %18 = OpConstant %6 5
         %19 = OpTypeBool
         %23 = OpTypeFloat 32
         %24 = OpTypeVector %23 4
         %25 = OpTypePointer Output %24
         %26 = OpVariable %25 Output
         %27 = OpConstant %23 1
         %28 = OpConstant %23 0
         %29 = OpConstantComposite %24 %27 %28 %28 %27
         %31 = OpConstantComposite %24 %28 %28 %28 %28
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpAccessChain %13 %11 %12
         %15 = OpLoad %6 %14
         %16 = OpBitwiseAnd %6 %8 %15
         %17 = OpSDiv %6 %7 %16
         %20 = OpIEqual %19 %17 %18
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %30
         %21 = OpLabel
               OpStore %26 %29
               OpBranch %22
         %30 = OpLabel
               OpStore %26 %31
               OpBranch %22
         %22 = OpLabel
               OpReturn
               OpFunctionEnd
