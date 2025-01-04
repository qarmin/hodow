#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 29
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %24
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %24 "_GLF_color"
               OpDecorate %24 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %13 = OpConstant %6 0.910000026
         %14 = OpTypeBool
         %17 = OpConstant %6 0.930000007
         %22 = OpTypeVector %6 4
         %23 = OpTypePointer Output %22
         %24 = OpVariable %23 Output
         %25 = OpConstant %6 0
         %26 = OpConstantComposite %22 %9 %25 %25 %9
         %28 = OpConstantComposite %22 %25 %25 %25 %25
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpExtInst %6 %1 Tanh %9
         %11 = OpExtInst %6 %1 Atan2 %9 %10
               OpStore %8 %11
         %12 = OpLoad %6 %8
         %15 = OpFOrdGreaterThan %14 %12 %13
         %16 = OpLoad %6 %8
         %18 = OpFOrdLessThan %14 %16 %17
         %19 = OpLogicalAnd %14 %15 %18
               OpSelectionMerge %21 None
               OpBranchConditional %19 %20 %27
         %20 = OpLabel
               OpStore %24 %26
               OpBranch %21
         %27 = OpLabel
               OpStore %24 %28
               OpBranch %21
         %21 = OpLabel
               OpReturn
               OpFunctionEnd
