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
               OpEntryPoint Fragment %4 "main" %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %13 "buf0"
               OpMemberName %13 0 "two"
               OpName %15 ""
               OpName %26 "d"
               OpName %40 "_GLF_color"
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %40 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 0.100000001
         %11 = OpConstantComposite %7 %10 %10
         %12 = OpTypeInt 32 1
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpConstant %12 0
         %17 = OpTypePointer Uniform %12
         %20 = OpConstant %12 3
         %21 = OpTypeVector %12 2
         %25 = OpTypePointer Function %6
         %28 = OpConstant %6 1.15927994
         %29 = OpConstant %6 0.64349997
         %30 = OpConstantComposite %7 %28 %29
         %33 = OpConstant %6 0.00999999978
         %34 = OpTypeBool
         %38 = OpTypeVector %6 4
         %39 = OpTypePointer Output %38
         %40 = OpVariable %39 Output
         %41 = OpConstant %6 1
         %42 = OpConstant %6 0
         %43 = OpConstantComposite %38 %41 %42 %42 %41
         %45 = OpConstantComposite %38 %42 %42 %42 %42
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %26 = OpVariable %25 Function
         %18 = OpAccessChain %17 %15 %16
         %19 = OpLoad %12 %18
         %22 = OpCompositeConstruct %21 %19 %20
         %23 = OpExtInst %7 %1 Ldexp %11 %22
         %24 = OpExtInst %7 %1 Acos %23
               OpStore %9 %24
         %27 = OpLoad %7 %9
         %31 = OpExtInst %6 %1 Distance %27 %30
               OpStore %26 %31
         %32 = OpLoad %6 %26
         %35 = OpFOrdLessThan %34 %32 %33
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %44
         %36 = OpLabel
               OpStore %40 %43
               OpBranch %37
         %44 = OpLabel
               OpStore %40 %45
               OpBranch %37
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
