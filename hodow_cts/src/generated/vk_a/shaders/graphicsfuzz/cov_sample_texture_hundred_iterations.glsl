#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 89
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %70
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %9 "texel"
               OpName %13 "tex"
               OpName %18 "buf0"
               OpMemberName %18 0 "_GLF_uniform_float_values"
               OpName %20 ""
               OpName %29 "texelCopy"
               OpName %32 "i"
               OpName %34 "buf1"
               OpMemberName %34 0 "_GLF_uniform_int_values"
               OpName %36 ""
               OpName %70 "_GLF_color"
               OpDecorate %13 RelaxedPrecision
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 2
               OpDecorate %14 RelaxedPrecision
               OpDecorate %17 ArrayStride 16
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %27 RelaxedPrecision
               OpDecorate %28 RelaxedPrecision
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 1
               OpDecorate %51 RelaxedPrecision
               OpDecorate %58 RelaxedPrecision
               OpDecorate %59 RelaxedPrecision
               OpDecorate %70 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeImage %6 2D 0 0 0 1 Unknown
         %11 = OpTypeSampledImage %10
         %12 = OpTypePointer UniformConstant %11
         %13 = OpVariable %12 UniformConstant
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 3
         %17 = OpTypeArray %6 %16
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 1
         %22 = OpConstant %21 0
         %23 = OpTypePointer Uniform %6
         %26 = OpTypeVector %6 2
         %31 = OpTypePointer Function %21
         %33 = OpTypeArray %21 %16
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpConstant %21 1
         %38 = OpTypePointer Uniform %21
         %49 = OpTypeBool
         %54 = OpConstant %21 2
         %64 = OpTypeVector %49 4
         %69 = OpTypePointer Output %7
         %70 = OpVariable %69 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %29 = OpVariable %8 Function
         %32 = OpVariable %31 Function
         %14 = OpLoad %11 %13
         %24 = OpAccessChain %23 %20 %22 %22
         %25 = OpLoad %6 %24
         %27 = OpCompositeConstruct %26 %25 %25
         %28 = OpImageSampleImplicitLod %7 %14 %27
               OpStore %9 %28
         %30 = OpLoad %7 %9
               OpStore %29 %30
         %39 = OpAccessChain %38 %36 %22 %37
         %40 = OpLoad %21 %39
               OpStore %32 %40
               OpBranch %41
         %41 = OpLabel
               OpLoopMerge %43 %44 None
               OpBranch %45
         %45 = OpLabel
         %46 = OpLoad %21 %32
         %47 = OpAccessChain %38 %36 %22 %22
         %48 = OpLoad %21 %47
         %50 = OpSLessThan %49 %46 %48
               OpBranchConditional %50 %42 %43
         %42 = OpLabel
         %51 = OpLoad %11 %13
         %52 = OpAccessChain %23 %20 %22 %37
         %53 = OpLoad %6 %52
         %55 = OpAccessChain %23 %20 %22 %54
         %56 = OpLoad %6 %55
         %57 = OpFDiv %6 %53 %56
         %58 = OpCompositeConstruct %26 %57 %57
         %59 = OpImageSampleImplicitLod %7 %51 %58
               OpStore %9 %59
               OpBranch %44
         %44 = OpLabel
         %60 = OpLoad %21 %32
         %61 = OpIAdd %21 %60 %37
               OpStore %32 %61
               OpBranch %41
         %43 = OpLabel
         %62 = OpLoad %7 %29
         %63 = OpLoad %7 %9
         %65 = OpFUnordNotEqual %64 %62 %63
         %66 = OpAny %49 %65
               OpSelectionMerge %68 None
               OpBranchConditional %66 %67 %84
         %67 = OpLabel
         %71 = OpAccessChain %38 %36 %22 %54
         %72 = OpLoad %21 %71
         %73 = OpConvertSToF %6 %72
         %74 = OpAccessChain %38 %36 %22 %37
         %75 = OpLoad %21 %74
         %76 = OpConvertSToF %6 %75
         %77 = OpAccessChain %38 %36 %22 %37
         %78 = OpLoad %21 %77
         %79 = OpConvertSToF %6 %78
         %80 = OpAccessChain %38 %36 %22 %54
         %81 = OpLoad %21 %80
         %82 = OpConvertSToF %6 %81
         %83 = OpCompositeConstruct %7 %73 %76 %79 %82
               OpStore %70 %83
               OpBranch %68
         %84 = OpLabel
         %85 = OpAccessChain %38 %36 %22 %37
         %86 = OpLoad %21 %85
         %87 = OpConvertSToF %6 %86
         %88 = OpCompositeConstruct %7 %87 %87 %87 %87
               OpStore %70 %88
               OpBranch %68
         %68 = OpLabel
               OpReturn
               OpFunctionEnd
