#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 33
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %28 "_GLF_color"
               OpDecorate %28 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeVector %6 2
         %11 = OpConstant %6 1
         %12 = OpConstantComposite %10 %11 %11
         %15 = OpConstant %6 2
         %16 = OpConstantComposite %10 %15 %15
         %20 = OpConstantComposite %7 %11 %11 %15 %15
         %21 = OpTypeBool
         %22 = OpTypeVector %21 4
         %27 = OpTypePointer Output %7
         %28 = OpVariable %27 Output
         %29 = OpConstant %6 0
         %30 = OpConstantComposite %7 %11 %29 %29 %11
         %32 = OpConstantComposite %7 %29 %29 %29 %29
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %13 = OpLoad %7 %9
         %14 = OpVectorShuffle %7 %13 %12 4 5 2 3
               OpStore %9 %14
         %17 = OpLoad %7 %9
         %18 = OpVectorShuffle %7 %17 %16 0 1 4 5
               OpStore %9 %18
         %19 = OpLoad %7 %9
         %23 = OpFOrdEqual %22 %19 %20
         %24 = OpAll %21 %23
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %31
         %25 = OpLabel
               OpStore %28 %30
               OpBranch %26
         %31 = OpLabel
               OpStore %28 %32
               OpBranch %26
         %26 = OpLabel
               OpReturn
               OpFunctionEnd
