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
               OpEntryPoint Fragment %4 "main" %9 %23
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "gl_FragCoord"
               OpName %23 "_GLF_color"
               OpDecorate %9 BuiltIn FragCoord
               OpDecorate %23 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Input %7
          %9 = OpVariable %8 Input
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 0
         %12 = OpTypePointer Input %6
         %15 = OpConstant %6 0
         %16 = OpTypeBool
         %18 = OpConstantTrue %16
         %22 = OpTypePointer Output %7
         %23 = OpVariable %22 Output
         %24 = OpConstant %6 1
         %25 = OpConstantComposite %7 %24 %15 %15 %24
         %27 = OpConstantComposite %7 %15 %15 %15 %15
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %13 = OpAccessChain %12 %9 %11
         %14 = OpLoad %6 %13
         %17 = OpFOrdLessThan %16 %14 %15
         %19 = OpLogicalOr %16 %17 %18
               OpSelectionMerge %21 None
               OpBranchConditional %19 %20 %26
         %20 = OpLabel
               OpStore %23 %25
               OpBranch %21
         %26 = OpLabel
               OpStore %23 %27
               OpBranch %21
         %21 = OpLabel
               OpReturn
               OpFunctionEnd
