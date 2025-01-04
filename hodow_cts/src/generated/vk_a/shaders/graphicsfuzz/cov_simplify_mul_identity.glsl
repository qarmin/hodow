#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 46
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %42
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %15 "res"
               OpName %16 "buf0"
               OpMemberName %16 0 "one"
               OpName %18 ""
               OpName %42 "_GLF_color"
               OpMemberDecorate %16 0 Offset 0
               OpDecorate %16 Block
               OpDecorate %18 DescriptorSet 0
               OpDecorate %18 Binding 0
               OpDecorate %42 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 8.39999962
         %11 = OpConstant %6 -864.664978
         %12 = OpConstant %6 945.419983
         %13 = OpConstant %6 1
         %14 = OpConstantComposite %7 %10 %11 %12 %13
         %16 = OpTypeStruct %6
         %17 = OpTypePointer Uniform %16
         %18 = OpVariable %17 Uniform
         %19 = OpTypeInt 32 1
         %20 = OpConstant %19 0
         %21 = OpTypePointer Uniform %6
         %24 = OpTypeMatrix %7 4
         %25 = OpConstant %6 0
         %36 = OpConstant %6 0.00999999978
         %37 = OpTypeBool
         %41 = OpTypePointer Output %7
         %42 = OpVariable %41 Output
         %43 = OpConstantComposite %7 %13 %25 %25 %13
         %45 = OpConstantComposite %7 %25 %25 %25 %25
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %15 = OpVariable %8 Function
               OpStore %9 %14
         %22 = OpAccessChain %21 %18 %20
         %23 = OpLoad %6 %22
         %26 = OpCompositeConstruct %7 %23 %25 %25 %25
         %27 = OpCompositeConstruct %7 %25 %23 %25 %25
         %28 = OpCompositeConstruct %7 %25 %25 %23 %25
         %29 = OpCompositeConstruct %7 %25 %25 %25 %23
         %30 = OpCompositeConstruct %24 %26 %27 %28 %29
         %31 = OpLoad %7 %9
         %32 = OpMatrixTimesVector %7 %30 %31
               OpStore %15 %32
         %33 = OpLoad %7 %9
         %34 = OpLoad %7 %15
         %35 = OpExtInst %6 %1 Distance %33 %34
         %38 = OpFOrdLessThan %37 %35 %36
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %44
         %39 = OpLabel
               OpStore %42 %43
               OpBranch %40
         %44 = OpLabel
               OpStore %42 %45
               OpBranch %40
         %40 = OpLabel
               OpReturn
               OpFunctionEnd
