#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 40
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %15 %32
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "func("
               OpName %12 "x"
               OpName %15 "gl_FragCoord"
               OpName %32 "_GLF_color"
               OpDecorate %15 BuiltIn FragCoord
               OpDecorate %32 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypeFunction %7
         %11 = OpTypePointer Function %6
         %13 = OpConstant %6 1
         %14 = OpTypePointer Input %7
         %15 = OpVariable %14 Input
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 0
         %18 = OpTypePointer Input %6
         %21 = OpConstant %6 0
         %22 = OpTypeBool
         %26 = OpConstant %6 0.5
         %31 = OpTypePointer Output %7
         %32 = OpVariable %31 Output
         %33 = OpConstantComposite %7 %21 %21 %21 %21
         %39 = OpConstantFalse %22
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpStore %32 %33
               OpBranch %34
         %34 = OpLabel
         %38 = OpFunctionCall %7 %9
               OpStore %32 %38
               OpLoopMerge %36 %34 None
               OpBranchConditional %39 %34 %36
         %36 = OpLabel
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %12 = OpVariable %11 Function
               OpStore %12 %13
         %19 = OpAccessChain %18 %15 %17
         %20 = OpLoad %6 %19
         %23 = OpFOrdLessThan %22 %20 %21
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %25
         %24 = OpLabel
               OpStore %12 %26
               OpBranch %25
         %25 = OpLabel
         %27 = OpLoad %6 %12
         %28 = OpCompositeConstruct %7 %27 %21 %21 %13
               OpReturnValue %28
               OpFunctionEnd
