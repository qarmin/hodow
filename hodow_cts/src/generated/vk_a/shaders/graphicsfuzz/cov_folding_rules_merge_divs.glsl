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
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %11 "buf0"
               OpMemberName %11 0 "four"
               OpName %13 ""
               OpName %33 "_GLF_color"
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 0
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 2
         %10 = OpConstant %6 1
         %11 = OpTypeStruct %6
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpTypeInt 32 1
         %15 = OpConstant %14 0
         %16 = OpTypePointer Uniform %6
         %22 = OpConstant %6 7.9000001
         %23 = OpTypeBool
         %26 = OpConstant %6 8.10000038
         %31 = OpTypeVector %6 4
         %32 = OpTypePointer Output %31
         %33 = OpVariable %32 Output
         %34 = OpConstant %6 0
         %35 = OpConstantComposite %31 %10 %34 %34 %10
         %37 = OpConstantComposite %31 %34 %34 %34 %34
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %17 = OpAccessChain %16 %13 %15
         %18 = OpLoad %6 %17
         %19 = OpFDiv %6 %10 %18
         %20 = OpFDiv %6 %9 %19
               OpStore %8 %20
         %21 = OpLoad %6 %8
         %24 = OpFOrdGreaterThan %23 %21 %22
         %25 = OpLoad %6 %8
         %27 = OpFOrdLessThan %23 %25 %26
         %28 = OpLogicalAnd %23 %24 %27
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %36
         %29 = OpLabel
               OpStore %33 %35
               OpBranch %30
         %36 = OpLabel
               OpStore %33 %37
               OpBranch %30
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
