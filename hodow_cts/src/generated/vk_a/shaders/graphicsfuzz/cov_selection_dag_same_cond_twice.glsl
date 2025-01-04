#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 34
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %13 "buf0"
               OpMemberName %13 0 "one"
               OpName %15 ""
               OpDecorate %9 Location 0
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %10 %10 %10 %10
         %12 = OpTypeBool
         %13 = OpTypeStruct %6
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %30 = OpConstant %6 1
         %31 = OpConstantComposite %7 %30 %30 %30 %30
         %33 = OpConstantComposite %7 %30 %10 %10 %30
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpStore %9 %11
         %19 = OpAccessChain %18 %15 %17
         %20 = OpLoad %6 %19
         %21 = OpFOrdLessThan %12 %20 %10
               OpSelectionMerge %23 None
               OpBranchConditional %21 %22 %23
         %22 = OpLabel
         %24 = OpAccessChain %18 %15 %17
         %25 = OpLoad %6 %24
         %26 = OpFOrdLessThan %12 %25 %10
               OpBranch %23
         %23 = OpLabel
         %27 = OpPhi %12 %21 %5 %26 %22
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %32
         %28 = OpLabel
               OpStore %9 %31
               OpBranch %29
         %32 = OpLabel
               OpStore %9 %33
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
