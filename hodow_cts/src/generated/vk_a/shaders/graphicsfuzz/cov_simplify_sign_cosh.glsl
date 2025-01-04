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
               OpName %17 "buf0"
               OpMemberName %17 0 "one"
               OpName %19 ""
               OpName %31 "_GLF_color"
               OpMemberDecorate %17 0 RelaxedPrecision
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %23 RelaxedPrecision
               OpDecorate %31 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
          %7 = OpTypeFloat 32
          %8 = OpConstant %7 80
         %11 = OpConstant %7 1
         %16 = OpTypeInt 32 1
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpConstant %16 0
         %21 = OpTypePointer Uniform %16
         %24 = OpConstant %16 1
         %29 = OpTypeVector %7 4
         %30 = OpTypePointer Output %29
         %31 = OpVariable %30 Output
         %32 = OpConstant %7 0
         %33 = OpConstantComposite %29 %11 %32 %32 %11
         %35 = OpConstantComposite %29 %11 %11 %11 %11
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpExtInst %7 %1 Cosh %8
         %10 = OpExtInst %7 %1 FSign %9
         %12 = OpFOrdEqual %6 %10 %11
         %13 = OpLogicalNot %6 %12
               OpSelectionMerge %15 None
               OpBranchConditional %13 %14 %15
         %14 = OpLabel
         %22 = OpAccessChain %21 %19 %20
         %23 = OpLoad %16 %22
         %25 = OpIEqual %6 %23 %24
               OpBranch %15
         %15 = OpLabel
         %26 = OpPhi %6 %12 %5 %25 %14
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
