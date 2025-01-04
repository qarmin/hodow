#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 34
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %29
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %29 "_GLF_color"
               OpDecorate %29 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstant %6 100
         %12 = OpConstantComposite %7 %10 %11
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 0
         %17 = OpTypePointer Function %6
         %20 = OpConstant %15 1
         %23 = OpTypeBool
         %27 = OpTypeVector %6 4
         %28 = OpTypePointer Output %27
         %29 = OpVariable %28 Output
         %30 = OpConstant %6 0
         %31 = OpConstantComposite %27 %10 %30 %30 %10
         %33 = OpConstantComposite %27 %30 %30 %30 %30
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %13 = OpExtInst %7 %1 Cosh %12
         %14 = OpExtInst %7 %1 Log2 %13
               OpStore %9 %14
         %18 = OpAccessChain %17 %9 %16
         %19 = OpLoad %6 %18
         %21 = OpAccessChain %17 %9 %20
         %22 = OpLoad %6 %21
         %24 = OpFOrdLessThan %23 %19 %22
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %32
         %25 = OpLabel
               OpStore %29 %31
               OpBranch %26
         %32 = OpLabel
               OpStore %29 %33
               OpBranch %26
         %26 = OpLabel
               OpReturn
               OpFunctionEnd
