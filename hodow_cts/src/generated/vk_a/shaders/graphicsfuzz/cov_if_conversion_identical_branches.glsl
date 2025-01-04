#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 40
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %9 "buf0"
               OpMemberName %9 0 "zero"
               OpName %11 ""
               OpName %34 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %34 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpConstant %6 0
         %13 = OpTypePointer Uniform %6
         %17 = OpTypeBool
         %22 = OpConstant %6 1
         %31 = OpTypeFloat 32
         %32 = OpTypeVector %31 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
         %35 = OpConstant %31 1
         %36 = OpConstant %31 0
         %37 = OpConstantComposite %32 %35 %36 %36 %35
         %39 = OpConstantComposite %32 %36 %36 %36 %36
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %14 = OpAccessChain %13 %11 %12
         %15 = OpLoad %6 %14
               OpStore %8 %15
         %16 = OpLoad %6 %8
         %18 = OpIEqual %17 %16 %12
               OpSelectionMerge %20 None
               OpBranchConditional %18 %19 %24
         %19 = OpLabel
         %21 = OpLoad %6 %8
         %23 = OpIAdd %6 %21 %22
               OpStore %8 %23
               OpBranch %20
         %24 = OpLabel
         %25 = OpLoad %6 %8
         %26 = OpIAdd %6 %25 %22
               OpStore %8 %26
               OpBranch %20
         %20 = OpLabel
         %27 = OpLoad %6 %8
         %28 = OpIEqual %17 %27 %22
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %38
         %29 = OpLabel
               OpStore %34 %37
               OpBranch %30
         %38 = OpLabel
               OpStore %34 %39
               OpBranch %30
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
