#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 39
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "buf0"
               OpMemberName %10 0 "one"
               OpName %12 ""
               OpName %33 "_GLF_color"
               OpMemberDecorate %10 0 Offset 0
               OpDecorate %10 Block
               OpDecorate %12 DescriptorSet 0
               OpDecorate %12 Binding 0
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %10 = OpTypeStruct %6
         %11 = OpTypePointer Uniform %10
         %12 = OpVariable %11 Uniform
         %13 = OpTypePointer Uniform %6
         %20 = OpConstant %6 1
         %22 = OpConstant %6 2
         %26 = OpTypeBool
         %30 = OpTypeFloat 32
         %31 = OpTypeVector %30 4
         %32 = OpTypePointer Output %31
         %33 = OpVariable %32 Output
         %34 = OpConstant %30 1
         %35 = OpConstant %30 0
         %36 = OpConstantComposite %31 %34 %35 %35 %34
         %38 = OpConstantComposite %31 %35 %35 %35 %35
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %14 = OpAccessChain %13 %12 %9
         %15 = OpLoad %6 %14
               OpSelectionMerge %19 None
               OpSwitch %15 %18 2 %16 3 %16 4 %17
         %18 = OpLabel
               OpStore %8 %22
               OpBranch %19
         %16 = OpLabel
               OpStore %8 %20
               OpBranch %17
         %17 = OpLabel
               OpBranch %19
         %19 = OpLabel
         %25 = OpLoad %6 %8
         %27 = OpIEqual %26 %25 %22
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %37
         %28 = OpLabel
               OpStore %33 %36
               OpBranch %29
         %37 = OpLabel
               OpStore %33 %38
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
