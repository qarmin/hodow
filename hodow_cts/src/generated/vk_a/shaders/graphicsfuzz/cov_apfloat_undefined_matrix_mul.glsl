#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 158
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %121
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "m0"
               OpName %15 "buf1"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %68 "m1"
               OpName %78 "undefined"
               OpName %84 "defined"
               OpName %94 "v0"
               OpName %98 "v1"
               OpName %102 "v2"
               OpName %106 "v3"
               OpName %121 "_GLF_color"
               OpName %150 "buf0"
               OpMemberName %150 0 "_GLF_uniform_float_values"
               OpName %152 ""
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 RelaxedPrecision
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 1
               OpDecorate %22 RelaxedPrecision
               OpDecorate %26 RelaxedPrecision
               OpDecorate %30 RelaxedPrecision
               OpDecorate %35 RelaxedPrecision
               OpDecorate %39 RelaxedPrecision
               OpDecorate %43 RelaxedPrecision
               OpDecorate %48 RelaxedPrecision
               OpDecorate %52 RelaxedPrecision
               OpDecorate %56 RelaxedPrecision
               OpDecorate %60 RelaxedPrecision
               OpDecorate %70 RelaxedPrecision
               OpDecorate %86 RelaxedPrecision
               OpDecorate %90 RelaxedPrecision
               OpDecorate %121 Location 0
               OpDecorate %123 RelaxedPrecision
               OpDecorate %127 RelaxedPrecision
               OpDecorate %130 RelaxedPrecision
               OpDecorate %133 RelaxedPrecision
               OpDecorate %138 RelaxedPrecision
               OpDecorate %149 ArrayStride 16
               OpMemberDecorate %150 0 Offset 0
               OpDecorate %150 Block
               OpDecorate %152 DescriptorSet 0
               OpDecorate %152 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypeMatrix %7 3
          %9 = OpTypePointer Function %8
         %11 = OpTypeInt 32 1
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 12
         %14 = OpTypeArray %11 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %11 0
         %19 = OpConstant %11 4
         %20 = OpTypePointer Uniform %11
         %24 = OpConstant %11 5
         %28 = OpConstant %11 6
         %32 = OpConstant %6 4
         %33 = OpConstant %11 10
         %37 = OpConstant %11 7
         %41 = OpConstant %11 8
         %45 = OpConstant %6 8
         %46 = OpConstant %11 11
         %50 = OpConstant %11 1
         %54 = OpConstant %11 2
         %58 = OpConstant %11 3
         %62 = OpConstant %6 1
         %63 = OpConstant %6 0
         %76 = OpTypeVector %6 3
         %77 = OpTypePointer Function %76
         %79 = OpConstantComposite %76 %62 %62 %62
         %80 = OpTypeVector %11 3
         %81 = OpConstant %11 500
         %82 = OpConstantComposite %80 %81 %81 %81
         %93 = OpTypePointer Function %7
        %110 = OpConstant %12 0
        %111 = OpTypePointer Function %6
        %116 = OpTypeBool
        %120 = OpTypePointer Output %7
        %121 = OpVariable %120 Output
        %125 = OpConstant %11 9
        %148 = OpConstant %12 1
        %149 = OpTypeArray %6 %148
        %150 = OpTypeStruct %149
        %151 = OpTypePointer Uniform %150
        %152 = OpVariable %151 Uniform
        %153 = OpTypePointer Uniform %6
        %156 = OpTypePointer Output %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %9 Function
         %68 = OpVariable %9 Function
         %78 = OpVariable %77 Function
         %84 = OpVariable %77 Function
         %94 = OpVariable %93 Function
         %98 = OpVariable %93 Function
        %102 = OpVariable %93 Function
        %106 = OpVariable %93 Function
         %21 = OpAccessChain %20 %17 %18 %19
         %22 = OpLoad %11 %21
         %23 = OpConvertSToF %6 %22
         %25 = OpAccessChain %20 %17 %18 %24
         %26 = OpLoad %11 %25
         %27 = OpConvertSToF %6 %26
         %29 = OpAccessChain %20 %17 %18 %28
         %30 = OpLoad %11 %29
         %31 = OpConvertSToF %6 %30
         %34 = OpAccessChain %20 %17 %18 %33
         %35 = OpLoad %11 %34
         %36 = OpConvertSToF %6 %35
         %38 = OpAccessChain %20 %17 %18 %37
         %39 = OpLoad %11 %38
         %40 = OpConvertSToF %6 %39
         %42 = OpAccessChain %20 %17 %18 %41
         %43 = OpLoad %11 %42
         %44 = OpConvertSToF %6 %43
         %47 = OpAccessChain %20 %17 %18 %46
         %48 = OpLoad %11 %47
         %49 = OpConvertSToF %6 %48
         %51 = OpAccessChain %20 %17 %18 %50
         %52 = OpLoad %11 %51
         %53 = OpConvertSToF %6 %52
         %55 = OpAccessChain %20 %17 %18 %54
         %56 = OpLoad %11 %55
         %57 = OpConvertSToF %6 %56
         %59 = OpAccessChain %20 %17 %18 %58
         %60 = OpLoad %11 %59
         %61 = OpConvertSToF %6 %60
         %64 = OpCompositeConstruct %7 %23 %27 %31 %32
         %65 = OpCompositeConstruct %7 %36 %40 %44 %45
         %66 = OpCompositeConstruct %7 %49 %53 %57 %61
         %67 = OpCompositeConstruct %8 %64 %65 %66
               OpStore %10 %67
         %69 = OpAccessChain %20 %17 %18 %19
         %70 = OpLoad %11 %69
         %71 = OpConvertSToF %6 %70
         %72 = OpCompositeConstruct %7 %71 %63 %63 %63
         %73 = OpCompositeConstruct %7 %63 %71 %63 %63
         %74 = OpCompositeConstruct %7 %63 %63 %71 %63
         %75 = OpCompositeConstruct %8 %72 %73 %74
               OpStore %68 %75
         %83 = OpExtInst %76 %1 Ldexp %79 %82
               OpStore %78 %83
         %85 = OpAccessChain %20 %17 %18 %19
         %86 = OpLoad %11 %85
         %87 = OpConvertSToF %6 %86
         %88 = OpCompositeConstruct %76 %87 %87 %87
         %89 = OpAccessChain %20 %17 %18 %18
         %90 = OpLoad %11 %89
         %91 = OpCompositeConstruct %80 %90 %90 %90
         %92 = OpExtInst %76 %1 Ldexp %88 %91
               OpStore %84 %92
         %95 = OpLoad %8 %10
         %96 = OpLoad %76 %78
         %97 = OpMatrixTimesVector %7 %95 %96
               OpStore %94 %97
         %99 = OpLoad %8 %68
        %100 = OpLoad %76 %78
        %101 = OpMatrixTimesVector %7 %99 %100
               OpStore %98 %101
        %103 = OpLoad %8 %10
        %104 = OpLoad %76 %84
        %105 = OpMatrixTimesVector %7 %103 %104
               OpStore %102 %105
        %107 = OpLoad %8 %68
        %108 = OpLoad %76 %84
        %109 = OpMatrixTimesVector %7 %107 %108
               OpStore %106 %109
        %112 = OpAccessChain %111 %102 %110
        %113 = OpLoad %6 %112
        %114 = OpAccessChain %111 %106 %110
        %115 = OpLoad %6 %114
        %117 = OpFOrdGreaterThan %116 %113 %115
               OpSelectionMerge %119 None
               OpBranchConditional %117 %118 %136
        %118 = OpLabel
        %122 = OpAccessChain %20 %17 %18 %19
        %123 = OpLoad %11 %122
        %124 = OpConvertSToF %6 %123
        %126 = OpAccessChain %20 %17 %18 %125
        %127 = OpLoad %11 %126
        %128 = OpConvertSToF %6 %127
        %129 = OpAccessChain %20 %17 %18 %125
        %130 = OpLoad %11 %129
        %131 = OpConvertSToF %6 %130
        %132 = OpAccessChain %20 %17 %18 %19
        %133 = OpLoad %11 %132
        %134 = OpConvertSToF %6 %133
        %135 = OpCompositeConstruct %7 %124 %128 %131 %134
               OpStore %121 %135
               OpBranch %119
        %136 = OpLabel
        %137 = OpAccessChain %20 %17 %18 %125
        %138 = OpLoad %11 %137
        %139 = OpConvertSToF %6 %138
        %140 = OpCompositeConstruct %7 %139 %139 %139 %139
               OpStore %121 %140
               OpBranch %119
        %119 = OpLabel
        %141 = OpAccessChain %111 %94 %110
        %142 = OpLoad %6 %141
        %143 = OpAccessChain %111 %98 %110
        %144 = OpLoad %6 %143
        %145 = OpFOrdLessThan %116 %142 %144
               OpSelectionMerge %147 None
               OpBranchConditional %145 %146 %147
        %146 = OpLabel
        %154 = OpAccessChain %153 %152 %18 %18
        %155 = OpLoad %6 %154
        %157 = OpAccessChain %156 %121 %148
               OpStore %157 %155
               OpBranch %147
        %147 = OpLabel
               OpReturn
               OpFunctionEnd
