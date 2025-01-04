#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 136
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %71
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "S"
               OpMemberName %7 0 "a"
               OpMemberName %7 1 "b"
               OpMemberName %7 2 "c"
               OpName %13 "func(struct-S-i1-i1-i11;i1;"
               OpName %11 "s"
               OpName %12 "x"
               OpName %55 "arr"
               OpName %56 "buf0"
               OpMemberName %56 0 "one"
               OpName %58 ""
               OpName %71 "_GLF_color"
               OpName %79 "param"
               OpName %82 "param"
               OpMemberDecorate %56 0 Offset 0
               OpDecorate %56 Block
               OpDecorate %58 DescriptorSet 0
               OpDecorate %58 Binding 0
               OpDecorate %71 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6 %6 %6
          %8 = OpTypePointer Function %7
          %9 = OpTypePointer Function %6
         %10 = OpTypeFunction %6 %8 %9
         %15 = OpConstant %6 0
         %20 = OpConstant %6 2
         %21 = OpTypeBool
         %25 = OpConstant %6 9
         %27 = OpConstant %6 1
         %39 = OpConstant %6 7
         %51 = OpTypeInt 32 0
         %52 = OpConstant %51 2
         %53 = OpTypeArray %7 %52
         %54 = OpTypePointer Function %53
         %56 = OpTypeStruct %6
         %57 = OpTypePointer Uniform %56
         %58 = OpVariable %57 Uniform
         %59 = OpTypePointer Uniform %6
         %68 = OpTypeFloat 32
         %69 = OpTypeVector %68 4
         %70 = OpTypePointer Output %69
         %71 = OpVariable %70 Output
         %72 = OpConstant %68 0
         %73 = OpConstantComposite %69 %72 %72 %72 %72
         %84 = OpConstant %6 12
         %88 = OpConstant %68 1
         %89 = OpConstantComposite %69 %88 %72 %72 %88
         %95 = OpConstantFalse %21
         %96 = OpTypePointer Function %21
         %98 = OpConstantTrue %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %99 = OpVariable %9 Function
         %97 = OpVariable %96 Function %95
         %55 = OpVariable %54 Function
         %79 = OpVariable %8 Function
         %82 = OpVariable %9 Function
               OpBranch %92
         %92 = OpLabel
               OpLoopMerge %91 %94 None
               OpBranch %93
         %93 = OpLabel
         %60 = OpAccessChain %59 %58 %15
         %61 = OpLoad %6 %60
         %62 = OpAccessChain %9 %55 %61 %15
               OpStore %62 %20
         %63 = OpAccessChain %9 %55 %27 %15
         %64 = OpLoad %6 %63
         %65 = OpSLessThan %21 %64 %27
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %75
         %66 = OpLabel
               OpStore %71 %73
               OpStore %97 %98
               OpBranch %91
         %75 = OpLabel
         %78 = OpIAdd %6 %20 %61
         %80 = OpAccessChain %8 %55 %27
         %81 = OpLoad %7 %80
               OpStore %79 %81
               OpStore %82 %78
        %100 = OpLoad %6 %82
        %101 = OpAccessChain %9 %79 %15
        %121 = OpLoad %7 %79
        %122 = OpCompositeInsert %7 %100 %121 0
               OpStore %79 %122
        %123 = OpLoad %7 %79
        %102 = OpCompositeExtract %6 %123 0
        %103 = OpIEqual %21 %102 %20
               OpSelectionMerge %104 None
               OpBranchConditional %103 %105 %104
        %105 = OpLabel
        %124 = OpLoad %7 %79
        %125 = OpCompositeInsert %7 %25 %124 0
               OpStore %79 %125
               OpBranch %104
        %104 = OpLabel
        %106 = OpLoad %6 %82
        %107 = OpIAdd %6 %106 %27
        %108 = OpAccessChain %9 %79 %27
        %126 = OpLoad %7 %79
        %127 = OpCompositeInsert %7 %107 %126 1
               OpStore %79 %127
        %109 = OpLoad %6 %82
        %110 = OpIAdd %6 %109 %20
        %111 = OpAccessChain %9 %79 %20
        %128 = OpLoad %7 %79
        %129 = OpCompositeInsert %7 %110 %128 2
               OpStore %79 %129
        %130 = OpLoad %7 %79
        %112 = OpCompositeExtract %6 %130 1
        %113 = OpIEqual %21 %112 %20
               OpSelectionMerge %114 None
               OpBranchConditional %113 %115 %114
        %115 = OpLabel
        %131 = OpLoad %7 %79
        %132 = OpCompositeInsert %7 %39 %131 1
               OpStore %79 %132
               OpBranch %114
        %114 = OpLabel
        %133 = OpLoad %7 %79
        %116 = OpCompositeExtract %6 %133 0
        %134 = OpLoad %7 %79
        %117 = OpCompositeExtract %6 %134 1
        %118 = OpIAdd %6 %116 %117
        %135 = OpLoad %7 %79
        %119 = OpCompositeExtract %6 %135 2
        %120 = OpIAdd %6 %118 %119
               OpStore %99 %120
         %83 = OpLoad %6 %99
         %85 = OpIEqual %21 %83 %84
               OpSelectionMerge %87 None
               OpBranchConditional %85 %86 %90
         %86 = OpLabel
               OpStore %71 %89
               OpBranch %87
         %90 = OpLabel
               OpStore %71 %73
               OpBranch %87
         %87 = OpLabel
               OpBranch %67
         %67 = OpLabel
               OpStore %97 %98
               OpBranch %91
         %94 = OpLabel
               OpBranch %92
         %91 = OpLabel
               OpReturn
               OpFunctionEnd
         %13 = OpFunction %6 None %10
         %11 = OpFunctionParameter %8
         %12 = OpFunctionParameter %9
         %14 = OpLabel
         %16 = OpLoad %6 %12
         %17 = OpAccessChain %9 %11 %15
               OpStore %17 %16
         %19 = OpLoad %6 %17
         %22 = OpIEqual %21 %19 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
               OpStore %17 %25
               OpBranch %24
         %24 = OpLabel
         %28 = OpLoad %6 %12
         %29 = OpIAdd %6 %28 %27
         %30 = OpAccessChain %9 %11 %27
               OpStore %30 %29
         %31 = OpLoad %6 %12
         %32 = OpIAdd %6 %31 %20
         %33 = OpAccessChain %9 %11 %20
               OpStore %33 %32
         %35 = OpLoad %6 %30
         %36 = OpIEqual %21 %35 %20
               OpSelectionMerge %38 None
               OpBranchConditional %36 %37 %38
         %37 = OpLabel
               OpStore %30 %39
               OpBranch %38
         %38 = OpLabel
         %42 = OpLoad %6 %17
         %44 = OpLoad %6 %30
         %45 = OpIAdd %6 %42 %44
         %47 = OpLoad %6 %33
         %48 = OpIAdd %6 %45 %47
               OpReturnValue %48
               OpFunctionEnd
