#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 35
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %31
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "injectionSwitch"
               OpName %10 ""
               OpName %31 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %31 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeStruct %7
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %6
         %18 = OpConstant %6 1
         %19 = OpTypeBool
         %28 = OpConstantTrue %19
         %29 = OpTypeVector %6 4
         %30 = OpTypePointer Output %29
         %31 = OpVariable %30 Output
         %32 = OpConstant %6 0
         %33 = OpConstantComposite %29 %32 %32 %32 %18
         %34 = OpConstantComposite %29 %18 %32 %32 %18
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %16 = OpAccessChain %15 %10 %12 %14
         %17 = OpLoad %6 %16
         %20 = OpFOrdGreaterThan %19 %17 %18
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %22
         %21 = OpLabel
               OpBranch %23
         %23 = OpLabel
               OpLoopMerge %25 %26 None
               OpBranch %27
         %27 = OpLabel
               OpBranch %24
         %24 = OpLabel
               OpStore %31 %33
               OpBranch %26
         %26 = OpLabel
               OpBranch %23
         %25 = OpLabel
               OpUnreachable
         %22 = OpLabel
               OpStore %31 %34
               OpReturn
               OpFunctionEnd
