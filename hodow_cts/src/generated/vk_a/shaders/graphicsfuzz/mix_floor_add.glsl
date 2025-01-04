#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 33
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %30
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "GLF_live6mand("
               OpName %30 "_GLF_color"
               OpDecorate %30 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeInt 32 0
         %12 = OpTypeVector %11 3
         %13 = OpConstant %11 38730
         %14 = OpConstant %11 63193
         %15 = OpConstant %11 63173
         %16 = OpConstantComposite %12 %13 %14 %15
         %18 = OpConstant %6 463
         %19 = OpConstant %6 4
         %20 = OpConstant %6 0
         %21 = OpConstantComposite %7 %18 %19 %20
         %22 = OpConstant %6 2
         %23 = OpConstantComposite %7 %22 %22 %22
         %28 = OpTypeVector %6 4
         %29 = OpTypePointer Output %28
         %30 = OpVariable %29 Output
         %31 = OpConstant %6 1
         %32 = OpConstantComposite %28 %31 %20 %20 %31
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %27 = OpFunctionCall %7 %9
               OpStore %30 %32
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %17 = OpBitcast %7 %16
         %24 = OpExtInst %7 %1 FMix %17 %21 %23
               OpReturnValue %24
               OpFunctionEnd
