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
               OpEntryPoint Fragment %4 "main" %25
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "one"
               OpName %25 "_GLF_color"
               OpDecorate %25 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %10 = OpTypeVector %6 2
         %11 = OpConstant %6 2
         %12 = OpConstantComposite %10 %11 %9
         %13 = OpTypeBool
         %14 = OpConstantTrue %13
         %15 = OpConstant %6 0
         %23 = OpTypeVector %6 4
         %24 = OpTypePointer Output %23
         %25 = OpVariable %24 Output
         %26 = OpConstantComposite %23 %15 %15 %15 %15
         %28 = OpConstantComposite %23 %9 %15 %15 %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %16 = OpLoad %6 %8
         %17 = OpSelect %6 %14 %15 %16
         %18 = OpCompositeConstruct %10 %9 %17
         %19 = OpDot %6 %12 %18
         %20 = OpFOrdNotEqual %13 %19 %11
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %27
         %21 = OpLabel
               OpStore %25 %26
               OpBranch %22
         %27 = OpLabel
               OpStore %25 %28
               OpBranch %22
         %22 = OpLabel
               OpReturn
               OpFunctionEnd
