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
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "zero"
               OpName %10 ""
               OpName %33 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpConstant %6 2
          %8 = OpTypeStruct %6
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypePointer Uniform %6
         %16 = OpConstant %6 1
         %18 = OpConstant %6 -1
         %19 = OpConstant %6 0
         %23 = OpTypeVector %6 4
         %25 = OpConstantComposite %23 %16 %19 %19 %16
         %26 = OpTypeBool
         %27 = OpTypeVector %26 4
         %32 = OpTypePointer Output %23
         %33 = OpVariable %32 Output
         %34 = OpConstantComposite %23 %19 %19 %19 %19
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpAccessChain %13 %10 %12
         %15 = OpLoad %6 %14
         %17 = OpExtInst %6 %1 FClamp %7 %15 %16
         %20 = OpAccessChain %13 %10 %12
         %21 = OpLoad %6 %20
         %22 = OpExtInst %6 %1 FClamp %18 %19 %21
         %24 = OpCompositeConstruct %23 %17 %22 %19 %16
         %28 = OpFOrdNotEqual %27 %24 %25
         %29 = OpAny %26 %28
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %35
         %30 = OpLabel
               OpStore %33 %34
               OpBranch %31
         %35 = OpLabel
               OpStore %33 %25
               OpBranch %31
         %31 = OpLabel
               OpReturn
               OpFunctionEnd
