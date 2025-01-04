#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 66
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %48 %57
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "nb_mod(f1;"
               OpName %9 "limit"
               OpName %21 "_injected_loop_counter"
               OpName %31 "_injected_loop_counter"
               OpName %48 "gl_FragCoord"
               OpName %49 "param"
               OpName %57 "_GLF_color"
               OpDecorate %21 RelaxedPrecision
               OpDecorate %31 RelaxedPrecision
               OpDecorate %48 BuiltIn FragCoord
               OpDecorate %57 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %12 = OpConstant %6 1
         %14 = OpTypeBool
         %19 = OpTypeInt 32 1
         %20 = OpTypePointer Function %19
         %22 = OpConstant %19 0
         %29 = OpConstant %19 2
         %38 = OpConstant %19 1
         %46 = OpTypeVector %6 4
         %47 = OpTypePointer Input %46
         %48 = OpVariable %47 Input
         %50 = OpTypeInt 32 0
         %51 = OpConstant %50 0
         %52 = OpTypePointer Input %6
         %56 = OpTypePointer Output %46
         %57 = OpVariable %56 Output
         %58 = OpConstant %6 0
         %59 = OpConstantComposite %46 %12 %58 %58 %12
         %63 = OpUndef %19
         %64 = OpConstantTrue %14
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %49 = OpVariable %7 Function
         %53 = OpAccessChain %52 %48 %51
         %54 = OpLoad %6 %53
               OpStore %49 %54
         %55 = OpFunctionCall %6 %10 %49
               OpStore %57 %59
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %21 = OpVariable %20 Function
         %31 = OpVariable %20 Function
         %13 = OpLoad %6 %9
         %15 = OpFOrdGreaterThanEqual %14 %12 %13
               OpSelectionMerge %17 None
               OpBranchConditional %15 %16 %17
         %16 = OpLabel
               OpReturnValue %12
         %17 = OpLabel
               OpStore %21 %22
               OpBranch %23
         %23 = OpLabel
         %30 = OpSLessThan %14 %22 %29
               OpLoopMerge %25 %34 None
               OpBranch %24
         %24 = OpLabel
               OpStore %31 %22
               OpBranch %32
         %32 = OpLabel
         %39 = OpSLessThan %14 %22 %38
               OpLoopMerge %65 %35 None
               OpBranch %33
         %65 = OpLabel
               OpBranch %34
         %33 = OpLabel
               OpReturnValue %12
         %35 = OpLabel
               OpBranch %32
         %34 = OpLabel
               OpBranch %23
         %25 = OpLabel
               OpUnreachable
               OpFunctionEnd
