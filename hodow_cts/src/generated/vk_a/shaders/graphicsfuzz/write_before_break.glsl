#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 126
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %42
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "idx"
               OpName %14 "m43"
               OpName %22 "ll_1"
               OpName %23 "GLF_live6rows"
               OpName %30 "buf0"
               OpMemberName %30 0 "injected"
               OpName %32 ""
               OpName %42 "_GLF_color"
               OpName %48 "z"
               OpName %51 "ll_2"
               OpName %52 "ctr"
               OpName %69 "tempm43"
               OpName %71 "ll_3"
               OpName %72 "c"
               OpName %80 "d"
               OpName %105 "GLF_live6sums"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %22 RelaxedPrecision
               OpDecorate %23 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpMemberDecorate %30 0 RelaxedPrecision
               OpMemberDecorate %30 0 Offset 0
               OpDecorate %30 Block
               OpDecorate %32 DescriptorSet 0
               OpDecorate %32 Binding 0
               OpDecorate %35 RelaxedPrecision
               OpDecorate %42 Location 0
               OpDecorate %45 RelaxedPrecision
               OpDecorate %47 RelaxedPrecision
               OpDecorate %48 RelaxedPrecision
               OpDecorate %50 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %52 RelaxedPrecision
               OpDecorate %58 RelaxedPrecision
               OpDecorate %60 RelaxedPrecision
               OpDecorate %62 RelaxedPrecision
               OpDecorate %67 RelaxedPrecision
               OpDecorate %68 RelaxedPrecision
               OpDecorate %71 RelaxedPrecision
               OpDecorate %72 RelaxedPrecision
               OpDecorate %78 RelaxedPrecision
               OpDecorate %80 RelaxedPrecision
               OpDecorate %81 RelaxedPrecision
               OpDecorate %83 RelaxedPrecision
               OpDecorate %87 RelaxedPrecision
               OpDecorate %89 RelaxedPrecision
               OpDecorate %91 RelaxedPrecision
               OpDecorate %95 RelaxedPrecision
               OpDecorate %99 RelaxedPrecision
               OpDecorate %100 RelaxedPrecision
               OpDecorate %106 RelaxedPrecision
               OpDecorate %108 RelaxedPrecision
               OpDecorate %112 RelaxedPrecision
               OpDecorate %114 RelaxedPrecision
               OpDecorate %122 RelaxedPrecision
               OpDecorate %123 RelaxedPrecision
               OpDecorate %124 RelaxedPrecision
               OpDecorate %125 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 3
         %12 = OpTypeMatrix %11 4
         %13 = OpTypePointer Function %12
         %15 = OpConstant %10 1
         %16 = OpConstant %10 0
         %17 = OpConstantComposite %11 %15 %16 %16
         %18 = OpConstantComposite %11 %16 %15 %16
         %19 = OpConstantComposite %11 %16 %16 %15
         %20 = OpConstantComposite %11 %16 %16 %16
         %21 = OpConstantComposite %12 %17 %18 %19 %20
         %24 = OpConstant %6 2
         %30 = OpTypeStruct %6
         %31 = OpTypePointer Uniform %30
         %32 = OpVariable %31 Uniform
         %33 = OpTypePointer Uniform %6
         %36 = OpTypeBool
         %40 = OpTypeVector %10 4
         %41 = OpTypePointer Output %40
         %42 = OpVariable %41 Output
         %43 = OpConstantComposite %40 %15 %16 %16 %15
         %46 = OpConstant %6 1
         %84 = OpConstant %6 4
         %92 = OpConstant %6 3
         %97 = OpTypePointer Function %10
        %101 = OpTypeInt 32 0
        %102 = OpConstant %101 9
        %103 = OpTypeArray %10 %102
        %104 = OpTypePointer Function %103
        %109 = OpConstant %6 9
        %115 = OpConstant %101 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %14 = OpVariable %13 Function
         %22 = OpVariable %7 Function
         %23 = OpVariable %7 Function
         %48 = OpVariable %7 Function
         %51 = OpVariable %7 Function
         %52 = OpVariable %7 Function
         %69 = OpVariable %13 Function
         %71 = OpVariable %7 Function
         %72 = OpVariable %7 Function
         %80 = OpVariable %7 Function
        %105 = OpVariable %104 Function
               OpStore %8 %9
               OpStore %14 %21
               OpStore %22 %9
               OpStore %23 %24
               OpBranch %25
         %25 = OpLabel
               OpLoopMerge %27 %28 None
               OpBranch %26
         %26 = OpLabel
         %29 = OpLoad %6 %22
         %34 = OpAccessChain %33 %32 %9
         %35 = OpLoad %6 %34
         %37 = OpSGreaterThanEqual %36 %29 %35
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpStore %42 %43
               OpBranch %27
         %39 = OpLabel
         %45 = OpLoad %6 %22
         %47 = OpIAdd %6 %45 %46
               OpStore %22 %47
         %49 = OpAccessChain %33 %32 %9
         %50 = OpLoad %6 %49
               OpStore %48 %50
               OpStore %51 %9
               OpStore %52 %9
               OpBranch %53
         %53 = OpLabel
               OpLoopMerge %55 %56 None
               OpBranch %57
         %57 = OpLabel
         %58 = OpLoad %6 %52
         %59 = OpSLessThan %36 %58 %46
               OpBranchConditional %59 %54 %55
         %54 = OpLabel
         %60 = OpLoad %6 %51
         %61 = OpAccessChain %33 %32 %9
         %62 = OpLoad %6 %61
         %63 = OpSGreaterThanEqual %36 %60 %62
               OpSelectionMerge %65 None
               OpBranchConditional %63 %64 %65
         %64 = OpLabel
               OpBranch %55
         %65 = OpLabel
         %67 = OpLoad %6 %51
         %68 = OpIAdd %6 %67 %46
               OpStore %51 %68
         %70 = OpLoad %12 %14
               OpStore %69 %70
               OpStore %71 %9
               OpStore %72 %9
               OpBranch %73
         %73 = OpLabel
               OpLoopMerge %75 %76 None
               OpBranch %77
         %77 = OpLabel
         %78 = OpLoad %6 %48
         %79 = OpSLessThan %36 %46 %78
               OpBranchConditional %79 %74 %75
         %74 = OpLabel
               OpStore %80 %9
         %81 = OpLoad %6 %72
         %82 = OpSGreaterThanEqual %36 %81 %9
         %83 = OpLoad %6 %72
         %85 = OpSLessThan %36 %83 %84
         %86 = OpLogicalAnd %36 %82 %85
         %87 = OpLoad %6 %72
         %88 = OpSelect %6 %86 %87 %9
         %89 = OpLoad %6 %80
         %90 = OpSGreaterThanEqual %36 %89 %9
         %91 = OpLoad %6 %80
         %93 = OpSLessThan %36 %91 %92
         %94 = OpLogicalAnd %36 %90 %93
         %95 = OpLoad %6 %80
         %96 = OpSelect %6 %94 %95 %9
         %98 = OpAccessChain %97 %69 %88 %96
               OpStore %98 %15
               OpBranch %76
         %76 = OpLabel
         %99 = OpLoad %6 %72
        %100 = OpIAdd %6 %99 %46
               OpStore %72 %100
               OpBranch %73
         %75 = OpLabel
        %106 = OpLoad %6 %8
        %107 = OpSGreaterThanEqual %36 %106 %9
        %108 = OpLoad %6 %8
        %110 = OpSLessThan %36 %108 %109
        %111 = OpLogicalAnd %36 %107 %110
        %112 = OpLoad %6 %8
        %113 = OpSelect %6 %111 %112 %9
        %114 = OpLoad %6 %52
        %116 = OpAccessChain %97 %14 %114 %115
        %117 = OpLoad %10 %116
        %118 = OpAccessChain %97 %105 %113
        %119 = OpLoad %10 %118
        %120 = OpFAdd %10 %119 %117
        %121 = OpAccessChain %97 %105 %113
               OpStore %121 %120
               OpBranch %56
         %56 = OpLabel
        %122 = OpLoad %6 %52
        %123 = OpIAdd %6 %122 %46
               OpStore %52 %123
               OpBranch %53
         %55 = OpLabel
        %124 = OpLoad %6 %8
        %125 = OpIAdd %6 %124 %46
               OpStore %8 %125
               OpBranch %28
         %28 = OpLabel
               OpBranch %25
         %27 = OpLabel
               OpReturn
               OpFunctionEnd
