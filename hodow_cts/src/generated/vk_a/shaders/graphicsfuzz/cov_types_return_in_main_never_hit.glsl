#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 35
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %17
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "func("
               OpName %17 "_GLF_color"
               OpName %20 "buf0"
               OpMemberName %20 0 "one"
               OpName %22 ""
               OpDecorate %17 Location 0
               OpMemberDecorate %20 0 Offset 0
               OpDecorate %20 Block
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypeFunction %7
         %11 = OpConstant %6 1
         %12 = OpConstant %6 0
         %13 = OpConstantComposite %7 %11 %12 %12 %11
         %16 = OpTypePointer Output %7
         %17 = OpVariable %16 Output
         %18 = OpConstantComposite %7 %12 %12 %12 %12
         %19 = OpTypeInt 32 1
         %20 = OpTypeStruct %19
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpConstant %19 0
         %24 = OpTypePointer Uniform %19
         %27 = OpTypeBool
         %33 = OpTypePointer Function %7
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %34 = OpVariable %33 Function
               OpStore %17 %18
         %25 = OpAccessChain %24 %22 %23
         %26 = OpLoad %19 %25
         %28 = OpIEqual %27 %26 %23
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %30
         %29 = OpLabel
               OpReturn
         %30 = OpLabel
               OpStore %34 %13
               OpStore %17 %13
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
               OpReturnValue %13
               OpFunctionEnd
