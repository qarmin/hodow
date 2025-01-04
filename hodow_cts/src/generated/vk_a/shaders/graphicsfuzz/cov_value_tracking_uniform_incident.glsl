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
               OpName %9 "N"
               OpName %15 "I"
               OpName %17 "buf0"
               OpMemberName %17 0 "quarter"
               OpName %19 ""
               OpName %27 "Nref"
               OpName %33 "v"
               OpName %51 "_GLF_color"
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %51 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstant %6 2
         %12 = OpConstant %6 3
         %13 = OpConstant %6 4
         %14 = OpConstantComposite %7 %10 %11 %12 %13
         %16 = OpConstant %6 87.5899963
         %17 = OpTypeStruct %6
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypeInt 32 1
         %21 = OpConstant %20 0
         %22 = OpTypePointer Uniform %6
         %25 = OpConstant %6 92.5100021
         %28 = OpConstant %6 17.0499992
         %29 = OpConstant %6 -6.0999999
         %30 = OpConstant %6 4329.37061
         %31 = OpConstant %6 2.70000005
         %32 = OpConstantComposite %7 %28 %29 %30 %31
         %39 = OpConstant %6 -1
         %40 = OpConstant %6 -2
         %41 = OpConstant %6 -3
         %42 = OpConstant %6 -4
         %43 = OpConstantComposite %7 %39 %40 %41 %42
         %44 = OpTypeBool
         %45 = OpTypeVector %44 4
         %50 = OpTypePointer Output %7
         %51 = OpVariable %50 Output
         %52 = OpConstant %6 0
         %53 = OpConstantComposite %7 %10 %52 %52 %10
         %55 = OpConstantComposite %7 %52 %52 %52 %52
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %15 = OpVariable %8 Function
         %27 = OpVariable %8 Function
         %33 = OpVariable %8 Function
               OpStore %9 %14
         %23 = OpAccessChain %22 %19 %21
         %24 = OpLoad %6 %23
         %26 = OpCompositeConstruct %7 %13 %16 %24 %25
               OpStore %15 %26
               OpStore %27 %32
         %34 = OpLoad %7 %9
         %35 = OpLoad %7 %15
         %36 = OpLoad %7 %27
         %37 = OpExtInst %7 %1 FaceForward %34 %35 %36
               OpStore %33 %37
         %38 = OpLoad %7 %33
         %46 = OpFOrdEqual %45 %38 %43
         %47 = OpAll %44 %46
               OpSelectionMerge %49 None
               OpBranchConditional %47 %48 %54
         %48 = OpLabel
               OpStore %51 %53
               OpBranch %49
         %54 = OpLabel
               OpStore %51 %55
               OpBranch %49
         %49 = OpLabel
               OpReturn
               OpFunctionEnd
