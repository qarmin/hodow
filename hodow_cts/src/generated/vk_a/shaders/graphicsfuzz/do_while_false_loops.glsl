#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 65
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %59
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "f("
               OpName %13 "iteration"
               OpName %15 "k"
               OpName %59 "_GLF_color"
               OpDecorate %13 RelaxedPrecision
               OpDecorate %15 RelaxedPrecision
               OpDecorate %21 RelaxedPrecision
               OpDecorate %25 RelaxedPrecision
               OpDecorate %27 RelaxedPrecision
               OpDecorate %28 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpDecorate %30 RelaxedPrecision
               OpDecorate %35 RelaxedPrecision
               OpDecorate %36 RelaxedPrecision
               OpDecorate %38 RelaxedPrecision
               OpDecorate %39 RelaxedPrecision
               OpDecorate %59 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeInt 32 1
         %12 = OpTypePointer Function %11
         %14 = OpConstant %11 0
         %22 = OpConstant %11 100
         %23 = OpTypeBool
         %26 = OpConstant %11 1
         %34 = OpConstant %6 1
         %52 = OpConstant %6 0
         %53 = OpConstantComposite %7 %34 %52 %52
         %55 = OpConstantFalse %23
         %57 = OpTypeVector %6 4
         %58 = OpTypePointer Output %57
         %59 = OpVariable %58 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %60 = OpFunctionCall %7 %9
         %61 = OpCompositeExtract %6 %60 0
         %62 = OpCompositeExtract %6 %60 1
         %63 = OpCompositeExtract %6 %60 2
         %64 = OpCompositeConstruct %57 %61 %62 %63 %34
               OpStore %59 %64
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %13 = OpVariable %12 Function
         %15 = OpVariable %12 Function
               OpStore %13 %14
               OpStore %15 %14
               OpBranch %16
         %16 = OpLabel
               OpLoopMerge %18 %19 None
               OpBranch %20
         %20 = OpLabel
         %21 = OpLoad %11 %15
         %24 = OpSLessThan %23 %21 %22
               OpBranchConditional %24 %17 %18
         %17 = OpLabel
         %25 = OpLoad %11 %13
         %27 = OpIAdd %11 %25 %26
               OpStore %13 %27
               OpBranch %19
         %19 = OpLabel
         %28 = OpLoad %11 %15
         %29 = OpIAdd %11 %28 %26
               OpStore %15 %29
               OpBranch %16
         %18 = OpLabel
         %30 = OpLoad %11 %13
         %31 = OpSLessThan %23 %30 %22
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %43
         %32 = OpLabel
         %35 = OpLoad %11 %13
         %36 = OpISub %11 %35 %26
         %37 = OpConvertSToF %6 %36
         %38 = OpLoad %11 %13
         %39 = OpISub %11 %38 %26
         %40 = OpConvertSToF %6 %39
         %41 = OpCompositeConstruct %7 %34 %37 %40
               OpReturnValue %41
         %43 = OpLabel
               OpBranch %44
         %44 = OpLabel
               OpLoopMerge %46 %47 None
               OpBranch %45
         %45 = OpLabel
               OpBranch %48
         %48 = OpLabel
               OpLoopMerge %50 %51 None
               OpBranch %49
         %49 = OpLabel
               OpReturnValue %53
         %51 = OpLabel
               OpBranch %48
         %50 = OpLabel
               OpUnreachable
         %47 = OpLabel
               OpBranch %44
         %46 = OpLabel
               OpUnreachable
         %33 = OpLabel
               OpUnreachable
               OpFunctionEnd
