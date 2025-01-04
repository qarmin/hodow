#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 57
; Schema: 0
               OpCapability Shader
               OpCapability SignedZeroInfNanPreserve
               OpExtension "SPV_KHR_float_controls"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpExecutionMode %4 SignedZeroInfNanPreserve 32
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %34 "a"
               OpName %36 "buf1"
               OpMemberName %36 0 "_GLF_uniform_float_values"
               OpName %38 ""
               OpDecorate %9 Location 0
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 RelaxedPrecision
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %20 RelaxedPrecision
               OpDecorate %24 RelaxedPrecision
               OpDecorate %27 RelaxedPrecision
               OpDecorate %30 RelaxedPrecision
               OpDecorate %35 ArrayStride 16
               OpMemberDecorate %36 0 Offset 0
               OpDecorate %36 Block
               OpDecorate %38 DescriptorSet 0
               OpDecorate %38 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypeInt 32 1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 2
         %13 = OpTypeArray %10 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %10 0
         %18 = OpTypePointer Uniform %10
         %22 = OpConstant %10 1
         %33 = OpTypePointer Function %6
         %35 = OpTypeArray %6 %12
         %36 = OpTypeStruct %35
         %37 = OpTypePointer Uniform %36
         %38 = OpVariable %37 Uniform
         %39 = OpTypePointer Uniform %6
         %43 = OpConstant %6 0x1.8p+128
         %48 = OpTypeBool
         %54 = OpConstant %11 1
         %55 = OpTypePointer Output %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %34 = OpVariable %33 Function
         %19 = OpAccessChain %18 %16 %17 %17
         %20 = OpLoad %10 %19
         %21 = OpConvertSToF %6 %20
         %23 = OpAccessChain %18 %16 %17 %22
         %24 = OpLoad %10 %23
         %25 = OpConvertSToF %6 %24
         %26 = OpAccessChain %18 %16 %17 %22
         %27 = OpLoad %10 %26
         %28 = OpConvertSToF %6 %27
         %29 = OpAccessChain %18 %16 %17 %17
         %30 = OpLoad %10 %29
         %31 = OpConvertSToF %6 %30
         %32 = OpCompositeConstruct %7 %21 %25 %28 %31
               OpStore %9 %32
         %40 = OpAccessChain %39 %38 %17 %22
         %41 = OpLoad %6 %40
         %42 = OpExtInst %6 %1 Atanh %41
         %44 = OpFSub %6 %42 %43
               OpStore %34 %44
         %45 = OpLoad %6 %34
         %46 = OpAccessChain %39 %38 %17 %17
         %47 = OpLoad %6 %46
         %49 = OpFOrdNotEqual %48 %45 %47
               OpSelectionMerge %51 None
               OpBranchConditional %49 %50 %51
         %50 = OpLabel
         %52 = OpAccessChain %39 %38 %17 %17
         %53 = OpLoad %6 %52
         %56 = OpAccessChain %55 %9 %54
               OpStore %56 %53
               OpBranch %51
         %51 = OpLabel
               OpReturn
               OpFunctionEnd
