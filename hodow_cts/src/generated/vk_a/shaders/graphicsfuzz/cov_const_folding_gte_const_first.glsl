#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 38
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %10 %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "gl_FragCoord"
               OpName %18 "buf0"
               OpMemberName %18 0 "one"
               OpName %20 ""
               OpName %33 "_GLF_color"
               OpDecorate %10 BuiltIn FragCoord
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpConstant %6 3
          %8 = OpTypeVector %6 4
          %9 = OpTypePointer Input %8
         %10 = OpVariable %9 Input
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 0
         %13 = OpTypePointer Input %6
         %16 = OpConstant %6 1
         %17 = OpConstant %6 2
         %18 = OpTypeStruct %6
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 1
         %22 = OpConstant %21 0
         %23 = OpTypePointer Uniform %6
         %28 = OpTypeBool
         %32 = OpTypePointer Output %8
         %33 = OpVariable %32 Output
         %34 = OpConstant %6 0
         %35 = OpConstantComposite %8 %16 %34 %34 %16
         %37 = OpConstantComposite %8 %34 %34 %34 %34
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpAccessChain %13 %10 %12
         %15 = OpLoad %6 %14
         %24 = OpAccessChain %23 %20 %22
         %25 = OpLoad %6 %24
         %26 = OpFAdd %6 %17 %25
         %27 = OpExtInst %6 %1 FClamp %15 %16 %26
         %29 = OpFOrdGreaterThanEqual %28 %7 %27
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %36
         %30 = OpLabel
               OpStore %33 %35
               OpBranch %31
         %36 = OpLabel
               OpStore %33 %37
               OpBranch %31
         %31 = OpLabel
               OpReturn
               OpFunctionEnd
