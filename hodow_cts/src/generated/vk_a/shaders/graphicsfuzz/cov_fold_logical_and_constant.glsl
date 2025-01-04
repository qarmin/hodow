#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 42
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %20 %37
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %20 "gl_FragCoord"
               OpName %37 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %14 RelaxedPrecision
               OpDecorate %16 RelaxedPrecision
               OpDecorate %20 BuiltIn FragCoord
               OpDecorate %31 RelaxedPrecision
               OpDecorate %37 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 2
         %15 = OpConstant %6 1
         %17 = OpTypeFloat 32
         %18 = OpTypeVector %17 4
         %19 = OpTypePointer Input %18
         %20 = OpVariable %19 Input
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 0
         %23 = OpTypePointer Input %17
         %26 = OpConstant %17 0
         %27 = OpTypeBool
         %29 = OpConstantFalse %27
         %32 = OpConstant %6 3
         %36 = OpTypePointer Output %18
         %37 = OpVariable %36 Output
         %38 = OpConstant %17 1
         %39 = OpConstantComposite %18 %38 %26 %26 %38
         %41 = OpConstantComposite %18 %26 %26 %26 %26
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %11
         %11 = OpLabel
         %14 = OpLoad %6 %8
         %16 = OpIAdd %6 %14 %15
               OpStore %8 %16
               OpBranch %13
         %13 = OpLabel
         %24 = OpAccessChain %23 %20 %22
         %25 = OpLoad %17 %24
         %28 = OpFOrdGreaterThanEqual %27 %25 %26
         %30 = OpLogicalAnd %27 %28 %29
               OpBranchConditional %30 %10 %12
         %12 = OpLabel
         %31 = OpLoad %6 %8
         %33 = OpIEqual %27 %31 %32
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %40
         %34 = OpLabel
               OpStore %37 %39
               OpBranch %35
         %40 = OpLabel
               OpStore %37 %41
               OpBranch %35
         %35 = OpLabel
               OpReturn
               OpFunctionEnd
