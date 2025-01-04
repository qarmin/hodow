#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 121
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %29 %102
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "b"
               OpName %24 "c"
               OpName %29 "gl_FragCoord"
               OpName %36 "buf0"
               OpMemberName %36 0 "_GLF_uniform_float_values"
               OpName %38 ""
               OpName %48 "d"
               OpName %102 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %29 BuiltIn FragCoord
               OpDecorate %35 ArrayStride 16
               OpMemberDecorate %36 0 Offset 0
               OpDecorate %36 Block
               OpDecorate %38 DescriptorSet 0
               OpDecorate %38 Binding 0
               OpDecorate %102 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 5
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 2
         %17 = OpTypePointer Uniform %6
         %21 = OpConstant %6 3
         %25 = OpConstant %6 1
         %26 = OpTypeFloat 32
         %27 = OpTypeVector %26 4
         %28 = OpTypePointer Input %27
         %29 = OpVariable %28 Input
         %30 = OpConstant %9 0
         %31 = OpTypePointer Input %26
         %34 = OpConstant %9 1
         %35 = OpTypeArray %26 %34
         %36 = OpTypeStruct %35
         %37 = OpTypePointer Uniform %36
         %38 = OpVariable %37 Uniform
         %39 = OpTypePointer Uniform %26
         %42 = OpTypeBool
         %49 = OpConstant %6 32
         %58 = OpConstant %6 4
        %101 = OpTypePointer Output %27
        %102 = OpVariable %101 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %24 = OpVariable %7 Function
         %48 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %22 = OpAccessChain %17 %14 %15 %21
         %23 = OpLoad %6 %22
               OpStore %20 %23
               OpStore %24 %25
         %32 = OpAccessChain %31 %29 %30
         %33 = OpLoad %26 %32
         %40 = OpAccessChain %39 %38 %15 %15
         %41 = OpLoad %26 %40
         %43 = OpFOrdLessThan %42 %33 %41
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %45
         %44 = OpLabel
         %46 = OpLoad %6 %24
         %47 = OpISub %6 %46 %25
               OpStore %24 %47
               OpBranch %45
         %45 = OpLabel
         %50 = OpLoad %6 %24
         %51 = OpBitFieldInsert %6 %25 %25 %49 %50
               OpStore %48 %51
         %52 = OpLoad %6 %48
         %53 = OpAccessChain %17 %14 %15 %15
         %54 = OpLoad %6 %53
         %55 = OpSLessThan %42 %52 %54
               OpSelectionMerge %57 None
               OpBranchConditional %55 %56 %57
         %56 = OpLabel
         %59 = OpAccessChain %17 %14 %15 %58
         %60 = OpLoad %6 %59
               OpStore %48 %60
               OpBranch %57
         %57 = OpLabel
               OpBranch %61
         %61 = OpLabel
               OpLoopMerge %63 %64 None
               OpBranch %65
         %65 = OpLabel
         %66 = OpLoad %6 %8
         %67 = OpLoad %6 %20
         %68 = OpSLessThan %42 %66 %67
         %69 = OpLogicalNot %42 %68
               OpSelectionMerge %71 None
               OpBranchConditional %69 %70 %71
         %70 = OpLabel
         %72 = OpLoad %6 %48
         %73 = OpAccessChain %17 %14 %15 %15
         %74 = OpLoad %6 %73
         %75 = OpSLessThan %42 %72 %74
               OpBranch %71
         %71 = OpLabel
         %76 = OpPhi %42 %68 %65 %75 %70
               OpBranchConditional %76 %62 %63
         %62 = OpLabel
         %77 = OpAccessChain %17 %14 %15 %15
         %78 = OpLoad %6 %77
         %79 = OpAccessChain %17 %14 %15 %15
         %80 = OpLoad %6 %79
         %81 = OpAccessChain %17 %14 %15 %25
         %82 = OpLoad %6 %81
         %83 = OpLoad %6 %24
         %84 = OpBitFieldInsert %6 %78 %80 %82 %83
               OpStore %48 %84
         %85 = OpLoad %6 %48
         %86 = OpAccessChain %17 %14 %15 %15
         %87 = OpLoad %6 %86
         %88 = OpSLessThan %42 %85 %87
               OpSelectionMerge %90 None
               OpBranchConditional %88 %89 %90
         %89 = OpLabel
         %91 = OpAccessChain %17 %14 %15 %58
         %92 = OpLoad %6 %91
               OpStore %48 %92
               OpBranch %90
         %90 = OpLabel
         %93 = OpLoad %6 %8
         %94 = OpIAdd %6 %93 %25
               OpStore %8 %94
               OpBranch %64
         %64 = OpLabel
               OpBranch %61
         %63 = OpLabel
         %95 = OpLoad %6 %8
         %96 = OpAccessChain %17 %14 %15 %21
         %97 = OpLoad %6 %96
         %98 = OpIEqual %42 %95 %97
               OpSelectionMerge %100 None
               OpBranchConditional %98 %99 %116
         %99 = OpLabel
        %103 = OpAccessChain %17 %14 %15 %15
        %104 = OpLoad %6 %103
        %105 = OpConvertSToF %26 %104
        %106 = OpAccessChain %17 %14 %15 %16
        %107 = OpLoad %6 %106
        %108 = OpConvertSToF %26 %107
        %109 = OpAccessChain %17 %14 %15 %16
        %110 = OpLoad %6 %109
        %111 = OpConvertSToF %26 %110
        %112 = OpAccessChain %17 %14 %15 %15
        %113 = OpLoad %6 %112
        %114 = OpConvertSToF %26 %113
        %115 = OpCompositeConstruct %27 %105 %108 %111 %114
               OpStore %102 %115
               OpBranch %100
        %116 = OpLabel
        %117 = OpAccessChain %17 %14 %15 %16
        %118 = OpLoad %6 %117
        %119 = OpConvertSToF %26 %118
        %120 = OpCompositeConstruct %27 %119 %119 %119 %119
               OpStore %102 %120
               OpBranch %100
        %100 = OpLabel
               OpReturn
               OpFunctionEnd
