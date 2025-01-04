#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 51
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %49
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "color"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %30 "buf1"
               OpMemberName %30 0 "_GLF_uniform_int_values"
               OpName %32 ""
               OpName %49 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %29 ArrayStride 16
               OpMemberDecorate %30 0 Offset 0
               OpDecorate %30 Block
               OpDecorate %32 DescriptorSet 0
               OpDecorate %32 Binding 1
               OpDecorate %49 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 2
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %25 = OpConstant %16 1
         %29 = OpTypeArray %16 %11
         %30 = OpTypeStruct %29
         %31 = OpTypePointer Uniform %30
         %32 = OpVariable %31 Uniform
         %33 = OpTypePointer Uniform %16
         %44 = OpTypePointer Function %6
         %48 = OpTypePointer Output %7
         %49 = OpVariable %48 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %19 = OpAccessChain %18 %15 %17 %17
         %20 = OpLoad %6 %19
         %21 = OpAccessChain %18 %15 %17 %17
         %22 = OpLoad %6 %21
         %23 = OpAccessChain %18 %15 %17 %17
         %24 = OpLoad %6 %23
         %26 = OpAccessChain %18 %15 %17 %25
         %27 = OpLoad %6 %26
         %28 = OpCompositeConstruct %7 %20 %22 %24 %27
               OpStore %9 %28
         %34 = OpAccessChain %33 %32 %17 %25
         %35 = OpLoad %16 %34
         %36 = OpBitwiseOr %16 %25 %35
         %37 = OpBitwiseXor %16 %36 %25
               OpSelectionMerge %39 None
               OpSwitch %37 %39 0 %38
         %38 = OpLabel
         %40 = OpAccessChain %33 %32 %17 %17
         %41 = OpLoad %16 %40
         %42 = OpAccessChain %18 %15 %17 %25
         %43 = OpLoad %6 %42
         %45 = OpAccessChain %44 %9 %41
               OpStore %45 %43
               OpBranch %39
         %39 = OpLabel
         %50 = OpLoad %7 %9
               OpStore %49 %50
               OpReturn
               OpFunctionEnd
