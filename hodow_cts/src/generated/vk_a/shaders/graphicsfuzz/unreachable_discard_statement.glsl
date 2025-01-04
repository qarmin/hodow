#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %35
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "mand("
               OpName %13 "k"
               OpName %35 "_GLF_color"
               OpName %38 "i"
               OpDecorate %13 RelaxedPrecision
               OpDecorate %20 RelaxedPrecision
               OpDecorate %35 Location 0
               OpDecorate %38 RelaxedPrecision
               OpDecorate %44 RelaxedPrecision
               OpDecorate %48 RelaxedPrecision
               OpDecorate %49 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeInt 32 1
         %12 = OpTypePointer Function %11
         %14 = OpConstant %11 0
         %21 = OpConstant %11 1000
         %22 = OpTypeBool
         %24 = OpConstant %6 1
         %25 = OpConstantComposite %7 %24 %24 %24
         %28 = OpConstant %11 1
         %33 = OpTypeVector %6 4
         %34 = OpTypePointer Output %33
         %35 = OpVariable %34 Output
         %36 = OpConstant %6 0
         %37 = OpConstantComposite %33 %24 %36 %36 %24
         %45 = OpConstant %11 4
         %51 = OpTypePointer Function %7
         %57 = OpConstantFalse %22
         %58 = OpTypePointer Function %22
         %60 = OpConstantTrue %22
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %38 = OpVariable %12 Function
               OpStore %35 %37
               OpStore %38 %14
               OpBranch %39
         %39 = OpLabel
         %44 = OpLoad %11 %38
         %46 = OpSLessThan %22 %44 %45
               OpLoopMerge %41 %40 None
               OpBranchConditional %46 %40 %41
         %40 = OpLabel
         %47 = OpFunctionCall %7 %9
         %48 = OpLoad %11 %38
         %49 = OpIAdd %11 %48 %28
               OpStore %38 %49
               OpBranch %39
         %41 = OpLabel
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %59 = OpVariable %58 Function %57
         %52 = OpVariable %51 Function
         %13 = OpVariable %12 Function
               OpBranch %54
         %54 = OpLabel
               OpStore %13 %14
               OpLoopMerge %50 %56 None
               OpBranch %15
         %15 = OpLabel
         %20 = OpLoad %11 %13
         %23 = OpSLessThan %22 %20 %21
               OpLoopMerge %17 %18 None
               OpBranchConditional %23 %16 %17
         %16 = OpLabel
               OpStore %59 %60
               OpStore %52 %25
               OpBranch %17
         %18 = OpLabel
               OpBranch %15
         %17 = OpLabel
         %62 = OpLoad %22 %59
               OpSelectionMerge %61 None
               OpBranchConditional %62 %50 %61
         %61 = OpLabel
               OpTerminateInvocation
         %56 = OpLabel
               OpBranch %54
         %50 = OpLabel
         %53 = OpLoad %7 %52
               OpReturnValue %53
               OpFunctionEnd
