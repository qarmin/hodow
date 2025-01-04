#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 39
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %33 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %15 RelaxedPrecision
               OpDecorate %20 RelaxedPrecision
               OpDecorate %21 RelaxedPrecision
               OpDecorate %22 RelaxedPrecision
               OpDecorate %24 RelaxedPrecision
               OpDecorate %25 RelaxedPrecision
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 5
         %16 = OpConstant %6 0
         %17 = OpTypeBool
         %19 = OpConstant %6 3
         %23 = OpConstant %6 1
         %26 = OpConstant %6 -1
         %30 = OpTypeFloat 32
         %31 = OpTypeVector %30 4
         %32 = OpTypePointer Output %31
         %33 = OpVariable %32 Output
         %34 = OpConstant %30 1
         %35 = OpConstant %30 0
         %36 = OpConstantComposite %31 %34 %35 %35 %34
         %38 = OpConstantComposite %31 %35 %35 %35 %35
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %6 %8
         %18 = OpSGreaterThanEqual %17 %15 %16
               OpBranchConditional %18 %11 %12
         %11 = OpLabel
         %20 = OpLoad %6 %8
         %21 = OpISub %6 %20 %19
               OpStore %8 %21
         %22 = OpLoad %6 %8
         %24 = OpIAdd %6 %22 %23
               OpStore %8 %24
               OpBranch %13
         %13 = OpLabel
               OpBranch %10
         %12 = OpLabel
         %25 = OpLoad %6 %8
         %27 = OpIEqual %17 %25 %26
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %37
         %28 = OpLabel
               OpStore %33 %36
               OpBranch %29
         %37 = OpLabel
               OpStore %33 %38
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
