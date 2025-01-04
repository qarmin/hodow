#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 39
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %35
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "m"
               OpName %13 "buf0"
               OpMemberName %13 0 "one"
               OpName %15 ""
               OpName %35 "_GLF_color"
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %35 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypeMatrix %7 4
          %9 = OpTypePointer Function %8
         %11 = OpConstant %6 1
         %12 = OpConstant %6 0
         %13 = OpTypeStruct %6
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %29 = OpConstant %6 0.00999999978
         %30 = OpTypeBool
         %34 = OpTypePointer Output %7
         %35 = OpVariable %34 Output
         %36 = OpConstantComposite %7 %11 %12 %12 %11
         %38 = OpConstantComposite %7 %12 %12 %12 %12
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %9 Function
         %19 = OpAccessChain %18 %15 %17
         %20 = OpLoad %6 %19
         %21 = OpCompositeConstruct %7 %11 %11 %12 %11
         %22 = OpCompositeConstruct %7 %12 %12 %11 %11
         %23 = OpCompositeConstruct %7 %12 %12 %20 %12
         %24 = OpCompositeConstruct %7 %12 %12 %12 %12
         %25 = OpCompositeConstruct %8 %21 %22 %23 %24
               OpStore %10 %25
         %26 = OpLoad %8 %10
         %27 = OpExtInst %6 %1 Determinant %26
         %28 = OpExtInst %6 %1 FAbs %27
         %31 = OpFOrdLessThan %30 %28 %29
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %37
         %32 = OpLabel
               OpStore %35 %36
               OpBranch %33
         %37 = OpLabel
               OpStore %35 %38
               OpBranch %33
         %33 = OpLabel
               OpReturn
               OpFunctionEnd
