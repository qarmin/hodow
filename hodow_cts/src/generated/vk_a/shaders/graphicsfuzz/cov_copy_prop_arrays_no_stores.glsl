#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 43
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "Array"
               OpMemberName %10 0 "values"
               OpName %12 "a"
               OpName %14 "buf0"
               OpMemberName %14 0 "zero"
               OpName %16 ""
               OpName %23 "b"
               OpName %27 "one"
               OpName %40 "_GLF_color"
               OpMemberDecorate %10 0 RelaxedPrecision
               OpMemberDecorate %14 0 RelaxedPrecision
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %19 RelaxedPrecision
               OpDecorate %30 RelaxedPrecision
               OpDecorate %32 RelaxedPrecision
               OpDecorate %40 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypeStruct %9
         %11 = OpTypePointer Function %10
         %13 = OpConstant %6 0
         %14 = OpTypeStruct %6
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypePointer Uniform %6
         %20 = OpConstant %6 1
         %21 = OpTypePointer Function %6
         %25 = OpTypeFloat 32
         %26 = OpTypePointer Function %25
         %28 = OpConstant %25 0
         %33 = OpTypeBool
         %37 = OpConstant %25 1
         %38 = OpTypeVector %25 4
         %39 = OpTypePointer Output %38
         %40 = OpVariable %39 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %12 = OpVariable %11 Function
         %23 = OpVariable %11 Function
         %27 = OpVariable %26 Function
         %18 = OpAccessChain %17 %16 %13
         %19 = OpLoad %6 %18
         %22 = OpAccessChain %21 %12 %13 %19
               OpStore %22 %20
         %24 = OpLoad %10 %12
               OpStore %23 %24
               OpStore %27 %28
         %29 = OpAccessChain %17 %16 %13
         %30 = OpLoad %6 %29
         %31 = OpAccessChain %21 %23 %13 %30
         %32 = OpLoad %6 %31
         %34 = OpIEqual %33 %32 %20
               OpSelectionMerge %36 None
               OpBranchConditional %34 %35 %36
         %35 = OpLabel
               OpStore %27 %37
               OpBranch %36
         %36 = OpLabel
         %41 = OpLoad %25 %27
         %42 = OpCompositeConstruct %38 %41 %28 %28 %37
               OpStore %40 %42
               OpReturn
               OpFunctionEnd
