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
               OpEntryPoint Fragment %4 "main" %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "buf0"
               OpMemberName %9 0 "three"
               OpName %11 ""
               OpName %28 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %28 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpConstant %6 1
          %8 = OpConstant %6 2
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpTypePointer Uniform %6
         %17 = OpConstant %6 4
         %18 = OpTypeVector %6 4
         %20 = OpConstant %6 0
         %21 = OpConstantComposite %18 %20 %7 %20 %20
         %23 = OpTypeBool
         %27 = OpTypePointer Output %18
         %28 = OpVariable %27 Output
         %29 = OpConstantComposite %18 %7 %20 %20 %7
         %31 = OpConstantComposite %18 %20 %20 %20 %20
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %6 %15
         %19 = OpCompositeConstruct %18 %7 %8 %16 %17
         %22 = OpDot %6 %19 %21
         %24 = OpFOrdEqual %23 %22 %8
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %30
         %25 = OpLabel
               OpStore %28 %29
               OpBranch %26
         %30 = OpLabel
               OpStore %28 %31
               OpBranch %26
         %26 = OpLabel
               OpReturn
               OpFunctionEnd
