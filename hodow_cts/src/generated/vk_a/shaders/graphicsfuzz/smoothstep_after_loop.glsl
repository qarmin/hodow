#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 37
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %32
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %22 "GLF_live9r"
               OpName %28 "g"
               OpName %32 "_GLF_color"
               OpDecorate %32 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
         %11 = OpTypeBool
         %12 = OpConstantTrue %11
         %16 = OpTypeFloat 32
         %17 = OpTypeVector %16 2
         %18 = OpConstant %16 1
         %19 = OpConstantComposite %17 %18 %18
         %20 = OpTypeInt 32 1
         %21 = OpTypePointer Function %20
         %24 = OpConstant %20 0
         %25 = OpConstant %20 1
         %27 = OpTypePointer Function %16
         %29 = OpConstant %16 3
         %30 = OpTypeVector %16 4
         %31 = OpTypePointer Output %30
         %32 = OpVariable %31 Output
         %33 = OpConstant %16 0
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %22 = OpVariable %21 Function
         %28 = OpVariable %27 Function
               OpBranch %6
          %6 = OpLabel
               OpLoopMerge %8 %9 None
               OpBranch %10
         %10 = OpLabel
               OpBranchConditional %12 %7 %8
          %7 = OpLabel
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %14
         %13 = OpLabel
               OpBranch %8
         %14 = OpLabel
         %23 = OpLoad %20 %22
         %26 = OpExtInst %20 %1 SClamp %23 %24 %25
               OpBranch %9
          %9 = OpLabel
               OpBranch %6
          %8 = OpLabel
               OpStore %28 %29
         %34 = OpLoad %16 %28
         %35 = OpExtInst %16 %1 SmoothStep %33 %18 %34
         %36 = OpCompositeConstruct %30 %35 %33 %33 %18
               OpStore %32 %36
               OpReturn
               OpFunctionEnd
