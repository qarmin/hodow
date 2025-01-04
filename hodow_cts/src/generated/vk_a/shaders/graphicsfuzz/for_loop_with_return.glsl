#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 36
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "mand("
               OpName %33 "_GLF_color"
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %15 = OpConstant %6 1
         %16 = OpConstantComposite %7 %15 %15 %15
         %31 = OpTypeVector %6 4
         %32 = OpTypePointer Output %31
         %33 = OpVariable %32 Output
         %34 = OpConstant %6 0
         %35 = OpConstantComposite %31 %15 %34 %34 %15
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %21 = OpFunctionCall %7 %9
               OpBranch %26
         %26 = OpLabel
               OpLoopMerge %28 %29 None
               OpBranch %27
         %27 = OpLabel
               OpStore %33 %35
               OpReturn
         %29 = OpLabel
               OpBranch %26
         %28 = OpLabel
               OpUnreachable
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
               OpBranch %11
         %11 = OpLabel
               OpLoopMerge %13 %14 None
               OpBranch %12
         %12 = OpLabel
               OpReturnValue %16
         %14 = OpLabel
               OpBranch %11
         %13 = OpLabel
               OpUnreachable
               OpFunctionEnd
