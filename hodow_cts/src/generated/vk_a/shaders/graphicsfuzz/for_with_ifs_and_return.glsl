#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 48
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %27
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %15 "i"
               OpName %27 "gl_FragCoord"
               OpDecorate %9 Location 0
               OpDecorate %15 RelaxedPrecision
               OpDecorate %22 RelaxedPrecision
               OpDecorate %27 BuiltIn FragCoord
               OpDecorate %46 RelaxedPrecision
               OpDecorate %47 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %13 = OpTypeInt 32 1
         %14 = OpTypePointer Function %13
         %16 = OpConstant %13 1
         %23 = OpConstant %13 2
         %24 = OpTypeBool
         %26 = OpTypePointer Input %7
         %27 = OpVariable %26 Input
         %28 = OpTypeInt 32 0
         %29 = OpConstant %28 1
         %30 = OpTypePointer Input %6
         %36 = OpConstant %28 0
         %42 = OpConstant %6 226.695999
         %43 = OpConstantComposite %7 %42 %10 %10 %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %15 = OpVariable %14 Function
               OpStore %9 %12
               OpStore %15 %16
               OpBranch %17
         %17 = OpLabel
               OpLoopMerge %19 %20 None
               OpBranch %21
         %21 = OpLabel
         %22 = OpLoad %13 %15
         %25 = OpSLessThan %24 %22 %23
               OpBranchConditional %25 %18 %19
         %18 = OpLabel
         %31 = OpAccessChain %30 %27 %29
         %32 = OpLoad %6 %31
         %33 = OpFOrdLessThan %24 %32 %11
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %35
         %34 = OpLabel
         %37 = OpAccessChain %30 %27 %36
         %38 = OpLoad %6 %37
         %39 = OpFOrdLessThan %24 %38 %11
               OpSelectionMerge %41 None
               OpBranchConditional %39 %40 %41
         %40 = OpLabel
               OpStore %9 %43
               OpBranch %41
         %41 = OpLabel
               OpBranch %20
         %35 = OpLabel
               OpReturn
         %20 = OpLabel
         %46 = OpLoad %13 %15
         %47 = OpIAdd %13 %46 %16
               OpStore %15 %47
               OpBranch %17
         %19 = OpLabel
               OpReturn
               OpFunctionEnd
