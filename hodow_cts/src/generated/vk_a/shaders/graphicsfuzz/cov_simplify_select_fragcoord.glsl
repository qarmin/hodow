#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 46
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %13 %42
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %13 "gl_FragCoord"
               OpName %30 "buf0"
               OpMemberName %30 0 "one"
               OpName %32 ""
               OpName %42 "_GLF_color"
               OpDecorate %13 BuiltIn FragCoord
               OpMemberDecorate %30 0 Offset 0
               OpDecorate %30 Block
               OpDecorate %32 DescriptorSet 0
               OpDecorate %32 Binding 0
               OpDecorate %42 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %10 = OpConstant %6 0
         %11 = OpTypeVector %6 4
         %12 = OpTypePointer Input %11
         %13 = OpVariable %12 Input
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 1
         %16 = OpTypePointer Input %6
         %19 = OpTypeBool
         %23 = OpTypeVector %6 3
         %24 = OpTypeMatrix %23 3
         %30 = OpTypeStruct %6
         %31 = OpTypePointer Uniform %30
         %32 = OpVariable %31 Uniform
         %33 = OpTypeInt 32 1
         %34 = OpConstant %33 0
         %35 = OpTypePointer Uniform %6
         %41 = OpTypePointer Output %11
         %42 = OpVariable %41 Output
         %43 = OpConstantComposite %11 %9 %10 %10 %9
         %45 = OpConstantComposite %11 %10 %10 %10 %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %17 = OpAccessChain %16 %13 %15
         %18 = OpLoad %6 %17
         %20 = OpFOrdLessThan %19 %18 %10
         %21 = OpSelect %6 %20 %10 %9
               OpStore %8 %21
         %22 = OpLoad %6 %8
         %25 = OpCompositeConstruct %23 %22 %10 %10
         %26 = OpCompositeConstruct %23 %10 %22 %10
         %27 = OpCompositeConstruct %23 %10 %10 %22
         %28 = OpCompositeConstruct %24 %25 %26 %27
         %29 = OpExtInst %6 %1 Determinant %28
         %36 = OpAccessChain %35 %32 %34
         %37 = OpLoad %6 %36
         %38 = OpFOrdEqual %19 %29 %37
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %44
         %39 = OpLabel
               OpStore %42 %43
               OpBranch %40
         %44 = OpLabel
               OpStore %42 %45
               OpBranch %40
         %40 = OpLabel
               OpReturn
               OpFunctionEnd
