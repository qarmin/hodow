#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 28
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %24
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %24 "_GLF_color"
               OpDecorate %24 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeMatrix %7 2
          %9 = OpConstant %6 1
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %9 %10
         %12 = OpConstantComposite %7 %10 %9
         %13 = OpConstantComposite %8 %11 %12
         %16 = OpConstantComposite %7 %10 %10
         %18 = OpTypeBool
         %22 = OpTypeVector %6 4
         %23 = OpTypePointer Output %22
         %24 = OpVariable %23 Output
         %25 = OpConstantComposite %22 %9 %10 %10 %9
         %27 = OpConstantComposite %22 %10 %10 %10 %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpExtInst %6 %1 Determinant %13
         %15 = OpCompositeConstruct %7 %14 %10
         %17 = OpDot %6 %15 %16
         %19 = OpFOrdEqual %18 %17 %10
               OpSelectionMerge %21 None
               OpBranchConditional %19 %20 %26
         %20 = OpLabel
               OpStore %24 %25
               OpBranch %21
         %26 = OpLabel
               OpStore %24 %27
               OpBranch %21
         %21 = OpLabel
               OpReturn
               OpFunctionEnd
