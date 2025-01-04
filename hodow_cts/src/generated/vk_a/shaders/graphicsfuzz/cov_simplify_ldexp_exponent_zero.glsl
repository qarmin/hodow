#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 32
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %26
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %9 "buf0"
               OpMemberName %9 0 "three"
               OpName %11 ""
               OpName %26 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %26 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpTypePointer Uniform %6
         %19 = OpConstant %6 3
         %20 = OpTypeBool
         %24 = OpTypeVector %6 4
         %25 = OpTypePointer Output %24
         %26 = OpVariable %25 Output
         %27 = OpConstant %6 1
         %28 = OpConstant %6 0
         %29 = OpConstantComposite %24 %27 %28 %28 %27
         %31 = OpConstantComposite %24 %28 %28 %28 %28
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %6 %15
         %17 = OpExtInst %6 %1 Ldexp %16 %13
               OpStore %8 %17
         %18 = OpLoad %6 %8
         %21 = OpFOrdEqual %20 %18 %19
               OpSelectionMerge %23 None
               OpBranchConditional %21 %22 %30
         %22 = OpLabel
               OpStore %26 %29
               OpBranch %23
         %30 = OpLabel
               OpStore %26 %31
               OpBranch %23
         %23 = OpLabel
               OpReturn
               OpFunctionEnd
