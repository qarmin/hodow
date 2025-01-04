#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 137
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %39 %68
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %12 "alwaysZero(vf2;"
               OpName %11 "coord"
               OpName %15 "a"
               OpName %26 "buf0"
               OpMemberName %26 0 "injectionSwitch"
               OpName %28 ""
               OpName %36 "b"
               OpName %39 "gl_FragCoord"
               OpName %57 "zero"
               OpName %58 "param"
               OpName %68 "_GLF_color"
               OpName %95 "temp"
               OpMemberDecorate %26 0 Offset 0
               OpDecorate %26 Block
               OpDecorate %28 DescriptorSet 0
               OpDecorate %28 Binding 0
               OpDecorate %39 BuiltIn FragCoord
               OpDecorate %68 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
          %9 = OpTypeInt 32 1
         %10 = OpTypeFunction %9 %8
         %14 = OpTypePointer Function %6
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 1
         %20 = OpConstant %6 50
         %21 = OpTypeBool
         %26 = OpTypeStruct %7
         %27 = OpTypePointer Uniform %26
         %28 = OpVariable %27 Uniform
         %29 = OpConstant %9 0
         %30 = OpTypePointer Uniform %6
         %34 = OpConstant %6 0
         %37 = OpTypeVector %6 4
         %38 = OpTypePointer Input %37
         %39 = OpVariable %38 Input
         %40 = OpTypePointer Input %6
         %44 = OpConstant %6 1
         %53 = OpConstant %9 1
         %56 = OpTypePointer Function %9
         %67 = OpTypePointer Output %37
         %68 = OpVariable %67 Output
         %69 = OpConstantComposite %37 %34 %44 %44 %44
         %70 = OpConstant %16 0
         %85 = OpTypePointer Output %6
        %108 = OpConstant %16 2
        %136 = OpConstantFalse %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %111 = OpVariable %14 Function
        %112 = OpVariable %14 Function
        %113 = OpVariable %14 Function
        %114 = OpVariable %56 Function
         %57 = OpVariable %56 Function
         %58 = OpVariable %8 Function
         %95 = OpVariable %8 Function
         %59 = OpLoad %37 %39
         %60 = OpVectorShuffle %7 %59 %59 0 1
               OpStore %58 %60
               OpBranch %115
        %115 = OpLabel
               OpLoopMerge %116 %117 None
               OpBranch %118
        %118 = OpLabel
        %119 = OpAccessChain %14 %58 %17
        %120 = OpLoad %6 %119
        %121 = OpFOrdLessThan %21 %120 %20
               OpSelectionMerge %122 None
               OpBranchConditional %121 %123 %124
        %123 = OpLabel
        %125 = OpAccessChain %30 %28 %29 %17
        %126 = OpLoad %6 %125
               OpStore %112 %126
               OpBranch %122
        %124 = OpLabel
               OpStore %112 %34
               OpBranch %122
        %122 = OpLabel
        %127 = OpLoad %6 %112
               OpStore %111 %127
        %128 = OpAccessChain %40 %39 %17
        %129 = OpLoad %6 %128
        %130 = OpFOrdLessThan %21 %129 %20
        %131 = OpSelect %6 %130 %44 %34
               OpStore %113 %131
        %132 = OpFSub %6 %127 %131
        %133 = OpFOrdLessThan %21 %132 %44
               OpSelectionMerge %134 None
               OpBranchConditional %133 %135 %134
        %135 = OpLabel
               OpStore %114 %29
               OpBranch %116
        %134 = OpLabel
               OpStore %114 %53
               OpBranch %116
        %117 = OpLabel
               OpBranchConditional %136 %115 %116
        %116 = OpLabel
         %61 = OpLoad %9 %114
               OpStore %57 %61
         %63 = OpIEqual %21 %61 %53
               OpSelectionMerge %65 None
               OpBranchConditional %63 %64 %65
         %64 = OpLabel
               OpReturn
         %65 = OpLabel
               OpStore %68 %69
         %71 = OpAccessChain %40 %39 %70
         %72 = OpLoad %6 %71
         %73 = OpAccessChain %30 %28 %29 %70
         %74 = OpLoad %6 %73
         %75 = OpFOrdGreaterThanEqual %21 %72 %74
               OpSelectionMerge %77 None
               OpBranchConditional %75 %76 %77
         %76 = OpLabel
         %78 = OpAccessChain %40 %39 %17
         %79 = OpLoad %6 %78
         %80 = OpFOrdGreaterThanEqual %21 %79 %34
               OpSelectionMerge %82 None
               OpBranchConditional %80 %81 %82
         %81 = OpLabel
         %83 = OpAccessChain %30 %28 %29 %17
         %84 = OpLoad %6 %83
         %86 = OpAccessChain %85 %68 %70
               OpStore %86 %84
               OpBranch %82
         %82 = OpLabel
               OpBranch %77
         %77 = OpLabel
         %87 = OpAccessChain %40 %39 %17
         %88 = OpLoad %6 %87
         %89 = OpFOrdGreaterThanEqual %21 %88 %34
               OpSelectionMerge %91 None
               OpBranchConditional %89 %90 %91
         %90 = OpLabel
         %92 = OpAccessChain %30 %28 %29 %70
         %93 = OpLoad %6 %92
         %94 = OpAccessChain %85 %68 %17
               OpStore %94 %93
               OpBranch %91
         %91 = OpLabel
         %96 = OpLoad %37 %39
         %97 = OpVectorShuffle %7 %96 %96 0 1
         %98 = OpCompositeExtract %6 %97 0
         %99 = OpCompositeExtract %6 %97 1
        %100 = OpCompositeConstruct %7 %98 %99
               OpStore %95 %100
        %102 = OpCompositeExtract %6 %100 1
        %103 = OpFOrdGreaterThanEqual %21 %102 %34
               OpSelectionMerge %105 None
               OpBranchConditional %103 %104 %105
        %104 = OpLabel
        %106 = OpAccessChain %30 %28 %29 %70
        %107 = OpLoad %6 %106
        %109 = OpAccessChain %85 %68 %108
               OpStore %109 %107
               OpBranch %105
        %105 = OpLabel
               OpReturn
               OpFunctionEnd
         %12 = OpFunction %9 None %10
         %11 = OpFunctionParameter %8
         %13 = OpLabel
         %15 = OpVariable %14 Function
         %23 = OpVariable %14 Function
         %36 = OpVariable %14 Function
         %18 = OpAccessChain %14 %11 %17
         %19 = OpLoad %6 %18
         %22 = OpFOrdLessThan %21 %19 %20
               OpSelectionMerge %25 None
               OpBranchConditional %22 %24 %33
         %24 = OpLabel
         %31 = OpAccessChain %30 %28 %29 %17
         %32 = OpLoad %6 %31
               OpStore %23 %32
               OpBranch %25
         %33 = OpLabel
               OpStore %23 %34
               OpBranch %25
         %25 = OpLabel
         %35 = OpLoad %6 %23
               OpStore %15 %35
         %41 = OpAccessChain %40 %39 %17
         %42 = OpLoad %6 %41
         %43 = OpFOrdLessThan %21 %42 %20
         %45 = OpSelect %6 %43 %44 %34
               OpStore %36 %45
         %48 = OpFSub %6 %35 %45
         %49 = OpFOrdLessThan %21 %48 %44
               OpSelectionMerge %51 None
               OpBranchConditional %49 %50 %51
         %50 = OpLabel
               OpReturnValue %29
         %51 = OpLabel
               OpReturnValue %53
               OpFunctionEnd
