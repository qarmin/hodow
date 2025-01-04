#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 25
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %19
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "f"
               OpName %19 "_GLF_color"
               OpDecorate %19 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 2
         %12 = OpConstant %6 4
         %13 = OpTypeBool
         %17 = OpTypeVector %6 4
         %18 = OpTypePointer Output %17
         %19 = OpVariable %18 Output
         %20 = OpConstant %6 1
         %21 = OpConstant %6 0
         %22 = OpConstantComposite %17 %20 %21 %21 %20
         %24 = OpConstantComposite %17 %21 %21 %21 %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %10 = OpLoad %6 %8
         %11 = OpExtInst %6 %1 Exp2 %10
         %14 = OpFOrdEqual %13 %11 %12
               OpSelectionMerge %16 None
               OpBranchConditional %14 %15 %23
         %15 = OpLabel
               OpStore %19 %22
               OpBranch %16
         %23 = OpLabel
               OpStore %19 %24
               OpBranch %16
         %16 = OpLabel
               OpReturn
               OpFunctionEnd
