#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 129
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %27 %79
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "buf2"
               OpMemberName %8 0 "injectionSwitch"
               OpName %10 ""
               OpName %27 "_GLF_color"
               OpName %30 "buf0"
               OpMemberName %30 0 "_GLF_uniform_float_values"
               OpName %32 ""
               OpName %40 "buf1"
               OpMemberName %40 0 "_GLF_uniform_int_values"
               OpName %42 ""
               OpName %79 "gl_FragCoord"
               OpName %122 "indexable"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 2
               OpDecorate %27 Location 0
               OpDecorate %29 ArrayStride 16
               OpMemberDecorate %30 0 Offset 0
               OpDecorate %30 Block
               OpDecorate %32 DescriptorSet 0
               OpDecorate %32 Binding 0
               OpDecorate %39 ArrayStride 16
               OpMemberDecorate %40 0 Offset 0
               OpDecorate %40 Block
               OpDecorate %42 DescriptorSet 0
               OpDecorate %42 Binding 1
               OpDecorate %79 BuiltIn FragCoord
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeStruct %7
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %6
         %18 = OpConstant %13 1
         %21 = OpTypeBool
         %25 = OpTypeVector %6 4
         %26 = OpTypePointer Output %25
         %27 = OpVariable %26 Output
         %28 = OpConstant %13 2
         %29 = OpTypeArray %6 %28
         %30 = OpTypeStruct %29
         %31 = OpTypePointer Uniform %30
         %32 = OpVariable %31 Uniform
         %38 = OpConstant %13 3
         %39 = OpTypeArray %11 %38
         %40 = OpTypeStruct %39
         %41 = OpTypePointer Uniform %40
         %42 = OpVariable %41 Uniform
         %43 = OpConstant %11 1
         %44 = OpTypePointer Uniform %11
         %78 = OpTypePointer Input %25
         %79 = OpVariable %78 Input
         %80 = OpTypePointer Input %6
        %103 = OpConstant %11 2
        %117 = OpConstant %13 4
        %118 = OpTypeArray %25 %117
        %121 = OpTypePointer Function %118
        %123 = OpTypePointer Function %25
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %122 = OpVariable %121 Function
         %16 = OpAccessChain %15 %10 %12 %14
         %17 = OpLoad %6 %16
         %19 = OpAccessChain %15 %10 %12 %18
         %20 = OpLoad %6 %19
         %22 = OpFOrdGreaterThan %21 %17 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpAccessChain %15 %32 %12 %12
         %34 = OpLoad %6 %33
         %35 = OpCompositeConstruct %25 %34 %34 %34 %34
               OpStore %27 %35
               OpBranch %24
         %24 = OpLabel
         %45 = OpAccessChain %44 %42 %12 %43
         %46 = OpLoad %11 %45
               OpBranch %47
         %47 = OpLabel
        %128 = OpPhi %11 %46 %24 %127 %50
         %53 = OpAccessChain %44 %42 %12 %12
         %54 = OpLoad %11 %53
         %55 = OpSLessThan %21 %128 %54
               OpLoopMerge %49 %50 None
               OpBranchConditional %55 %48 %49
         %48 = OpLabel
               OpBranch %56
         %56 = OpLabel
               OpLoopMerge %58 %59 None
               OpBranch %57
         %57 = OpLabel
               OpSelectionMerge %66 None
               OpBranchConditional %22 %65 %66
         %65 = OpLabel
         %67 = OpAccessChain %15 %32 %12 %12
         %68 = OpLoad %6 %67
         %69 = OpCompositeConstruct %25 %68 %68 %68 %68
         %70 = OpExtInst %25 %1 Atanh %69
               OpStore %27 %70
               OpBranch %66
         %66 = OpLabel
               OpBranch %71
         %71 = OpLabel
         %75 = OpAccessChain %15 %32 %12 %12
         %76 = OpLoad %6 %75
         %77 = OpCompositeConstruct %25 %76 %76 %76 %76
               OpStore %27 %77
         %81 = OpAccessChain %80 %79 %14
         %82 = OpLoad %6 %81
         %83 = OpAccessChain %15 %32 %12 %43
         %84 = OpLoad %6 %83
         %85 = OpFOrdLessThan %21 %82 %84
               OpLoopMerge %73 %71 None
               OpBranchConditional %85 %71 %73
         %73 = OpLabel
               OpBranch %59
         %59 = OpLabel
               OpBranchConditional %22 %56 %58
         %58 = OpLabel
         %93 = OpConvertSToF %6 %46
         %94 = OpCompositeConstruct %25 %93 %93 %93 %93
        %104 = OpAccessChain %44 %42 %12 %103
        %105 = OpLoad %11 %104
        %106 = OpConvertSToF %6 %105
        %116 = OpCompositeConstruct %25 %106 %93 %93 %106
        %119 = OpCompositeConstruct %118 %94 %94 %94 %116
               OpStore %122 %119
        %124 = OpAccessChain %123 %122 %128
        %125 = OpLoad %25 %124
               OpStore %27 %125
               OpBranch %50
         %50 = OpLabel
        %127 = OpIAdd %11 %128 %43
               OpBranch %47
         %49 = OpLabel
               OpReturn
               OpFunctionEnd
