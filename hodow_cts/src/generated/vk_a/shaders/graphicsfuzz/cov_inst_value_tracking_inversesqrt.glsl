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
               OpEntryPoint Fragment %4 "main" %27
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "buf0"
               OpMemberName %10 0 "_GLF_uniform_float_values"
               OpName %12 ""
               OpName %27 "_GLF_color"
               OpDecorate %9 ArrayStride 16
               OpMemberDecorate %10 0 Offset 0
               OpDecorate %10 Block
               OpDecorate %12 DescriptorSet 0
               OpDecorate %12 Binding 0
               OpDecorate %27 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypeStruct %9
         %11 = OpTypePointer Uniform %10
         %12 = OpVariable %11 Uniform
         %13 = OpTypeInt 32 1
         %14 = OpConstant %13 0
         %15 = OpConstant %13 1
         %16 = OpTypePointer Uniform %6
         %20 = OpConstant %6 -1
         %21 = OpTypeBool
         %25 = OpTypeVector %6 4
         %26 = OpTypePointer Output %25
         %27 = OpVariable %26 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %17 = OpAccessChain %16 %12 %14 %15
         %18 = OpLoad %6 %17
         %19 = OpExtInst %6 %1 InverseSqrt %18
         %22 = OpFOrdLessThan %21 %19 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %31
         %23 = OpLabel
         %28 = OpAccessChain %16 %12 %14 %14
         %29 = OpLoad %6 %28
         %30 = OpCompositeConstruct %25 %29 %29 %29 %29
               OpStore %27 %30
               OpBranch %24
         %31 = OpLabel
         %32 = OpAccessChain %16 %12 %14 %15
         %33 = OpLoad %6 %32
         %34 = OpAccessChain %16 %12 %14 %14
         %35 = OpLoad %6 %34
         %36 = OpAccessChain %16 %12 %14 %14
         %37 = OpLoad %6 %36
         %38 = OpAccessChain %16 %12 %14 %15
         %39 = OpLoad %6 %38
         %40 = OpCompositeConstruct %25 %33 %35 %37 %39
               OpStore %27 %40
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd
