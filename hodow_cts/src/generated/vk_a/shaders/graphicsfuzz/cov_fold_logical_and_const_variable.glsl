#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 24
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %18
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %18 "_GLF_color"
               OpDecorate %18 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
          %7 = OpTypePointer Function %6
          %9 = OpConstantFalse %6
         %10 = OpConstantTrue %6
         %15 = OpTypeFloat 32
         %16 = OpTypeVector %15 4
         %17 = OpTypePointer Output %16
         %18 = OpVariable %17 Output
         %19 = OpConstant %15 0
         %20 = OpConstantComposite %16 %19 %19 %19 %19
         %22 = OpConstant %15 1
         %23 = OpConstantComposite %16 %22 %19 %19 %22
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %11 = OpLoad %6 %8
         %12 = OpLogicalAnd %6 %10 %11
               OpSelectionMerge %14 None
               OpBranchConditional %12 %13 %21
         %13 = OpLabel
               OpStore %18 %20
               OpBranch %14
         %21 = OpLabel
               OpStore %18 %23
               OpBranch %14
         %14 = OpLabel
               OpReturn
               OpFunctionEnd
