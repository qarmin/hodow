#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 45
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %39
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %10 "j"
               OpName %39 "_GLF_color"
               OpDecorate %39 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %11 = OpConstant %6 1
         %19 = OpConstant %6 5
         %20 = OpConstant %6 9
         %22 = OpTypeBool
         %31 = OpConstant %6 10
         %36 = OpTypeFloat 32
         %37 = OpTypeVector %36 4
         %38 = OpTypePointer Output %37
         %39 = OpVariable %38 Output
         %40 = OpConstant %36 1
         %41 = OpConstant %36 0
         %42 = OpConstantComposite %37 %40 %41 %41 %40
         %44 = OpConstantComposite %37 %41 %41 %41 %41
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %11
               OpBranch %12
         %12 = OpLabel
               OpLoopMerge %14 %15 None
               OpBranch %16
         %16 = OpLabel
         %17 = OpLoad %6 %8
         %18 = OpLoad %6 %10
         %21 = OpExtInst %6 %1 SClamp %18 %19 %20
         %23 = OpSLessThan %22 %17 %21
               OpBranchConditional %23 %13 %14
         %13 = OpLabel
         %24 = OpLoad %6 %8
         %25 = OpIAdd %6 %24 %11
               OpStore %8 %25
         %26 = OpLoad %6 %10
         %27 = OpIAdd %6 %26 %11
               OpStore %10 %27
               OpBranch %15
         %15 = OpLabel
               OpBranch %12
         %14 = OpLabel
         %28 = OpLoad %6 %8
         %29 = OpIEqual %22 %28 %20
         %30 = OpLoad %6 %10
         %32 = OpIEqual %22 %30 %31
         %33 = OpLogicalAnd %22 %29 %32
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %43
         %34 = OpLabel
               OpStore %39 %42
               OpBranch %35
         %43 = OpLabel
               OpStore %39 %44
               OpBranch %35
         %35 = OpLabel
               OpReturn
               OpFunctionEnd
