#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 26
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %23
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "x"
               OpName %23 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %14 RelaxedPrecision
               OpDecorate %16 RelaxedPrecision
               OpDecorate %23 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 4
         %12 = OpConstant %10 1
         %13 = OpConstantComposite %11 %12 %12 %12 %12
         %15 = OpConstant %6 3
         %18 = OpTypeBool
         %22 = OpTypePointer Output %11
         %23 = OpVariable %22 Output
         %24 = OpConstant %10 0
         %25 = OpConstantComposite %11 %12 %24 %24 %12
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %14 = OpLoad %6 %8
         %16 = OpExtInst %6 %1 SClamp %14 %9 %15
         %17 = OpVectorExtractDynamic %10 %13 %16
         %19 = OpFOrdGreaterThanEqual %18 %17 %12
               OpSelectionMerge %21 None
               OpBranchConditional %19 %20 %21
         %20 = OpLabel
               OpBranch %21
         %21 = OpLabel
               OpStore %23 %25
               OpReturn
               OpFunctionEnd
