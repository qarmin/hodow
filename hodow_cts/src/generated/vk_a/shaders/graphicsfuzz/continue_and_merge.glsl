#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 22
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %3 "_GLF_color"
               OpDecorate %3 Location 0
          %4 = OpTypeVoid
          %5 = OpTypeFunction %4
          %6 = OpTypeFloat 32
          %7 = OpConstant %6 1
          %8 = OpConstant %6 0
          %9 = OpTypeVector %6 4
         %10 = OpConstantComposite %9 %7 %8 %8 %7
         %11 = OpTypePointer Output %9
          %3 = OpVariable %11 Output
         %12 = OpTypeBool
         %13 = OpConstantTrue %12
         %14 = OpConstantFalse %12
          %2 = OpFunction %4 None %5
         %15 = OpLabel
               OpBranch %16
         %16 = OpLabel
               OpLoopMerge %17 %18 None
               OpBranchConditional %14 %19 %17
         %19 = OpLabel
               OpLoopMerge %20 %21 None
               OpBranchConditional %14 %20 %20
         %21 = OpLabel
               OpBranch %19
         %20 = OpLabel
               OpBranch %18
         %18 = OpLabel
               OpBranch %16
         %17 = OpLabel
               OpStore %3 %10
               OpReturn
               OpFunctionEnd
