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
               OpEntryPoint Fragment %4 "main" %27
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "diff"
               OpName %27 "_GLF_color"
               OpDecorate %27 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 8
         %11 = OpConstant %6 2
         %12 = OpConstant %6 3.5
         %13 = OpConstant %6 3.4000001
         %14 = OpConstantComposite %7 %10 %11 %12 %13
         %18 = OpConstant %6 0
         %19 = OpConstantComposite %7 %18 %18 %18 %18
         %20 = OpTypeBool
         %21 = OpTypeVector %20 4
         %26 = OpTypePointer Output %7
         %27 = OpVariable %26 Output
         %28 = OpConstant %6 1
         %29 = OpConstantComposite %7 %28 %18 %18 %28
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %15 = OpExtInst %7 %1 Acosh %14
         %16 = OpDPdy %7 %15
               OpStore %9 %16
         %17 = OpLoad %7 %9
         %22 = OpFOrdEqual %21 %17 %19
         %23 = OpAll %20 %22
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %30
         %24 = OpLabel
               OpStore %27 %29
               OpBranch %25
         %30 = OpLabel
         %31 = OpLoad %7 %9
               OpStore %27 %31
               OpBranch %25
         %25 = OpLabel
               OpReturn
               OpFunctionEnd
