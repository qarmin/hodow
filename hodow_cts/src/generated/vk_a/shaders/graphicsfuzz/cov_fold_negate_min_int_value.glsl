#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 36
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %30
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "minValue"
               OpName %10 "negMinValue"
               OpName %15 "buf0"
               OpMemberName %15 0 "minusOne"
               OpName %17 ""
               OpName %30 "_GLF_color"
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %30 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 -2147483648
         %15 = OpTypeStruct %6
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %6 0
         %19 = OpTypePointer Uniform %6
         %23 = OpTypeBool
         %27 = OpTypeFloat 32
         %28 = OpTypeVector %27 4
         %29 = OpTypePointer Output %28
         %30 = OpVariable %29 Output
         %31 = OpConstant %27 1
         %32 = OpConstant %27 0
         %33 = OpConstantComposite %28 %31 %32 %32 %31
         %35 = OpConstantComposite %28 %32 %32 %32 %32
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
               OpStore %8 %9
         %11 = OpLoad %6 %8
         %12 = OpSNegate %6 %11
               OpStore %10 %12
         %13 = OpLoad %6 %10
         %14 = OpLoad %6 %8
         %20 = OpAccessChain %19 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpIMul %6 %14 %21
         %24 = OpIEqual %23 %13 %22
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %34
         %25 = OpLabel
               OpStore %30 %33
               OpBranch %26
         %34 = OpLabel
               OpStore %30 %35
               OpBranch %26
         %26 = OpLabel
               OpReturn
               OpFunctionEnd
