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
               OpEntryPoint Fragment %4 "main" %30
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "injectionSwitch"
               OpName %10 ""
               OpName %30 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %30 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeStruct %7
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypePointer Uniform %7
         %16 = OpConstant %6 1
         %17 = OpConstantComposite %7 %16 %16
         %18 = OpConstant %6 0
         %19 = OpConstantComposite %7 %18 %18
         %21 = OpConstantComposite %7 %18 %16
         %22 = OpTypeBool
         %23 = OpTypeVector %22 2
         %28 = OpTypeVector %6 4
         %29 = OpTypePointer Output %28
         %30 = OpVariable %29 Output
         %31 = OpConstantComposite %28 %16 %18 %18 %16
         %33 = OpConstantComposite %28 %18 %18 %18 %18
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpAccessChain %13 %10 %12
         %15 = OpLoad %7 %14
         %20 = OpExtInst %7 %1 FMix %15 %17 %19
         %24 = OpFOrdEqual %23 %20 %21
         %25 = OpAll %22 %24
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %32
         %26 = OpLabel
               OpStore %30 %31
               OpBranch %27
         %32 = OpLabel
               OpStore %30 %33
               OpBranch %27
         %27 = OpLabel
               OpReturn
               OpFunctionEnd
