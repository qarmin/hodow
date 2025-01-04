#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 56
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %51
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "a"
               OpName %13 "buf0"
               OpMemberName %13 0 "zero"
               OpName %15 ""
               OpName %32 "b"
               OpName %51 "_GLF_color"
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %51 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstantComposite %7 %10 %10
         %12 = OpTypeInt 32 1
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpConstant %12 0
         %17 = OpTypePointer Uniform %12
         %20 = OpConstant %12 1
         %21 = OpTypeBool
         %25 = OpTypeInt 32 0
         %26 = OpConstant %25 0
         %27 = OpTypePointer Function %6
         %33 = OpConstant %25 1
         %36 = OpConstant %6 2
         %37 = OpConstant %6 3
         %38 = OpConstantComposite %7 %36 %37
         %42 = OpConstant %6 4
         %43 = OpConstantComposite %7 %37 %42
         %44 = OpTypeVector %21 2
         %49 = OpTypeVector %6 4
         %50 = OpTypePointer Output %49
         %51 = OpVariable %50 Output
         %52 = OpConstant %6 0
         %53 = OpConstantComposite %49 %10 %52 %52 %10
         %55 = OpConstantComposite %49 %52 %52 %52 %52
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %32 = OpVariable %8 Function
               OpStore %9 %11
         %18 = OpAccessChain %17 %15 %16
         %19 = OpLoad %12 %18
         %22 = OpIEqual %21 %19 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %28 = OpAccessChain %27 %9 %26
         %29 = OpLoad %6 %28
         %30 = OpFAdd %6 %29 %10
         %31 = OpAccessChain %27 %9 %26
               OpStore %31 %30
               OpBranch %24
         %24 = OpLabel
         %34 = OpAccessChain %27 %9 %33
         %35 = OpLoad %6 %34
         %39 = OpCompositeConstruct %7 %35 %35
         %40 = OpFAdd %7 %39 %38
               OpStore %32 %40
         %41 = OpLoad %7 %32
         %45 = OpFOrdEqual %44 %41 %43
         %46 = OpAll %21 %45
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %54
         %47 = OpLabel
               OpStore %51 %53
               OpBranch %48
         %54 = OpLabel
               OpStore %51 %55
               OpBranch %48
         %48 = OpLabel
               OpReturn
               OpFunctionEnd
