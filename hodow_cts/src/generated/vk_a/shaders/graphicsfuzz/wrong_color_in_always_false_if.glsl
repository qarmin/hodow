#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 47
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "height"
               OpName %11 "buf0"
               OpMemberName %11 0 "injectionSwitch"
               OpName %13 ""
               OpName %28 "_GLF_color"
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 0
               OpDecorate %28 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 256
         %10 = OpTypeVector %6 2
         %11 = OpTypeStruct %10
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpTypeInt 32 1
         %15 = OpConstant %14 0
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 1
         %18 = OpTypePointer Uniform %6
         %21 = OpConstant %6 0
         %22 = OpTypeBool
         %26 = OpTypeVector %6 4
         %27 = OpTypePointer Output %26
         %28 = OpVariable %27 Output
         %29 = OpConstant %6 30.1800003
         %30 = OpConstant %6 8840.72363
         %31 = OpConstant %6 469.970001
         %32 = OpConstant %6 18.2399998
         %33 = OpConstantComposite %26 %29 %30 %31 %32
         %34 = OpConstant %6 9.89999962
         %35 = OpConstant %6 0.100000001
         %36 = OpConstant %6 1169.5387
         %37 = OpConstant %6 55.7900009
         %38 = OpConstantComposite %26 %34 %35 %36 %37
         %39 = OpConstant %6 7612.94531
         %40 = OpConstant %6 797.010986
         %42 = OpConstant %6 9
         %45 = OpConstant %6 1
         %46 = OpConstantComposite %26 %45 %21 %21 %45
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %19 = OpAccessChain %18 %13 %15 %17
         %20 = OpLoad %6 %19
         %23 = OpFOrdLessThan %22 %20 %21
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %25
         %24 = OpLabel
         %41 = OpLoad %6 %8
         %43 = OpCompositeConstruct %26 %39 %40 %41 %42
         %44 = OpExtInst %26 %1 FMix %33 %38 %43
               OpStore %28 %44
               OpBranch %25
         %25 = OpLabel
               OpStore %28 %46
               OpReturn
               OpFunctionEnd
