#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 62
; Schema: 0
               OpCapability Shader
               OpCapability SignedZeroInfNanPreserve
               OpExtension "SPV_KHR_float_controls"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %43
               OpExecutionMode %4 OriginUpperLeft
               OpExecutionMode %4 SignedZeroInfNanPreserve 32
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "undefined"
               OpName %17 "buf0"
               OpMemberName %17 0 "_GLF_uniform_int_values"
               OpName %19 ""
               OpName %31 "buf1"
               OpMemberName %31 0 "_GLF_uniform_float_values"
               OpName %33 ""
               OpName %43 "_GLF_color"
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 RelaxedPrecision
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %23 RelaxedPrecision
               OpDecorate %30 ArrayStride 16
               OpMemberDecorate %31 0 Offset 0
               OpDecorate %31 Block
               OpDecorate %33 DescriptorSet 0
               OpDecorate %33 Binding 1
               OpDecorate %43 Location 0
               OpDecorate %45 RelaxedPrecision
               OpDecorate %48 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %54 RelaxedPrecision
               OpDecorate %59 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0x1.8p+128
         %11 = OpTypeBool
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 1
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 2
         %16 = OpTypeArray %12 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpConstant %12 0
         %21 = OpTypePointer Uniform %12
         %29 = OpConstant %14 1
         %30 = OpTypeArray %6 %29
         %31 = OpTypeStruct %30
         %32 = OpTypePointer Uniform %31
         %33 = OpVariable %32 Uniform
         %34 = OpTypePointer Uniform %6
         %41 = OpTypeVector %6 4
         %42 = OpTypePointer Output %41
         %43 = OpVariable %42 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpExtInst %6 %1 Sinh %9
               OpStore %8 %10
         %22 = OpAccessChain %21 %19 %20 %20
         %23 = OpLoad %12 %22
         %24 = OpIEqual %11 %13 %23
         %25 = OpLogicalNot %11 %24
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %27
         %26 = OpLabel
         %28 = OpLoad %6 %8
         %35 = OpAccessChain %34 %33 %20 %20
         %36 = OpLoad %6 %35
         %37 = OpFOrdGreaterThan %11 %28 %36
               OpBranch %27
         %27 = OpLabel
         %38 = OpPhi %11 %24 %5 %37 %26
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %57
         %39 = OpLabel
         %44 = OpAccessChain %21 %19 %20 %20
         %45 = OpLoad %12 %44
         %46 = OpConvertSToF %6 %45
         %47 = OpAccessChain %21 %19 %20 %13
         %48 = OpLoad %12 %47
         %49 = OpConvertSToF %6 %48
         %50 = OpAccessChain %21 %19 %20 %13
         %51 = OpLoad %12 %50
         %52 = OpConvertSToF %6 %51
         %53 = OpAccessChain %21 %19 %20 %20
         %54 = OpLoad %12 %53
         %55 = OpConvertSToF %6 %54
         %56 = OpCompositeConstruct %41 %46 %49 %52 %55
               OpStore %43 %56
               OpBranch %40
         %57 = OpLabel
         %58 = OpAccessChain %21 %19 %20 %13
         %59 = OpLoad %12 %58
         %60 = OpConvertSToF %6 %59
         %61 = OpCompositeConstruct %41 %60 %60 %60 %60
               OpStore %43 %61
               OpBranch %40
         %40 = OpLabel
               OpReturn
               OpFunctionEnd
