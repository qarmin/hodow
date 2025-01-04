#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 49
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "c1"
               OpName %12 "uv"
               OpName %22 "i"
               OpName %34 "_GLF_color"
               OpDecorate %22 RelaxedPrecision
               OpDecorate %34 Location 0
               OpDecorate %39 RelaxedPrecision
               OpDecorate %40 RelaxedPrecision
               OpDecorate %45 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 2
         %11 = OpTypePointer Function %10
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 1
         %15 = OpTypePointer Function %9
         %18 = OpConstant %9 0.25
         %20 = OpTypeInt 32 1
         %21 = OpTypePointer Function %20
         %23 = OpConstant %20 0
         %30 = OpConstant %20 1
         %32 = OpTypeVector %9 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
         %35 = OpConstant %9 1
         %36 = OpConstant %9 0
         %37 = OpConstantComposite %32 %35 %36 %36 %35
         %47 = OpUndef %20
         %48 = OpUndef %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %12 = OpVariable %11 Function
         %22 = OpVariable %21 Function
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %9 %16
         %19 = OpFOrdLessThan %6 %17 %18
               OpStore %8 %19
               OpStore %22 %23
               OpBranch %24
         %24 = OpLabel
         %46 = OpPhi %6 %19 %5 %48 %27
         %45 = OpPhi %20 %23 %5 %47 %27
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
         %31 = OpSLessThan %6 %45 %30
               OpBranchConditional %31 %25 %26
         %25 = OpLabel
               OpStore %34 %37
               OpReturn
         %27 = OpLabel
         %39 = OpLoad %20 %22
         %40 = OpIAdd %20 %39 %30
               OpStore %22 %40
               OpBranch %24
         %26 = OpLabel
               OpSelectionMerge %43 None
               OpBranchConditional %46 %42 %43
         %42 = OpLabel
               OpReturn
         %43 = OpLabel
               OpReturn
               OpFunctionEnd
