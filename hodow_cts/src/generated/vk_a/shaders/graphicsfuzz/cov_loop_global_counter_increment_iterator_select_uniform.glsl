#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 140
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %121
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %14 "arr"
               OpName %17 "buf0"
               OpMemberName %17 0 "_GLF_uniform_int_values"
               OpName %19 ""
               OpName %43 "i"
               OpName %62 "buf2"
               OpMemberName %62 0 "two"
               OpName %64 ""
               OpName %88 "buf1"
               OpMemberName %88 0 "zero"
               OpName %90 ""
               OpName %121 "_GLF_color"
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpMemberDecorate %62 0 Offset 0
               OpDecorate %62 Block
               OpDecorate %64 DescriptorSet 0
               OpDecorate %64 Binding 2
               OpMemberDecorate %88 0 Offset 0
               OpDecorate %88 Block
               OpDecorate %90 DescriptorSet 0
               OpDecorate %90 Binding 1
               OpDecorate %121 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 10
         %12 = OpTypeArray %6 %11
         %13 = OpTypePointer Function %12
         %15 = OpConstant %10 4
         %16 = OpTypeArray %6 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypePointer Uniform %6
         %42 = OpTypePointer Function %6
         %50 = OpConstant %6 2
         %53 = OpTypeBool
         %56 = OpConstant %6 10
         %60 = OpConstant %6 1
         %62 = OpTypeStruct %6
         %63 = OpTypePointer Uniform %62
         %64 = OpVariable %63 Uniform
         %74 = OpConstant %6 4
         %81 = OpConstant %6 3
         %88 = OpTypeStruct %6
         %89 = OpTypePointer Uniform %88
         %90 = OpVariable %89 Uniform
        %118 = OpTypeFloat 32
        %119 = OpTypeVector %118 4
        %120 = OpTypePointer Output %119
        %121 = OpVariable %120 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpVariable %13 Function
         %43 = OpVariable %42 Function
         %96 = OpVariable %42 Function
               OpStore %8 %9
         %21 = OpAccessChain %20 %19 %9 %9
         %22 = OpLoad %6 %21
         %23 = OpAccessChain %20 %19 %9 %9
         %24 = OpLoad %6 %23
         %25 = OpAccessChain %20 %19 %9 %9
         %26 = OpLoad %6 %25
         %27 = OpAccessChain %20 %19 %9 %9
         %28 = OpLoad %6 %27
         %29 = OpAccessChain %20 %19 %9 %9
         %30 = OpLoad %6 %29
         %31 = OpAccessChain %20 %19 %9 %9
         %32 = OpLoad %6 %31
         %33 = OpAccessChain %20 %19 %9 %9
         %34 = OpLoad %6 %33
         %35 = OpAccessChain %20 %19 %9 %9
         %36 = OpLoad %6 %35
         %37 = OpAccessChain %20 %19 %9 %9
         %38 = OpLoad %6 %37
         %39 = OpAccessChain %20 %19 %9 %9
         %40 = OpLoad %6 %39
         %41 = OpCompositeConstruct %12 %22 %24 %26 %28 %30 %32 %34 %36 %38 %40
               OpStore %14 %41
               OpStore %43 %9
               OpBranch %44
         %44 = OpLabel
               OpLoopMerge %46 %47 None
               OpBranch %48
         %48 = OpLabel
         %49 = OpLoad %6 %43
         %51 = OpAccessChain %20 %19 %9 %50
         %52 = OpLoad %6 %51
         %54 = OpSLessThan %53 %49 %52
         %55 = OpLoad %6 %8
         %57 = OpSLessThan %53 %55 %56
         %58 = OpLogicalAnd %53 %54 %57
               OpBranchConditional %58 %45 %46
         %45 = OpLabel
         %59 = OpLoad %6 %8
         %61 = OpIAdd %6 %59 %60
               OpStore %8 %61
         %65 = OpAccessChain %20 %64 %9
         %66 = OpLoad %6 %65
         %67 = OpAccessChain %20 %19 %9 %60
         %68 = OpLoad %6 %67
         %69 = OpSLessThanEqual %53 %66 %68
               OpSelectionMerge %71 None
               OpBranchConditional %69 %70 %71
         %70 = OpLabel
               OpBranch %46
         %71 = OpLabel
         %73 = OpLoad %6 %43
         %75 = OpSDiv %6 %73 %74
         %76 = OpLoad %6 %43
         %77 = OpIEqual %53 %75 %76
               OpSelectionMerge %79 None
               OpBranchConditional %77 %78 %79
         %78 = OpLabel
         %80 = OpLoad %6 %43
         %82 = OpAccessChain %20 %19 %9 %81
         %83 = OpLoad %6 %82
         %84 = OpSDiv %6 %80 %83
         %85 = OpAccessChain %20 %19 %9 %60
         %86 = OpLoad %6 %85
         %87 = OpAccessChain %42 %14 %84
               OpStore %87 %86
               OpBranch %79
         %79 = OpLabel
               OpBranch %47
         %47 = OpLabel
         %91 = OpAccessChain %20 %90 %9
         %92 = OpLoad %6 %91
         %93 = OpAccessChain %20 %19 %9 %60
         %94 = OpLoad %6 %93
         %95 = OpSLessThan %53 %92 %94
               OpSelectionMerge %98 None
               OpBranchConditional %95 %97 %101
         %97 = OpLabel
         %99 = OpLoad %6 %43
        %100 = OpIAdd %6 %99 %60
               OpStore %43 %100
               OpStore %96 %99
               OpBranch %98
        %101 = OpLabel
        %102 = OpAccessChain %20 %19 %9 %60
        %103 = OpLoad %6 %102
               OpStore %96 %103
               OpBranch %98
         %98 = OpLabel
               OpBranch %44
         %46 = OpLabel
        %104 = OpAccessChain %20 %19 %9 %60
        %105 = OpLoad %6 %104
        %106 = OpAccessChain %42 %14 %105
        %107 = OpLoad %6 %106
        %108 = OpIAdd %6 %107 %60
               OpStore %106 %108
        %109 = OpAccessChain %20 %19 %9 %9
        %110 = OpLoad %6 %109
        %111 = OpAccessChain %42 %14 %110
        %112 = OpLoad %6 %111
        %113 = OpAccessChain %20 %19 %9 %60
        %114 = OpLoad %6 %113
        %115 = OpIEqual %53 %112 %114
               OpSelectionMerge %117 None
               OpBranchConditional %115 %116 %135
        %116 = OpLabel
        %122 = OpAccessChain %20 %19 %9 %60
        %123 = OpLoad %6 %122
        %124 = OpConvertSToF %118 %123
        %125 = OpAccessChain %20 %19 %9 %9
        %126 = OpLoad %6 %125
        %127 = OpConvertSToF %118 %126
        %128 = OpAccessChain %20 %19 %9 %9
        %129 = OpLoad %6 %128
        %130 = OpConvertSToF %118 %129
        %131 = OpAccessChain %20 %19 %9 %60
        %132 = OpLoad %6 %131
        %133 = OpConvertSToF %118 %132
        %134 = OpCompositeConstruct %119 %124 %127 %130 %133
               OpStore %121 %134
               OpBranch %117
        %135 = OpLabel
        %136 = OpAccessChain %20 %19 %9 %9
        %137 = OpLoad %6 %136
        %138 = OpConvertSToF %118 %137
        %139 = OpCompositeConstruct %119 %138 %138 %138 %138
               OpStore %121 %139
               OpBranch %117
        %117 = OpLabel
               OpReturn
               OpFunctionEnd
