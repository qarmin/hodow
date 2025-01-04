#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 27
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %19
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %19 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %10 RelaxedPrecision
               OpDecorate %12 RelaxedPrecision
               OpDecorate %19 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 4
         %11 = OpConstant %6 2
         %16 = OpTypeFloat 32
         %17 = OpTypeVector %16 4
         %18 = OpTypePointer Output %17
         %19 = OpVariable %18 Output
         %20 = OpConstant %16 1
         %21 = OpConstant %16 0
         %22 = OpConstantComposite %17 %20 %21 %21 %20
         %24 = OpConstantComposite %17 %21 %21 %21 %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %10 = OpLoad %6 %8
         %12 = OpUDiv %6 %10 %11
               OpSelectionMerge %15 None
               OpSwitch %12 %14 2 %13
         %14 = OpLabel
               OpStore %19 %24
               OpBranch %15
         %13 = OpLabel
               OpStore %19 %22
               OpBranch %15
         %15 = OpLabel
               OpReturn
               OpFunctionEnd
