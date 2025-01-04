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
               OpEntryPoint Fragment %4 "main" %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "buf0"
               OpMemberName %7 0 "one"
               OpName %9 ""
               OpName %28 "_GLF_color"
               OpMemberDecorate %7 0 Offset 0
               OpDecorate %7 Block
               OpDecorate %9 DescriptorSet 0
               OpDecorate %9 Binding 0
               OpDecorate %28 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6
          %8 = OpTypePointer Uniform %7
          %9 = OpVariable %8 Uniform
         %10 = OpConstant %6 0
         %11 = OpTypePointer Uniform %6
         %18 = OpConstant %6 1
         %21 = OpTypeBool
         %25 = OpTypeFloat 32
         %26 = OpTypeVector %25 4
         %27 = OpTypePointer Output %26
         %28 = OpVariable %27 Output
         %29 = OpConstant %25 1
         %30 = OpConstant %25 0
         %31 = OpConstantComposite %26 %29 %30 %30 %29
         %33 = OpConstantComposite %26 %29 %29 %29 %29
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %12 = OpAccessChain %11 %9 %10
         %13 = OpLoad %6 %12
         %14 = OpAccessChain %11 %9 %10
         %15 = OpLoad %6 %14
         %16 = OpAccessChain %11 %9 %10
         %17 = OpLoad %6 %16
         %19 = OpExtInst %6 %1 SClamp %15 %17 %18
         %20 = OpExtInst %6 %1 SMax %13 %19
         %22 = OpIEqual %21 %20 %18
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %32
         %23 = OpLabel
               OpStore %28 %31
               OpBranch %24
         %32 = OpLabel
               OpStore %28 %33
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd
