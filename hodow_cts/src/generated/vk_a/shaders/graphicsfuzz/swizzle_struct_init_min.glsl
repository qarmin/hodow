#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 45
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3 %4
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %3 "gl_FragCoord"
               OpName %4 "_GLF_color"
               OpName %5 "buf0"
               OpMemberName %5 0 "injectionSwitch"
               OpName %6 ""
               OpDecorate %3 BuiltIn FragCoord
               OpDecorate %4 Location 0
               OpMemberDecorate %5 0 Offset 0
               OpDecorate %5 Block
               OpDecorate %6 DescriptorSet 0
               OpDecorate %6 Binding 0
          %7 = OpTypeVoid
          %8 = OpTypeFunction %7
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 4
         %11 = OpTypePointer Input %10
          %3 = OpVariable %11 Input
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 0
         %14 = OpTypePointer Input %9
         %15 = OpConstant %9 10
         %16 = OpTypeBool
         %17 = OpTypePointer Output %10
          %4 = OpVariable %17 Output
         %18 = OpConstant %9 1
         %19 = OpConstant %9 0
         %20 = OpConstantComposite %10 %18 %19 %19 %18
         %21 = OpTypeVector %9 2
          %5 = OpTypeStruct %21
         %22 = OpTypePointer Uniform %5
          %6 = OpVariable %22 Uniform
         %23 = OpTypeInt 32 1
         %24 = OpConstant %23 0
         %25 = OpConstant %12 1
         %26 = OpTypePointer Uniform %9
         %27 = OpConstantComposite %10 %18 %18 %18 %18
          %2 = OpFunction %7 None %8
         %28 = OpLabel
               OpBranch %29
         %29 = OpLabel
               OpLoopMerge %30 %31 None
               OpBranch %32
         %32 = OpLabel
         %33 = OpAccessChain %14 %3 %13
         %34 = OpLoad %9 %33
         %35 = OpFOrdLessThan %16 %34 %15
               OpSelectionMerge %36 None
               OpBranchConditional %35 %37 %36
         %37 = OpLabel
               OpStore %4 %20
               OpBranch %30
         %36 = OpLabel
         %38 = OpAccessChain %26 %6 %24 %25
         %39 = OpLoad %9 %38
         %40 = OpCompositeConstruct %10 %39 %39 %39 %39
         %41 = OpVectorShuffle %10 %40 %40 4 5 2 3
         %42 = OpExtInst %10 %1 FMin %27 %41
         %43 = OpCompositeExtract %9 %42 0
         %44 = OpCompositeConstruct %10 %43 %19 %19 %18
               OpStore %4 %44
               OpBranch %30
         %31 = OpLabel
               OpBranch %29
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
