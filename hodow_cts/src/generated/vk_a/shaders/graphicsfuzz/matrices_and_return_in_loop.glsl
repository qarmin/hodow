#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 52
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %31 %49
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %13 "f(mf22;"
               OpName %12 "m"
               OpName %31 "gl_FragCoord"
               OpName %46 "param"
               OpName %49 "_GLF_color"
               OpDecorate %31 BuiltIn FragCoord
               OpDecorate %49 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeMatrix %7 2
          %9 = OpTypePointer Function %8
         %10 = OpTypeVector %6 3
         %11 = OpTypeFunction %10 %9
         %19 = OpConstant %6 1
         %20 = OpConstantComposite %10 %19 %19 %19
         %22 = OpTypeBool
         %26 = OpConstant %6 0
         %27 = OpConstantComposite %7 %26 %26
         %28 = OpConstantComposite %8 %27 %27
         %29 = OpTypeVector %6 4
         %30 = OpTypePointer Input %29
         %31 = OpVariable %30 Input
         %32 = OpTypeInt 32 0
         %33 = OpConstant %32 0
         %34 = OpTypePointer Input %6
         %40 = OpConstantComposite %7 %19 %26
         %41 = OpConstantComposite %7 %26 %19
         %42 = OpConstantComposite %8 %40 %41
         %48 = OpTypePointer Output %29
         %49 = OpVariable %48 Output
         %50 = OpConstantComposite %29 %19 %26 %26 %19
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %46 = OpVariable %9 Function
         %35 = OpAccessChain %34 %31 %33
         %36 = OpLoad %6 %35
         %37 = OpFOrdGreaterThanEqual %22 %36 %26
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpBranch %39
         %39 = OpLabel
         %51 = OpPhi %8 %28 %5 %42 %38
         %45 = OpMatrixTimesMatrix %8 %51 %51
               OpStore %46 %45
         %47 = OpFunctionCall %10 %13 %46
               OpStore %49 %50
               OpReturn
               OpFunctionEnd
         %13 = OpFunction %10 None %11
         %12 = OpFunctionParameter %9
         %14 = OpLabel
               OpBranch %15
         %15 = OpLabel
               OpLoopMerge %17 %18 None
               OpBranch %16
         %16 = OpLabel
               OpReturnValue %20
         %18 = OpLabel
               OpBranch %15
         %17 = OpLabel
               OpUnreachable
               OpFunctionEnd
