#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 49
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %18 "buf0"
               OpMemberName %18 0 "one"
               OpName %20 ""
               OpName %29 "d"
               OpName %40 "_GLF_color"
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %40 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 5
         %11 = OpConstant %6 8
         %12 = OpConstant %6 -12.1999998
         %13 = OpConstantComposite %7 %10 %11 %12
         %14 = OpConstant %6 1
         %15 = OpConstant %6 4.9000001
         %16 = OpConstant %6 -2.0999999
         %17 = OpConstantComposite %7 %14 %15 %16
         %18 = OpTypeStruct %6
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 1
         %22 = OpConstant %21 0
         %23 = OpTypePointer Uniform %6
         %28 = OpTypePointer Function %6
         %33 = OpConstant %6 0.100000001
         %34 = OpTypeBool
         %38 = OpTypeVector %6 4
         %39 = OpTypePointer Output %38
         %40 = OpVariable %39 Output
         %41 = OpTypeInt 32 0
         %42 = OpConstant %41 0
         %45 = OpConstant %6 0
         %48 = OpConstantComposite %38 %45 %45 %45 %45
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %29 = OpVariable %28 Function
         %24 = OpAccessChain %23 %20 %22
         %25 = OpLoad %6 %24
         %26 = OpCompositeConstruct %7 %25 %25 %25
         %27 = OpExtInst %7 %1 FMix %13 %17 %26
               OpStore %9 %27
         %30 = OpLoad %7 %9
         %31 = OpExtInst %6 %1 Distance %30 %17
               OpStore %29 %31
         %32 = OpLoad %6 %29
         %35 = OpFOrdLessThan %34 %32 %33
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %47
         %36 = OpLabel
         %43 = OpAccessChain %28 %9 %42
         %44 = OpLoad %6 %43
         %46 = OpCompositeConstruct %38 %44 %45 %45 %14
               OpStore %40 %46
               OpBranch %37
         %47 = OpLabel
               OpStore %40 %48
               OpBranch %37
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
