#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 57
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %14
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "gl_FragCoord"
               OpName %29 "ll"
               OpDecorate %9 Location 0
               OpDecorate %14 BuiltIn FragCoord
               OpDecorate %29 RelaxedPrecision
               OpDecorate %41 RelaxedPrecision
               OpDecorate %47 RelaxedPrecision
               OpDecorate %49 RelaxedPrecision
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
         %20 = OpTypeInt 32 1
         %22 = OpConstant %20 2000
         %23 = OpTypeBool
         %28 = OpTypePointer Function %20
         %30 = OpConstant %20 0
         %42 = OpConstant %20 5
         %48 = OpConstant %20 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %29 = OpVariable %28 Function
               OpStore %9 %12
         %18 = OpAccessChain %17 %14 %16
         %19 = OpLoad %6 %18
         %21 = OpConvertFToS %20 %19
         %24 = OpSLessThan %23 %21 %22
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %27
         %25 = OpLabel
               OpBranch %26
         %27 = OpLabel
               OpStore %29 %30
               OpBranch %31
         %31 = OpLabel
               OpLoopMerge %33 %34 None
               OpBranch %32
         %32 = OpLabel
         %35 = OpAccessChain %17 %14 %16
         %36 = OpLoad %6 %35
         %37 = OpFOrdLessThan %23 %36 %11
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpTerminateInvocation
         %39 = OpLabel
         %41 = OpLoad %20 %29
         %43 = OpSGreaterThanEqual %23 %41 %42
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %45
         %44 = OpLabel
               OpBranch %33
         %45 = OpLabel
               OpBranch %34
         %34 = OpLabel
         %47 = OpLoad %20 %29
         %49 = OpIAdd %20 %47 %48
               OpStore %29 %49
               OpBranch %31
         %33 = OpLabel
         %50 = OpAccessChain %17 %14 %16
         %51 = OpLoad %6 %50
         %52 = OpConvertFToS %20 %51
         %53 = OpSGreaterThanEqual %23 %52 %22
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %55
         %54 = OpLabel
               OpTerminateInvocation
         %55 = OpLabel
               OpBranch %26
         %26 = OpLabel
               OpReturn
               OpFunctionEnd
