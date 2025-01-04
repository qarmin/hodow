#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 34
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %18
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %18 "gl_FragCoord"
               OpDecorate %9 Location 0
               OpDecorate %18 BuiltIn FragCoord
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %13 = OpTypeBool
         %14 = OpConstantTrue %13
         %17 = OpTypePointer Input %7
         %18 = OpVariable %17 Input
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Input %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpStore %9 %12
               OpSelectionMerge %16 None
               OpBranchConditional %14 %15 %16
         %15 = OpLabel
         %22 = OpAccessChain %21 %18 %20
         %23 = OpLoad %6 %22
         %24 = OpFOrdLessThan %13 %23 %11
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %26
         %25 = OpLabel
               OpBranch %27
         %27 = OpLabel
               OpLoopMerge %29 %30 None
               OpBranch %28
         %28 = OpLabel
               OpStore %9 %12
               OpBranch %30
         %30 = OpLabel
         %31 = OpAccessChain %21 %18 %20
         %32 = OpLoad %6 %31
         %33 = OpFOrdLessThan %13 %32 %11
               OpBranchConditional %33 %27 %29
         %29 = OpLabel
               OpBranch %26
         %26 = OpLabel
               OpBranch %16
         %16 = OpLabel
               OpReturn
               OpFunctionEnd
