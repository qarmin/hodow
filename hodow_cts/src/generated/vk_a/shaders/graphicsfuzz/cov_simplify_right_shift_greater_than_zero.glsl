#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 45
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %26
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "buf0"
               OpMemberName %11 0 "_GLF_uniform_int_values"
               OpName %13 ""
               OpName %26 "_GLF_color"
               OpDecorate %10 ArrayStride 16
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 0
               OpDecorate %26 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpConstant %6 1
          %8 = OpTypeInt 32 0
          %9 = OpConstant %8 2
         %10 = OpTypeArray %6 %9
         %11 = OpTypeStruct %10
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpConstant %6 0
         %15 = OpTypePointer Uniform %6
         %19 = OpTypeBool
         %23 = OpTypeFloat 32
         %24 = OpTypeVector %23 4
         %25 = OpTypePointer Output %24
         %26 = OpVariable %25 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %16 = OpAccessChain %15 %13 %14 %14
         %17 = OpLoad %6 %16
         %18 = OpShiftRightArithmetic %6 %7 %17
         %20 = OpSGreaterThan %19 %18 %14
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %40
         %21 = OpLabel
         %27 = OpAccessChain %15 %13 %14 %7
         %28 = OpLoad %6 %27
         %29 = OpConvertSToF %23 %28
         %30 = OpAccessChain %15 %13 %14 %14
         %31 = OpLoad %6 %30
         %32 = OpConvertSToF %23 %31
         %33 = OpAccessChain %15 %13 %14 %14
         %34 = OpLoad %6 %33
         %35 = OpConvertSToF %23 %34
         %36 = OpAccessChain %15 %13 %14 %7
         %37 = OpLoad %6 %36
         %38 = OpConvertSToF %23 %37
         %39 = OpCompositeConstruct %24 %29 %32 %35 %38
               OpStore %26 %39
               OpBranch %22
         %40 = OpLabel
         %41 = OpAccessChain %15 %13 %14 %14
         %42 = OpLoad %6 %41
         %43 = OpConvertSToF %23 %42
         %44 = OpCompositeConstruct %24 %43 %43 %43 %43
               OpStore %26 %44
               OpBranch %22
         %22 = OpLabel
               OpReturn
               OpFunctionEnd
