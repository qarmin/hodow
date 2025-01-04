#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 61
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %38 %57
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "data"
               OpName %25 "i"
               OpName %38 "gl_FragCoord"
               OpName %57 "_GLF_color"
               OpDecorate %25 RelaxedPrecision
               OpDecorate %32 RelaxedPrecision
               OpDecorate %38 BuiltIn FragCoord
               OpDecorate %48 RelaxedPrecision
               OpDecorate %53 RelaxedPrecision
               OpDecorate %55 RelaxedPrecision
               OpDecorate %57 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 10
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpConstant %6 0.100000001
         %13 = OpConstant %6 0.200000003
         %14 = OpConstant %6 0.300000012
         %15 = OpConstant %6 0.400000006
         %16 = OpConstant %6 0.5
         %17 = OpConstant %6 0.600000024
         %18 = OpConstant %6 0.699999988
         %19 = OpConstant %6 0.800000012
         %20 = OpConstant %6 0.899999976
         %21 = OpConstant %6 1
         %22 = OpConstantComposite %9 %12 %13 %14 %15 %16 %17 %18 %19 %20 %21
         %23 = OpTypeInt 32 1
         %24 = OpTypePointer Function %23
         %26 = OpConstant %23 0
         %33 = OpConstant %23 10
         %34 = OpTypeBool
         %36 = OpTypeVector %6 4
         %37 = OpTypePointer Input %36
         %38 = OpVariable %37 Input
         %39 = OpConstant %7 0
         %40 = OpTypePointer Input %6
         %43 = OpConstant %6 0
         %49 = OpTypePointer Function %6
         %54 = OpConstant %23 1
         %56 = OpTypePointer Output %36
         %57 = OpVariable %56 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %25 = OpVariable %24 Function
               OpStore %11 %22
               OpStore %25 %26
               OpBranch %27
         %27 = OpLabel
               OpLoopMerge %29 %30 None
               OpBranch %31
         %31 = OpLabel
         %32 = OpLoad %23 %25
         %35 = OpSLessThan %34 %32 %33
               OpBranchConditional %35 %28 %29
         %28 = OpLabel
         %41 = OpAccessChain %40 %38 %39
         %42 = OpLoad %6 %41
         %44 = OpFOrdLessThan %34 %42 %43
               OpSelectionMerge %46 None
               OpBranchConditional %44 %45 %46
         %45 = OpLabel
               OpTerminateInvocation
         %46 = OpLabel
         %48 = OpLoad %23 %25
         %50 = OpAccessChain %49 %11 %48
         %51 = OpLoad %6 %50
         %52 = OpAccessChain %49 %11 %26
               OpStore %52 %51
               OpBranch %30
         %30 = OpLabel
         %53 = OpLoad %23 %25
         %55 = OpIAdd %23 %53 %54
               OpStore %25 %55
               OpBranch %27
         %29 = OpLabel
         %58 = OpAccessChain %49 %11 %26
         %59 = OpLoad %6 %58
         %60 = OpCompositeConstruct %36 %59 %43 %43 %21
               OpStore %57 %60
               OpReturn
               OpFunctionEnd
