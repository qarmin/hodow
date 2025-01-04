#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 22
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %18
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %18 "_GLF_color"
               OpDecorate %18 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpConstant %6 0
         %10 = OpTypeBool
         %11 = OpConstantFalse %10
         %15 = OpTypeFloat 32
         %16 = OpTypeVector %15 4
         %17 = OpTypePointer Output %16
         %18 = OpVariable %17 Output
         %19 = OpConstant %15 1
         %20 = OpConstant %15 0
         %21 = OpConstantComposite %16 %19 %20 %20 %19
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpSelectionMerge %9 None
               OpSwitch %7 %9 0 %8
          %8 = OpLabel
               OpSelectionMerge %13 None
               OpBranchConditional %11 %12 %13
         %12 = OpLabel
               OpBranch %13
         %13 = OpLabel
               OpBranch %9
          %9 = OpLabel
               OpStore %18 %21
               OpReturn
               OpFunctionEnd
