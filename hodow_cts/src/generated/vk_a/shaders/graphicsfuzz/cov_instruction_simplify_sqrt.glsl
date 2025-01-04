#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 56
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %31
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %31 "_GLF_color"
               OpName %33 "buf1"
               OpMemberName %33 0 "_GLF_uniform_int_values"
               OpName %35 ""
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %31 Location 0
               OpDecorate %32 ArrayStride 16
               OpMemberDecorate %33 0 RelaxedPrecision
               OpMemberDecorate %33 0 Offset 0
               OpDecorate %33 Block
               OpDecorate %35 DescriptorSet 0
               OpDecorate %35 Binding 1
               OpDecorate %39 RelaxedPrecision
               OpDecorate %44 RelaxedPrecision
               OpDecorate %47 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 2
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %6
         %20 = OpConstant %6 -1
         %25 = OpTypeBool
         %29 = OpTypeVector %6 4
         %30 = OpTypePointer Output %29
         %31 = OpVariable %30 Output
         %32 = OpTypeArray %15 %10
         %33 = OpTypeStruct %32
         %34 = OpTypePointer Uniform %33
         %35 = OpVariable %34 Uniform
         %36 = OpConstant %15 1
         %37 = OpTypePointer Uniform %15
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %21 = OpAccessChain %17 %14 %16 %16
         %22 = OpLoad %6 %21
         %23 = OpExtInst %6 %1 Sqrt %22
         %26 = OpFOrdLessThan %25 %23 %20
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %42
         %27 = OpLabel
         %38 = OpAccessChain %37 %35 %16 %36
         %39 = OpLoad %15 %38
         %40 = OpConvertSToF %6 %39
         %41 = OpCompositeConstruct %29 %40 %40 %40 %40
               OpStore %31 %41
               OpBranch %28
         %42 = OpLabel
         %43 = OpAccessChain %37 %35 %16 %16
         %44 = OpLoad %15 %43
         %45 = OpConvertSToF %6 %44
         %46 = OpAccessChain %37 %35 %16 %36
         %47 = OpLoad %15 %46
         %48 = OpConvertSToF %6 %47
         %55 = OpCompositeConstruct %29 %45 %48 %48 %45
               OpStore %31 %55
               OpBranch %28
         %28 = OpLabel
               OpReturn
               OpFunctionEnd
