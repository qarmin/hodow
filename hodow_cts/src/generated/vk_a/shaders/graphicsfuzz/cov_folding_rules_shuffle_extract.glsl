#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 36
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %32
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "injectionSwitch"
               OpName %10 ""
               OpName %32 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %32 Location 0
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
         %18 = OpTypeBool
         %19 = OpTypeVector %18 2
         %20 = OpConstantFalse %18
         %21 = OpConstantComposite %19 %20 %20
         %23 = OpTypeInt 32 0
         %24 = OpConstant %23 0
         %26 = OpConstant %6 0
         %30 = OpTypeVector %6 4
         %31 = OpTypePointer Output %30
         %32 = OpVariable %31 Output
         %33 = OpConstantComposite %30 %16 %26 %26 %16
         %35 = OpConstantComposite %30 %26 %26 %26 %26
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpAccessChain %13 %10 %12
         %15 = OpLoad %7 %14
         %22 = OpSelect %7 %21 %17 %15
         %25 = OpCompositeExtract %6 %22 0
         %27 = OpFOrdEqual %18 %25 %26
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %34
         %28 = OpLabel
               OpStore %32 %33
               OpBranch %29
         %34 = OpLabel
               OpStore %32 %35
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
