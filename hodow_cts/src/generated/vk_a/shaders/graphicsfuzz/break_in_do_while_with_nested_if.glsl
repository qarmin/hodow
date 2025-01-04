#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 39
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %18 "buf0"
               OpMemberName %18 0 "injectionSwitch"
               OpName %20 ""
               OpName %33 "GLF_live12c5"
               OpDecorate %9 Location 0
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %17 = OpTypeVector %6 2
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 1
         %22 = OpConstant %21 0
         %23 = OpTypeInt 32 0
         %24 = OpConstant %23 1
         %25 = OpTypePointer Uniform %6
         %28 = OpTypeBool
         %32 = OpTypePointer Function %28
         %34 = OpConstantFalse %28
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %33 = OpVariable %32 Function
               OpStore %9 %12
               OpBranch %13
         %13 = OpLabel
               OpLoopMerge %15 %37 None
               OpBranch %14
         %14 = OpLabel
         %26 = OpAccessChain %25 %20 %22 %24
         %27 = OpLoad %6 %26
         %29 = OpFOrdLessThan %28 %27 %11
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %31
         %30 = OpLabel
               OpStore %33 %34
         %35 = OpLoad %28 %33
               OpSelectionMerge %38 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
               OpBranch %37
         %38 = OpLabel
               OpBranch %37
         %37 = OpLabel
               OpBranchConditional %34 %13 %15
         %31 = OpLabel
               OpBranch %15
         %15 = OpLabel
               OpReturn
               OpFunctionEnd
