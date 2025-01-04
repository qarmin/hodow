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
               OpEntryPoint Fragment %4 "main" %21
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %21 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %10 RelaxedPrecision
               OpDecorate %12 RelaxedPrecision
               OpDecorate %21 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 5
         %11 = OpConstant %6 1
         %13 = OpConstant %6 2
         %14 = OpTypeBool
         %18 = OpTypeFloat 32
         %19 = OpTypeVector %18 4
         %20 = OpTypePointer Output %19
         %21 = OpVariable %20 Output
         %22 = OpConstant %18 0
         %23 = OpConstantComposite %19 %22 %22 %22 %22
         %25 = OpConstant %18 1
         %26 = OpConstantComposite %19 %25 %22 %22 %25
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %10 = OpLoad %6 %8
         %12 = OpShiftRightArithmetic %6 %10 %11
         %15 = OpINotEqual %14 %12 %13
               OpSelectionMerge %17 None
               OpBranchConditional %15 %16 %24
         %16 = OpLabel
               OpStore %21 %23
               OpBranch %17
         %24 = OpLabel
               OpStore %21 %26
               OpBranch %17
         %17 = OpLabel
               OpReturn
               OpFunctionEnd
