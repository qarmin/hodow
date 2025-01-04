#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 26
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %20
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %20 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %10 RelaxedPrecision
               OpDecorate %11 RelaxedPrecision
               OpDecorate %20 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 3
         %12 = OpConstant %6 -4
         %13 = OpTypeBool
         %17 = OpTypeFloat 32
         %18 = OpTypeVector %17 4
         %19 = OpTypePointer Output %18
         %20 = OpVariable %19 Output
         %21 = OpConstant %17 1
         %22 = OpConstant %17 0
         %23 = OpConstantComposite %18 %21 %22 %22 %21
         %25 = OpConstantComposite %18 %22 %22 %22 %22
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %10 = OpLoad %6 %8
         %11 = OpNot %6 %10
         %14 = OpIEqual %13 %11 %12
               OpSelectionMerge %16 None
               OpBranchConditional %14 %15 %24
         %15 = OpLabel
               OpStore %20 %23
               OpBranch %16
         %24 = OpLabel
               OpStore %20 %25
               OpBranch %16
         %16 = OpLabel
               OpReturn
               OpFunctionEnd
