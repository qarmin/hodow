#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 36
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %31
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "a"
               OpName %20 "b"
               OpName %31 "_GLF_color"
               OpDecorate %31 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstantComposite %7 %10 %10
         %12 = OpConstant %6 0.5
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Function %6
         %25 = OpTypeBool
         %29 = OpTypeVector %6 4
         %30 = OpTypePointer Output %29
         %31 = OpVariable %30 Output
         %32 = OpConstant %6 0
         %33 = OpConstantComposite %29 %10 %32 %32 %10
         %35 = OpConstantComposite %29 %32 %32 %32 %32
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %20 = OpVariable %8 Function
               OpStore %9 %11
         %16 = OpAccessChain %15 %9 %14
         %17 = OpLoad %6 %16
         %18 = OpFAdd %6 %17 %12
         %19 = OpAccessChain %15 %9 %14
               OpStore %19 %18
         %21 = OpLoad %7 %9
         %22 = OpExtInst %7 %1 Fract %21
               OpStore %20 %22
         %23 = OpAccessChain %15 %20 %14
         %24 = OpLoad %6 %23
         %26 = OpFOrdEqual %25 %24 %12
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %34
         %27 = OpLabel
               OpStore %31 %33
               OpBranch %28
         %34 = OpLabel
               OpStore %31 %35
               OpBranch %28
         %28 = OpLabel
               OpReturn
               OpFunctionEnd
