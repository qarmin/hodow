#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 41
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %36
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %11 "buf0"
               OpMemberName %11 0 "quarter"
               OpName %13 ""
               OpName %36 "_GLF_color"
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 0
               OpDecorate %36 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 424.113007
         %11 = OpTypeStruct %6
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpTypeInt 32 1
         %15 = OpConstant %14 0
         %16 = OpTypePointer Uniform %6
         %19 = OpConstant %6 1.29999995
         %20 = OpConstant %6 19.6200008
         %24 = OpConstant %6 425
         %25 = OpConstant %6 1
         %26 = OpConstant %6 2
         %27 = OpConstant %6 20
         %28 = OpConstantComposite %7 %24 %25 %26 %27
         %29 = OpTypeBool
         %30 = OpTypeVector %29 4
         %35 = OpTypePointer Output %7
         %36 = OpVariable %35 Output
         %37 = OpConstant %6 0
         %38 = OpConstantComposite %7 %25 %37 %37 %25
         %40 = OpConstantComposite %7 %37 %37 %37 %37
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %17 = OpAccessChain %16 %13 %15
         %18 = OpLoad %6 %17
         %21 = OpCompositeConstruct %7 %10 %18 %19 %20
         %22 = OpExtInst %7 %1 Ceil %21
               OpStore %9 %22
         %23 = OpLoad %7 %9
         %31 = OpFOrdEqual %30 %23 %28
         %32 = OpAll %29 %31
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %39
         %33 = OpLabel
               OpStore %36 %38
               OpBranch %34
         %39 = OpLabel
               OpStore %36 %40
               OpBranch %34
         %34 = OpLabel
               OpReturn
               OpFunctionEnd
