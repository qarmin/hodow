#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 28
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %4 "a"
               OpName %5 "b"
               OpName %3 "_GLF_color"
               OpDecorate %3 Location 0
          %6 = OpTypeVoid
          %7 = OpTypeFunction %6
          %8 = OpTypeFloat 32
          %9 = OpTypeVector %8 2
         %10 = OpTypePointer Function %9
         %11 = OpConstant %8 1
         %12 = OpConstantComposite %9 %11 %11
         %13 = OpTypeVector %8 4
         %14 = OpTypePointer Function %13
         %15 = OpConstantComposite %13 %11 %11 %11 %11
         %16 = OpTypePointer Output %13
          %3 = OpVariable %16 Output
         %17 = OpConstant %8 0
         %18 = OpConstantComposite %13 %11 %17 %17 %11
          %2 = OpFunction %6 None %7
         %19 = OpLabel
          %4 = OpVariable %10 Function
          %5 = OpVariable %14 Function
               OpStore %4 %12
               OpStore %5 %15
         %20 = OpLoad %9 %4
         %21 = OpCompositeExtract %8 %20 0
         %22 = OpCompositeExtract %8 %20 1
         %23 = OpCompositeExtract %8 %12 0
         %24 = OpCompositeExtract %8 %12 1
         %25 = OpCompositeConstruct %13 %21 %22 %23 %24
         %26 = OpLoad %13 %5
         %27 = OpExtInst %13 %1 Pow %25 %26
               OpStore %3 %18
               OpReturn
               OpFunctionEnd
