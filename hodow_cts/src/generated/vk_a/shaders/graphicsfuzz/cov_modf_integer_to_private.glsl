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
               OpName %9 "a"
               OpName %18 "_GLF_color"
               OpDecorate %18 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpConstant %6 5
          %8 = OpTypePointer Private %6
          %9 = OpVariable %8 Private
         %12 = OpTypeBool
         %16 = OpTypeVector %6 4
         %17 = OpTypePointer Output %16
         %18 = OpVariable %17 Output
         %19 = OpConstant %6 1
         %20 = OpConstant %6 0
         %21 = OpConstantComposite %16 %19 %20 %20 %19
         %23 = OpConstantComposite %16 %20 %20 %20 %20
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpExtInst %6 %1 Modf %7 %9
         %11 = OpLoad %6 %9
         %13 = OpFOrdEqual %12 %11 %7
               OpSelectionMerge %15 None
               OpBranchConditional %13 %14 %22
         %14 = OpLabel
               OpStore %18 %21
               OpBranch %15
         %22 = OpLabel
               OpStore %18 %23
               OpBranch %15
         %15 = OpLabel
               OpReturn
               OpFunctionEnd
