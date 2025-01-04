#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 60
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %40 %51
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "computePoint("
               OpName %12 "buf0"
               OpMemberName %12 0 "injectionSwitch"
               OpName %14 ""
               OpName %40 "gl_FragCoord"
               OpName %51 "_GLF_color"
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %40 BuiltIn FragCoord
               OpDecorate %51 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeVector %6 2
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 0
         %19 = OpTypePointer Uniform %6
         %22 = OpConstant %17 1
         %25 = OpTypeBool
         %30 = OpConstant %6 1
         %31 = OpConstantComposite %7 %30 %30 %30
         %35 = OpConstantFalse %25
         %38 = OpTypeVector %6 4
         %39 = OpTypePointer Input %38
         %40 = OpVariable %39 Input
         %41 = OpTypePointer Input %6
         %44 = OpConstant %6 0
         %50 = OpTypePointer Output %38
         %51 = OpVariable %50 Output
         %52 = OpConstantComposite %38 %30 %44 %44 %30
         %57 = OpTypePointer Function %25
         %59 = OpConstantTrue %25
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %58 = OpVariable %57 Function %35
               OpBranch %54
         %54 = OpLabel
         %34 = OpFunctionCall %7 %9
               OpLoopMerge %53 %56 None
               OpBranch %37
         %37 = OpLabel
         %42 = OpAccessChain %41 %40 %18
         %43 = OpLoad %6 %42
         %45 = OpFOrdLessThan %25 %43 %44
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %47
         %46 = OpLabel
               OpStore %58 %59
               OpBranch %53
         %47 = OpLabel
         %49 = OpFunctionCall %7 %9
               OpStore %51 %52
               OpStore %58 %59
               OpBranch %53
         %56 = OpLabel
               OpBranch %54
         %53 = OpLabel
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %20 = OpAccessChain %19 %14 %16 %18
         %21 = OpLoad %6 %20
         %23 = OpAccessChain %19 %14 %16 %22
         %24 = OpLoad %6 %23
         %26 = OpFOrdGreaterThan %25 %21 %24
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %28
         %27 = OpLabel
               OpTerminateInvocation
         %28 = OpLabel
         %33 = OpUndef %7
               OpReturnValue %33
               OpFunctionEnd
