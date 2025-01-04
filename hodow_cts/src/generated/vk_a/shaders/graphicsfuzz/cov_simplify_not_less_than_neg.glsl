#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 41
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %22 %35
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "three"
               OpName %10 ""
               OpName %22 "gl_FragCoord"
               OpName %35 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %22 BuiltIn FragCoord
               OpDecorate %35 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
          %7 = OpTypeInt 32 1
          %8 = OpTypeStruct %7
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpConstant %7 0
         %12 = OpTypePointer Uniform %7
         %15 = OpConstant %7 1
         %19 = OpTypeFloat 32
         %20 = OpTypeVector %19 4
         %21 = OpTypePointer Input %20
         %22 = OpVariable %21 Input
         %23 = OpTypeInt 32 0
         %24 = OpConstant %23 1
         %25 = OpTypePointer Input %19
         %28 = OpConstant %19 -5
         %34 = OpTypePointer Output %20
         %35 = OpVariable %34 Output
         %36 = OpConstant %19 1
         %37 = OpConstant %19 0
         %38 = OpConstantComposite %20 %36 %37 %37 %36
         %40 = OpConstantComposite %20 %37 %37 %37 %37
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %13 = OpAccessChain %12 %10 %11
         %14 = OpLoad %7 %13
         %16 = OpSGreaterThan %6 %14 %15
               OpSelectionMerge %18 None
               OpBranchConditional %16 %17 %18
         %17 = OpLabel
         %26 = OpAccessChain %25 %22 %24
         %27 = OpLoad %19 %26
         %29 = OpFOrdLessThan %6 %27 %28
         %30 = OpLogicalNot %6 %29
               OpBranch %18
         %18 = OpLabel
         %31 = OpPhi %6 %16 %5 %30 %17
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %39
         %32 = OpLabel
               OpStore %35 %38
               OpBranch %33
         %39 = OpLabel
               OpStore %35 %40
               OpBranch %33
         %33 = OpLabel
               OpReturn
               OpFunctionEnd
