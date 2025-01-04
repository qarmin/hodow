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
               OpEntryPoint Fragment %4 "main" %37
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %9 "buf0"
               OpMemberName %9 0 "five"
               OpName %11 ""
               OpName %37 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %37 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpConstant %6 0
         %13 = OpTypePointer Uniform %6
         %22 = OpTypeBool
         %25 = OpConstant %6 1
         %30 = OpConstant %6 -1
         %34 = OpTypeFloat 32
         %35 = OpTypeVector %34 4
         %36 = OpTypePointer Output %35
         %37 = OpVariable %36 Output
         %38 = OpConstant %34 1
         %39 = OpConstant %34 0
         %40 = OpConstantComposite %35 %38 %39 %39 %38
         %42 = OpConstantComposite %35 %39 %39 %39 %39
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %14 = OpAccessChain %13 %11 %12
         %15 = OpLoad %6 %14
               OpStore %8 %15
               OpBranch %16
         %16 = OpLabel
               OpLoopMerge %18 %19 None
               OpBranch %20
         %20 = OpLabel
         %21 = OpLoad %6 %8
         %23 = OpSGreaterThan %22 %21 %12
               OpBranchConditional %23 %17 %18
         %17 = OpLabel
         %24 = OpLoad %6 %8
         %26 = OpISub %6 %24 %25
               OpStore %8 %26
         %27 = OpLoad %6 %8
         %28 = OpISub %6 %27 %25
               OpStore %8 %28
               OpBranch %19
         %19 = OpLabel
               OpBranch %16
         %18 = OpLabel
         %29 = OpLoad %6 %8
         %31 = OpIEqual %22 %29 %30
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %41
         %32 = OpLabel
               OpStore %37 %40
               OpBranch %33
         %41 = OpLabel
               OpStore %37 %42
               OpBranch %33
         %33 = OpLabel
               OpReturn
               OpFunctionEnd
