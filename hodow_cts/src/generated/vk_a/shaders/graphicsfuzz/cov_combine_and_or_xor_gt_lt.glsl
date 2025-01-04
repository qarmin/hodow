#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 67
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %41
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "b"
               OpName %12 "buf1"
               OpMemberName %12 0 "v1"
               OpName %14 ""
               OpName %41 "_GLF_color"
               OpName %44 "buf0"
               OpMemberName %44 0 "_GLF_uniform_int_values"
               OpName %46 ""
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %41 Location 0
               OpDecorate %43 ArrayStride 16
               OpMemberDecorate %44 0 RelaxedPrecision
               OpMemberDecorate %44 0 Offset 0
               OpDecorate %44 Block
               OpDecorate %46 DescriptorSet 0
               OpDecorate %46 Binding 0
               OpDecorate %49 RelaxedPrecision
               OpDecorate %53 RelaxedPrecision
               OpDecorate %56 RelaxedPrecision
               OpDecorate %59 RelaxedPrecision
               OpDecorate %64 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
          %7 = OpTypePointer Function %6
          %9 = OpConstantTrue %6
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 2
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 0
         %19 = OpTypePointer Uniform %10
         %22 = OpConstant %17 1
         %35 = OpConstantFalse %6
         %39 = OpTypeVector %10 4
         %40 = OpTypePointer Output %39
         %41 = OpVariable %40 Output
         %42 = OpConstant %17 2
         %43 = OpTypeArray %15 %42
         %44 = OpTypeStruct %43
         %45 = OpTypePointer Uniform %44
         %46 = OpVariable %45 Uniform
         %47 = OpTypePointer Uniform %15
         %51 = OpConstant %15 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %20 = OpAccessChain %19 %14 %16 %18
         %21 = OpLoad %10 %20
         %23 = OpAccessChain %19 %14 %16 %22
         %24 = OpLoad %10 %23
         %25 = OpFOrdGreaterThan %6 %21 %24
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %27
         %26 = OpLabel
         %28 = OpAccessChain %19 %14 %16 %18
         %29 = OpLoad %10 %28
         %30 = OpAccessChain %19 %14 %16 %22
         %31 = OpLoad %10 %30
         %32 = OpFOrdLessThan %6 %29 %31
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %34
         %33 = OpLabel
               OpStore %8 %35
               OpBranch %34
         %34 = OpLabel
               OpBranch %27
         %27 = OpLabel
         %36 = OpLoad %6 %8
               OpSelectionMerge %38 None
               OpBranchConditional %36 %37 %62
         %37 = OpLabel
         %48 = OpAccessChain %47 %46 %16 %16
         %49 = OpLoad %15 %48
         %50 = OpConvertSToF %10 %49
         %52 = OpAccessChain %47 %46 %16 %51
         %53 = OpLoad %15 %52
         %54 = OpConvertSToF %10 %53
         %55 = OpAccessChain %47 %46 %16 %51
         %56 = OpLoad %15 %55
         %57 = OpConvertSToF %10 %56
         %58 = OpAccessChain %47 %46 %16 %16
         %59 = OpLoad %15 %58
         %60 = OpConvertSToF %10 %59
         %61 = OpCompositeConstruct %39 %50 %54 %57 %60
               OpStore %41 %61
               OpBranch %38
         %62 = OpLabel
         %63 = OpAccessChain %47 %46 %16 %51
         %64 = OpLoad %15 %63
         %65 = OpConvertSToF %10 %64
         %66 = OpCompositeConstruct %39 %65 %65 %65 %65
               OpStore %41 %66
               OpBranch %38
         %38 = OpLabel
               OpReturn
               OpFunctionEnd
