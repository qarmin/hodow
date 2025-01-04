#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 120
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "m43"
               OpName %20 "ll1"
               OpName %22 "rows"
               OpName %33 "_GLF_color"
               OpName %44 "ll4"
               OpName %46 "ll2"
               OpName %47 "c"
               OpName %62 "tempm43"
               OpName %64 "ll3"
               OpName %65 "d"
               OpName %81 "r"
               OpName %98 "sums"
               OpName %99 "idx"
               OpDecorate %20 RelaxedPrecision
               OpDecorate %22 RelaxedPrecision
               OpDecorate %33 Location 0
               OpDecorate %35 RelaxedPrecision
               OpDecorate %41 RelaxedPrecision
               OpDecorate %43 RelaxedPrecision
               OpDecorate %44 RelaxedPrecision
               OpDecorate %46 RelaxedPrecision
               OpDecorate %47 RelaxedPrecision
               OpDecorate %53 RelaxedPrecision
               OpDecorate %55 RelaxedPrecision
               OpDecorate %60 RelaxedPrecision
               OpDecorate %61 RelaxedPrecision
               OpDecorate %64 RelaxedPrecision
               OpDecorate %65 RelaxedPrecision
               OpDecorate %71 RelaxedPrecision
               OpDecorate %73 RelaxedPrecision
               OpDecorate %75 RelaxedPrecision
               OpDecorate %79 RelaxedPrecision
               OpDecorate %81 RelaxedPrecision
               OpDecorate %82 RelaxedPrecision
               OpDecorate %84 RelaxedPrecision
               OpDecorate %88 RelaxedPrecision
               OpDecorate %92 RelaxedPrecision
               OpDecorate %93 RelaxedPrecision
               OpDecorate %99 RelaxedPrecision
               OpDecorate %100 RelaxedPrecision
               OpDecorate %102 RelaxedPrecision
               OpDecorate %106 RelaxedPrecision
               OpDecorate %108 RelaxedPrecision
               OpDecorate %116 RelaxedPrecision
               OpDecorate %117 RelaxedPrecision
               OpDecorate %118 RelaxedPrecision
               OpDecorate %119 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeMatrix %7 4
          %9 = OpTypePointer Function %8
         %11 = OpConstant %6 1
         %12 = OpConstant %6 0
         %13 = OpConstantComposite %7 %11 %12 %12
         %14 = OpConstantComposite %7 %12 %11 %12
         %15 = OpConstantComposite %7 %12 %12 %11
         %16 = OpConstantComposite %7 %12 %12 %12
         %17 = OpConstantComposite %8 %13 %14 %15 %16
         %18 = OpTypeInt 32 1
         %19 = OpTypePointer Function %18
         %21 = OpConstant %18 0
         %23 = OpConstant %18 2
         %29 = OpTypeBool
         %30 = OpConstantTrue %29
         %31 = OpTypeVector %6 4
         %32 = OpTypePointer Output %31
         %33 = OpVariable %32 Output
         %34 = OpConstantComposite %31 %11 %12 %12 %11
         %36 = OpConstant %18 5
         %42 = OpConstant %18 1
         %45 = OpConstant %18 10
         %76 = OpConstant %18 4
         %85 = OpConstant %18 3
         %90 = OpTypePointer Function %6
         %94 = OpTypeInt 32 0
         %95 = OpConstant %94 9
         %96 = OpTypeArray %6 %95
         %97 = OpTypePointer Function %96
        %103 = OpConstant %18 9
        %109 = OpConstant %94 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %9 Function
         %20 = OpVariable %19 Function
         %22 = OpVariable %19 Function
         %44 = OpVariable %19 Function
         %46 = OpVariable %19 Function
         %47 = OpVariable %19 Function
         %62 = OpVariable %9 Function
         %64 = OpVariable %19 Function
         %65 = OpVariable %19 Function
         %81 = OpVariable %19 Function
         %98 = OpVariable %97 Function
         %99 = OpVariable %19 Function
               OpStore %10 %17
               OpStore %20 %21
               OpStore %22 %23
               OpBranch %24
         %24 = OpLabel
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
               OpBranchConditional %30 %25 %26
         %25 = OpLabel
               OpStore %33 %34
         %35 = OpLoad %18 %20
         %37 = OpSGreaterThanEqual %29 %35 %36
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpBranch %26
         %39 = OpLabel
         %41 = OpLoad %18 %20
         %43 = OpIAdd %18 %41 %42
               OpStore %20 %43
               OpStore %44 %45
               OpStore %46 %21
               OpStore %47 %21
               OpBranch %48
         %48 = OpLabel
               OpLoopMerge %50 %51 None
               OpBranch %52
         %52 = OpLabel
         %53 = OpLoad %18 %47
         %54 = OpSLessThan %29 %53 %42
               OpBranchConditional %54 %49 %50
         %49 = OpLabel
         %55 = OpLoad %18 %46
         %56 = OpSGreaterThanEqual %29 %55 %21
               OpSelectionMerge %58 None
               OpBranchConditional %56 %57 %58
         %57 = OpLabel
               OpBranch %50
         %58 = OpLabel
         %60 = OpLoad %18 %46
         %61 = OpIAdd %18 %60 %42
               OpStore %46 %61
         %63 = OpLoad %8 %10
               OpStore %62 %63
               OpStore %64 %21
               OpStore %65 %21
               OpBranch %66
         %66 = OpLabel
               OpLoopMerge %68 %69 None
               OpBranch %70
         %70 = OpLabel
         %71 = OpLoad %18 %44
         %72 = OpSLessThan %29 %42 %71
               OpBranchConditional %72 %67 %68
         %67 = OpLabel
         %73 = OpLoad %18 %65
         %74 = OpSGreaterThanEqual %29 %73 %21
         %75 = OpLoad %18 %65
         %77 = OpSLessThan %29 %75 %76
         %78 = OpLogicalAnd %29 %74 %77
         %79 = OpLoad %18 %65
         %80 = OpSelect %18 %78 %79 %21
         %82 = OpLoad %18 %81
         %83 = OpSGreaterThanEqual %29 %82 %21
         %84 = OpLoad %18 %81
         %86 = OpSLessThan %29 %84 %85
         %87 = OpLogicalAnd %29 %83 %86
         %88 = OpLoad %18 %81
         %89 = OpSelect %18 %87 %88 %21
         %91 = OpAccessChain %90 %62 %80 %89
               OpStore %91 %11
               OpBranch %69
         %69 = OpLabel
         %92 = OpLoad %18 %65
         %93 = OpIAdd %18 %92 %42
               OpStore %65 %93
               OpBranch %66
         %68 = OpLabel
        %100 = OpLoad %18 %99
        %101 = OpSGreaterThanEqual %29 %100 %21
        %102 = OpLoad %18 %99
        %104 = OpSLessThan %29 %102 %103
        %105 = OpLogicalAnd %29 %101 %104
        %106 = OpLoad %18 %99
        %107 = OpSelect %18 %105 %106 %21
        %108 = OpLoad %18 %47
        %110 = OpAccessChain %90 %10 %108 %109
        %111 = OpLoad %6 %110
        %112 = OpAccessChain %90 %98 %107
        %113 = OpLoad %6 %112
        %114 = OpFAdd %6 %113 %111
        %115 = OpAccessChain %90 %98 %107
               OpStore %115 %114
               OpBranch %51
         %51 = OpLabel
        %116 = OpLoad %18 %47
        %117 = OpIAdd %18 %116 %42
               OpStore %47 %117
               OpBranch %48
         %50 = OpLabel
        %118 = OpLoad %18 %99
        %119 = OpIAdd %18 %118 %42
               OpStore %99 %119
               OpBranch %27
         %27 = OpLabel
               OpBranch %24
         %26 = OpLabel
               OpReturn
               OpFunctionEnd
