#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 33
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "three"
               OpName %10 ""
               OpName %28 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %28 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpConstant %6 2
          %8 = OpTypeStruct %6
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypePointer Uniform %6
         %16 = OpTypeVector %6 2
         %18 = OpConstant %6 0
         %19 = OpConstantComposite %16 %18 %7
         %21 = OpConstant %6 6
         %22 = OpTypeBool
         %26 = OpTypeVector %6 4
         %27 = OpTypePointer Output %26
         %28 = OpVariable %27 Output
         %29 = OpConstant %6 1
         %30 = OpConstantComposite %26 %29 %18 %18 %29
         %32 = OpConstantComposite %26 %18 %18 %18 %18
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpAccessChain %13 %10 %12
         %15 = OpLoad %6 %14
         %17 = OpCompositeConstruct %16 %7 %15
         %20 = OpDot %6 %17 %19
         %23 = OpFOrdEqual %22 %20 %21
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %31
         %24 = OpLabel
               OpStore %28 %30
               OpBranch %25
         %31 = OpLabel
               OpStore %28 %32
               OpBranch %25
         %25 = OpLabel
               OpReturn
               OpFunctionEnd
