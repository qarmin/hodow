#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 42
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %14
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "gl_FragCoord"
               OpName %33 "foo"
               OpDecorate %9 Location 0
               OpDecorate %14 BuiltIn FragCoord
               OpDecorate %33 RelaxedPrecision
               OpDecorate %34 RelaxedPrecision
               OpDecorate %37 RelaxedPrecision
               OpDecorate %38 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %13 = OpTypePointer Input %7
         %14 = OpVariable %13 Input
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 0
         %17 = OpTypePointer Input %6
         %20 = OpConstant %6 -1
         %21 = OpTypeBool
         %23 = OpTypePointer Function %6
         %27 = OpTypePointer Output %6
         %31 = OpConstant %15 178493
         %32 = OpTypePointer Function %15
         %35 = OpTypeInt 32 1
         %36 = OpConstant %35 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %24 = OpVariable %23 Function
         %33 = OpVariable %32 Function
               OpStore %9 %12
         %18 = OpAccessChain %17 %14 %16
         %19 = OpLoad %6 %18
         %22 = OpFOrdGreaterThan %21 %19 %20
               OpSelectionMerge %26 None
               OpBranchConditional %22 %25 %30
         %25 = OpLabel
         %28 = OpAccessChain %27 %9 %16
         %29 = OpLoad %6 %28
               OpStore %24 %29
               OpBranch %26
         %30 = OpLabel
         %34 = OpLoad %15 %33
         %37 = OpISub %15 %34 %36
               OpStore %33 %37
         %38 = OpIAdd %15 %31 %37
         %39 = OpConvertUToF %6 %38
               OpStore %24 %39
               OpBranch %26
         %26 = OpLabel
         %40 = OpLoad %6 %24
         %41 = OpAccessChain %27 %9 %16
               OpStore %41 %40
               OpReturn
               OpFunctionEnd
