#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 59
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %56
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f("
               OpName %12 "i"
               OpName %36 "c"
               OpName %39 "i"
               OpName %56 "_GLF_color"
               OpDecorate %12 RelaxedPrecision
               OpDecorate %19 RelaxedPrecision
               OpDecorate %23 RelaxedPrecision
               OpDecorate %30 RelaxedPrecision
               OpDecorate %31 RelaxedPrecision
               OpDecorate %39 RelaxedPrecision
               OpDecorate %46 RelaxedPrecision
               OpDecorate %53 RelaxedPrecision
               OpDecorate %54 RelaxedPrecision
               OpDecorate %56 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypeInt 32 1
         %11 = OpTypePointer Function %10
         %13 = OpConstant %10 1
         %20 = OpConstant %10 10
         %21 = OpTypeBool
         %25 = OpConstant %6 1
         %34 = OpTypeVector %6 4
         %35 = OpTypePointer Function %34
         %37 = OpConstant %6 0
         %38 = OpConstantComposite %34 %25 %37 %37 %25
         %40 = OpConstant %10 0
         %49 = OpTypeInt 32 0
         %50 = OpConstant %49 0
         %51 = OpTypePointer Function %6
         %55 = OpTypePointer Output %34
         %56 = OpVariable %55 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %36 = OpVariable %35 Function
         %39 = OpVariable %11 Function
               OpStore %36 %38
               OpStore %39 %40
               OpBranch %41
         %41 = OpLabel
         %46 = OpLoad %10 %39
         %47 = OpSLessThan %21 %46 %13
               OpLoopMerge %43 %42 None
               OpBranchConditional %47 %42 %43
         %42 = OpLabel
         %48 = OpFunctionCall %6 %8
         %52 = OpAccessChain %51 %36 %50
               OpStore %52 %48
         %53 = OpLoad %10 %39
         %54 = OpIAdd %10 %53 %13
               OpStore %39 %54
               OpBranch %41
         %43 = OpLabel
         %57 = OpLoad %34 %36
               OpStore %56 %57
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %12 = OpVariable %11 Function
               OpStore %12 %13
               OpBranch %14
         %14 = OpLabel
         %19 = OpLoad %10 %12
         %22 = OpSLessThan %21 %19 %20
               OpLoopMerge %16 %28 None
               OpBranchConditional %22 %15 %16
         %15 = OpLabel
         %23 = OpLoad %10 %12
         %24 = OpConvertSToF %6 %23
         %26 = OpFOrdGreaterThanEqual %21 %24 %25
               OpSelectionMerge %58 None
               OpBranchConditional %26 %27 %28
         %27 = OpLabel
               OpReturnValue %25
         %58 = OpLabel
               OpBranch %28
         %28 = OpLabel
         %30 = OpLoad %10 %12
         %31 = OpIAdd %10 %30 %13
               OpStore %12 %31
               OpBranch %14
         %16 = OpLabel
               OpReturnValue %25
               OpFunctionEnd
