#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 39
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "i"
               OpName %33 "_GLF_color"
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %11 = OpConstant %6 0
         %18 = OpConstant %6 2
         %19 = OpTypeBool
         %26 = OpConstant %6 3
         %30 = OpTypeFloat 32
         %31 = OpTypeVector %30 4
         %32 = OpTypePointer Output %31
         %33 = OpVariable %32 Output
         %34 = OpConstant %30 1
         %35 = OpConstant %30 0
         %36 = OpConstantComposite %31 %34 %35 %35 %34
         %38 = OpConstantComposite %31 %35 %35 %35 %35
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
         %17 = OpLoad %6 %10
         %20 = OpSLessThan %19 %17 %18
               OpBranchConditional %20 %13 %14
         %13 = OpLabel
         %21 = OpLoad %6 %10
         %22 = OpBitFieldInsert %6 %9 %9 %9 %21
               OpStore %8 %22
               OpBranch %15
         %15 = OpLabel
         %23 = OpLoad %6 %10
         %24 = OpIAdd %6 %23 %9
               OpStore %10 %24
               OpBranch %12
         %14 = OpLabel
         %25 = OpLoad %6 %8
         %27 = OpIEqual %19 %25 %26
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %37
         %28 = OpLabel
               OpStore %33 %36
               OpBranch %29
         %37 = OpLabel
               OpStore %33 %38
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
