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
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %13 "f"
               OpName %14 "buf0"
               OpMemberName %14 0 "one"
               OpName %16 ""
               OpDecorate %9 Location 0
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %10 %10 %10 %10
         %12 = OpTypePointer Function %6
         %14 = OpTypeStruct %6
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpTypePointer Uniform %6
         %22 = OpConstant %6 1
         %27 = OpTypeBool
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %13 = OpVariable %12 Function
               OpStore %9 %11
         %20 = OpAccessChain %19 %16 %18
         %21 = OpLoad %6 %20
         %23 = OpExtInst %6 %1 FClamp %21 %22 %22
               OpStore %13 %23
         %24 = OpLoad %6 %13
         %25 = OpAccessChain %19 %16 %18
         %26 = OpLoad %6 %25
         %28 = OpFOrdGreaterThan %27 %24 %26
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %31
         %29 = OpLabel
               OpStore %9 %11
               OpBranch %30
         %31 = OpLabel
         %32 = OpLoad %6 %13
         %33 = OpCompositeConstruct %7 %32 %10 %10 %22
               OpStore %9 %33
               OpBranch %30
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
