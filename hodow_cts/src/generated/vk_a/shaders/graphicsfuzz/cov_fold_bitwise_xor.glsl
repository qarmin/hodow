#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 29
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %23
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "b"
               OpName %23 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %10 RelaxedPrecision
               OpDecorate %12 RelaxedPrecision
               OpDecorate %13 RelaxedPrecision
               OpDecorate %14 RelaxedPrecision
               OpDecorate %23 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 6
         %11 = OpConstant %6 5
         %15 = OpConstant %6 3
         %16 = OpTypeBool
         %20 = OpTypeFloat 32
         %21 = OpTypeVector %20 4
         %22 = OpTypePointer Output %21
         %23 = OpVariable %22 Output
         %24 = OpConstant %20 0
         %25 = OpConstantComposite %21 %24 %24 %24 %24
         %27 = OpConstant %20 1
         %28 = OpConstantComposite %21 %27 %24 %24 %27
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %11
         %12 = OpLoad %6 %8
         %13 = OpLoad %6 %10
         %14 = OpBitwiseXor %6 %12 %13
         %17 = OpINotEqual %16 %14 %15
               OpSelectionMerge %19 None
               OpBranchConditional %17 %18 %26
         %18 = OpLabel
               OpStore %23 %25
               OpBranch %19
         %26 = OpLabel
               OpStore %23 %28
               OpBranch %19
         %19 = OpLabel
               OpReturn
               OpFunctionEnd
