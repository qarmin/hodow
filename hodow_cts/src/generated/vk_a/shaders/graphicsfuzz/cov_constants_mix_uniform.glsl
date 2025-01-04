#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 42
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %32
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "mixed"
               OpName %12 "buf0"
               OpMemberName %12 0 "one"
               OpName %14 ""
               OpName %32 "_GLF_color"
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %32 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstantComposite %7 %10 %10
         %12 = OpTypeStruct %7
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %7
         %20 = OpConstant %6 0.5
         %24 = OpTypeBool
         %25 = OpTypeVector %24 2
         %30 = OpTypeVector %6 4
         %31 = OpTypePointer Output %30
         %32 = OpVariable %31 Output
         %33 = OpTypeInt 32 0
         %34 = OpConstant %33 0
         %35 = OpTypePointer Function %6
         %38 = OpConstant %6 0
         %41 = OpConstantComposite %30 %38 %38 %38 %38
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %18 = OpAccessChain %17 %14 %16
         %19 = OpLoad %7 %18
         %21 = OpCompositeConstruct %7 %20 %20
         %22 = OpExtInst %7 %1 FMix %11 %19 %21
               OpStore %9 %22
         %23 = OpLoad %7 %9
         %26 = OpFOrdEqual %25 %23 %11
         %27 = OpAll %24 %26
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %40
         %28 = OpLabel
         %36 = OpAccessChain %35 %9 %34
         %37 = OpLoad %6 %36
         %39 = OpCompositeConstruct %30 %37 %38 %38 %10
               OpStore %32 %39
               OpBranch %29
         %40 = OpLabel
               OpStore %32 %41
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
