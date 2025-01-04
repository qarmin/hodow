#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 44
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %15 "GLF_dead6index"
               OpName %18 "buf0"
               OpMemberName %18 0 "injectionSwitch"
               OpName %20 ""
               OpName %36 "GLF_dead6currentNode"
               OpName %39 "donor_replacementGLF_dead6tree"
               OpDecorate %9 Location 0
               OpDecorate %15 RelaxedPrecision
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %36 RelaxedPrecision
               OpDecorate %39 RelaxedPrecision
               OpDecorate %40 RelaxedPrecision
               OpDecorate %42 RelaxedPrecision
               OpDecorate %43 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %13 = OpTypeInt 32 1
         %14 = OpTypePointer Function %13
         %16 = OpConstant %13 0
         %17 = OpTypeVector %6 2
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 1
         %23 = OpTypePointer Uniform %6
         %26 = OpTypeBool
         %35 = OpConstantTrue %26
         %37 = OpTypeArray %13 %22
         %38 = OpTypePointer Function %37
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %15 = OpVariable %14 Function
         %36 = OpVariable %14 Function
         %39 = OpVariable %38 Function
               OpStore %9 %12
               OpStore %15 %16
         %24 = OpAccessChain %23 %20 %16 %22
         %25 = OpLoad %6 %24
         %27 = OpFOrdLessThan %26 %25 %11
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %29
         %28 = OpLabel
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %34
         %34 = OpLabel
               OpBranchConditional %35 %31 %32
         %31 = OpLabel
         %40 = OpLoad %13 %15
         %41 = OpAccessChain %14 %39 %40
         %42 = OpLoad %13 %41
               OpStore %36 %42
         %43 = OpLoad %13 %36
               OpStore %15 %43
               OpBranch %33
         %33 = OpLabel
               OpBranch %30
         %32 = OpLabel
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
