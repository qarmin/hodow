#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 35
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %21
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v1"
               OpName %13 "v2"
               OpName %21 "_GLF_color"
               OpDecorate %21 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstant %6 -1
         %12 = OpConstantComposite %7 %10 %11
         %14 = OpConstant %6 0.400000006
         %19 = OpTypeVector %6 4
         %20 = OpTypePointer Output %19
         %21 = OpVariable %20 Output
         %22 = OpTypeInt 32 0
         %23 = OpConstant %22 0
         %24 = OpTypePointer Function %6
         %27 = OpConstant %22 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %13 = OpVariable %8 Function
               OpStore %9 %12
         %15 = OpLoad %7 %9
         %16 = OpExtInst %7 %1 Sinh %15
         %17 = OpCompositeConstruct %7 %14 %14
         %18 = OpExtInst %7 %1 Step %17 %16
               OpStore %13 %18
         %25 = OpAccessChain %24 %13 %23
         %26 = OpLoad %6 %25
         %28 = OpAccessChain %24 %13 %27
         %29 = OpLoad %6 %28
         %30 = OpAccessChain %24 %13 %27
         %31 = OpLoad %6 %30
         %32 = OpAccessChain %24 %13 %23
         %33 = OpLoad %6 %32
         %34 = OpCompositeConstruct %19 %26 %29 %31 %33
               OpStore %21 %34
               OpReturn
               OpFunctionEnd
