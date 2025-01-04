#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 129
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %15 %125
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %12 "alwaysFalse"
               OpName %15 "gl_FragCoord"
               OpName %27 "value"
               OpName %30 "a"
               OpName %38 "buf0"
               OpMemberName %38 0 "injectionSwitch"
               OpName %40 ""
               OpName %62 "i"
               OpName %100 "count"
               OpName %101 "i"
               OpName %125 "_GLF_color"
               OpDecorate %15 BuiltIn FragCoord
               OpMemberDecorate %38 0 Offset 0
               OpDecorate %38 Block
               OpDecorate %40 DescriptorSet 0
               OpDecorate %40 Binding 0
               OpDecorate %125 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypeBool
         %11 = OpTypePointer Function %10
         %13 = OpTypeVector %6 4
         %14 = OpTypePointer Input %13
         %15 = OpVariable %14 Input
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 0
         %18 = OpTypePointer Input %6
         %21 = OpConstant %6 -1
         %26 = OpTypePointer Function %13
         %28 = OpTypeVector %6 2
         %29 = OpTypePointer Function %28
         %38 = OpTypeStruct %28
         %39 = OpTypePointer Uniform %38
         %40 = OpVariable %39 Uniform
         %41 = OpTypeInt 32 1
         %42 = OpConstant %41 0
         %43 = OpTypePointer Uniform %28
         %53 = OpConstant %6 2
         %54 = OpConstantComposite %28 %53 %53
         %61 = OpTypePointer Function %41
         %69 = OpConstant %16 1
         %70 = OpTypePointer Uniform %6
         %74 = OpConstant %41 1
         %79 = OpTypePointer Function %6
         %85 = OpConstant %6 1
         %97 = OpConstant %6 0
        %120 = OpConstant %41 2
        %124 = OpTypePointer Output %13
        %125 = OpVariable %124 Output
        %126 = OpConstantComposite %13 %85 %97 %97 %85
        %128 = OpConstantComposite %13 %97 %97 %97 %85
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %100 = OpVariable %61 Function
        %101 = OpVariable %61 Function
               OpStore %100 %42
               OpStore %101 %42
               OpBranch %102
        %102 = OpLabel
               OpLoopMerge %104 %105 None
               OpBranch %106
        %106 = OpLabel
        %107 = OpLoad %41 %101
        %108 = OpAccessChain %70 %40 %42 %69
        %109 = OpLoad %6 %108
        %110 = OpConvertFToS %41 %109
        %111 = OpIAdd %41 %110 %74
        %112 = OpSLessThan %10 %107 %111
               OpBranchConditional %112 %103 %104
        %103 = OpLabel
        %113 = OpFunctionCall %6 %8
        %114 = OpConvertFToS %41 %113
        %115 = OpLoad %41 %100
        %116 = OpIAdd %41 %115 %114
               OpStore %100 %116
               OpBranch %105
        %105 = OpLabel
        %117 = OpLoad %41 %101
        %118 = OpIAdd %41 %117 %74
               OpStore %101 %118
               OpBranch %102
        %104 = OpLabel
        %119 = OpLoad %41 %100
        %121 = OpIEqual %10 %119 %120
               OpSelectionMerge %123 None
               OpBranchConditional %121 %122 %127
        %122 = OpLabel
               OpStore %125 %126
               OpBranch %123
        %127 = OpLabel
               OpStore %125 %128
               OpBranch %123
        %123 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %12 = OpVariable %11 Function
         %27 = OpVariable %26 Function
         %30 = OpVariable %29 Function
         %62 = OpVariable %61 Function
         %19 = OpAccessChain %18 %15 %17
         %20 = OpLoad %6 %19
         %22 = OpFOrdLessThan %10 %20 %21
               OpStore %12 %22
         %23 = OpLoad %10 %12
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %25
         %24 = OpLabel
         %31 = OpLoad %28 %30
         %32 = OpLoad %13 %27
         %33 = OpVectorShuffle %13 %32 %31 4 5 2 3
               OpStore %27 %33
               OpBranch %25
         %25 = OpLabel
         %34 = OpLoad %10 %12
         %35 = OpLogicalNot %10 %34
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
         %44 = OpAccessChain %43 %40 %42
         %45 = OpLoad %28 %44
         %46 = OpLoad %13 %27
         %47 = OpVectorShuffle %13 %46 %45 4 5 2 3
               OpStore %27 %47
               OpBranch %37
         %37 = OpLabel
         %48 = OpLoad %13 %15
         %49 = OpVectorShuffle %28 %48 %48 0 1
         %50 = OpLoad %13 %27
         %51 = OpVectorShuffle %28 %50 %50 0 1
         %52 = OpFMul %28 %49 %51
         %55 = OpFMul %28 %52 %54
         %56 = OpLoad %13 %27
         %57 = OpVectorShuffle %28 %56 %56 0 1
         %58 = OpFAdd %28 %55 %57
         %59 = OpLoad %13 %27
         %60 = OpVectorShuffle %13 %59 %58 0 1 4 5
               OpStore %27 %60
               OpStore %62 %42
               OpBranch %63
         %63 = OpLabel
               OpLoopMerge %65 %66 None
               OpBranch %67
         %67 = OpLabel
         %68 = OpLoad %41 %62
         %71 = OpAccessChain %70 %40 %42 %69
         %72 = OpLoad %6 %71
         %73 = OpConvertFToS %41 %72
         %75 = OpIAdd %41 %73 %74
         %76 = OpSLessThan %10 %68 %75
               OpBranchConditional %76 %64 %65
         %64 = OpLabel
         %77 = OpLoad %41 %62
         %78 = OpConvertSToF %6 %77
         %80 = OpAccessChain %79 %27 %17
               OpStore %80 %78
               OpBranch %66
         %66 = OpLabel
         %81 = OpLoad %41 %62
         %82 = OpIAdd %41 %81 %74
               OpStore %62 %82
               OpBranch %63
         %65 = OpLabel
         %83 = OpAccessChain %79 %27 %17
         %84 = OpLoad %6 %83
         %86 = OpFOrdEqual %10 %84 %85
               OpSelectionMerge %88 None
               OpBranchConditional %86 %87 %88
         %87 = OpLabel
         %89 = OpAccessChain %79 %27 %69
         %90 = OpLoad %6 %89
         %91 = OpFOrdEqual %10 %90 %85
               OpBranch %88
         %88 = OpLabel
         %92 = OpPhi %10 %86 %65 %91 %87
               OpSelectionMerge %94 None
               OpBranchConditional %92 %93 %96
         %93 = OpLabel
               OpReturnValue %85
         %96 = OpLabel
               OpReturnValue %97
         %94 = OpLabel
               OpUnreachable
               OpFunctionEnd
