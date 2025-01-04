#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 146
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %127
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "A"
               OpName %14 "buf1"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %32 "i"
               OpName %47 "a"
               OpName %50 "buf0"
               OpMemberName %50 0 "_GLF_uniform_float_values"
               OpName %52 ""
               OpName %65 "v1"
               OpName %88 "v2"
               OpName %103 "b"
               OpName %127 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 1
               OpDecorate %49 ArrayStride 16
               OpMemberDecorate %50 0 Offset 0
               OpDecorate %50 Block
               OpDecorate %52 DescriptorSet 0
               OpDecorate %52 Binding 0
               OpDecorate %127 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpConstant %7 3
         %13 = OpTypeArray %6 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %6 0
         %18 = OpConstant %6 2
         %19 = OpTypePointer Uniform %6
         %24 = OpTypePointer Function %6
         %28 = OpConstant %6 1
         %43 = OpTypeBool
         %48 = OpTypeFloat 32
         %49 = OpTypeArray %48 %8
         %50 = OpTypeStruct %49
         %51 = OpTypePointer Uniform %50
         %52 = OpVariable %51 Uniform
         %53 = OpTypePointer Uniform %48
         %63 = OpTypeVector %48 2
         %64 = OpTypePointer Function %63
         %84 = OpConstantTrue %43
         %85 = OpTypeVector %43 2
         %91 = OpTypePointer Function %48
        %100 = OpConstantFalse %43
        %101 = OpConstantComposite %85 %100 %100
        %114 = OpConstant %7 0
        %125 = OpTypeVector %48 4
        %126 = OpTypePointer Output %125
        %127 = OpVariable %126 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %32 = OpVariable %24 Function
         %47 = OpVariable %24 Function
         %65 = OpVariable %64 Function
         %88 = OpVariable %64 Function
        %103 = OpVariable %24 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %16 %17 %17
         %23 = OpLoad %6 %22
         %25 = OpAccessChain %24 %11 %21
               OpStore %25 %23
         %26 = OpAccessChain %19 %16 %17 %17
         %27 = OpLoad %6 %26
         %29 = OpAccessChain %19 %16 %17 %28
         %30 = OpLoad %6 %29
         %31 = OpAccessChain %24 %11 %27
               OpStore %31 %30
         %33 = OpAccessChain %19 %16 %17 %17
         %34 = OpLoad %6 %33
               OpStore %32 %34
               OpBranch %35
         %35 = OpLabel
               OpLoopMerge %37 %38 None
               OpBranch %39
         %39 = OpLabel
         %40 = OpLoad %6 %32
         %41 = OpAccessChain %19 %16 %17 %18
         %42 = OpLoad %6 %41
         %44 = OpSGreaterThan %43 %40 %42
               OpBranchConditional %44 %36 %37
         %36 = OpLabel
         %45 = OpLoad %6 %32
         %46 = OpISub %6 %45 %28
               OpStore %32 %46
               OpBranch %38
         %38 = OpLabel
               OpBranch %35
         %37 = OpLabel
         %54 = OpAccessChain %53 %52 %17 %28
         %55 = OpLoad %48 %54
         %56 = OpAccessChain %53 %52 %17 %28
         %57 = OpLoad %48 %56
         %58 = OpFOrdGreaterThanEqual %43 %55 %57
         %59 = OpLoad %6 %32
         %60 = OpSelect %6 %58 %28 %59
         %61 = OpAccessChain %24 %11 %60
         %62 = OpLoad %6 %61
               OpStore %47 %62
         %66 = OpAccessChain %19 %16 %17 %17
         %67 = OpLoad %6 %66
         %68 = OpConvertSToF %48 %67
         %69 = OpLoad %6 %47
         %70 = OpConvertSToF %48 %69
         %71 = OpCompositeConstruct %63 %68 %70
         %72 = OpAccessChain %19 %16 %17 %17
         %73 = OpLoad %6 %72
         %74 = OpConvertSToF %48 %73
         %75 = OpAccessChain %19 %16 %17 %17
         %76 = OpLoad %6 %75
         %77 = OpConvertSToF %48 %76
         %78 = OpCompositeConstruct %63 %74 %77
         %79 = OpAccessChain %53 %52 %17 %28
         %80 = OpLoad %48 %79
         %81 = OpAccessChain %53 %52 %17 %17
         %82 = OpLoad %48 %81
         %83 = OpFOrdLessThan %43 %80 %82
         %86 = OpCompositeConstruct %85 %83 %84
         %87 = OpSelect %63 %86 %78 %71
               OpStore %65 %87
         %89 = OpAccessChain %19 %16 %17 %18
         %90 = OpLoad %6 %89
         %92 = OpAccessChain %91 %65 %90
         %93 = OpLoad %48 %92
         %94 = OpCompositeConstruct %63 %93 %93
         %95 = OpAccessChain %19 %16 %17 %17
         %96 = OpLoad %6 %95
         %97 = OpAccessChain %91 %65 %96
         %98 = OpLoad %48 %97
         %99 = OpCompositeConstruct %63 %98 %98
        %102 = OpSelect %63 %101 %99 %94
               OpStore %88 %102
        %104 = OpAccessChain %19 %16 %17 %28
        %105 = OpLoad %6 %104
        %106 = OpConvertSToF %48 %105
        %107 = OpCompositeConstruct %63 %106 %106
        %108 = OpAccessChain %19 %16 %17 %17
        %109 = OpLoad %6 %108
        %110 = OpConvertSToF %48 %109
        %111 = OpCompositeConstruct %63 %110 %110
        %112 = OpLoad %63 %88
        %113 = OpExtInst %63 %1 FClamp %107 %111 %112
        %115 = OpCompositeExtract %48 %113 0
        %116 = OpConvertFToS %6 %115
        %117 = OpAccessChain %24 %11 %116
        %118 = OpLoad %6 %117
               OpStore %103 %118
        %119 = OpLoad %6 %103
        %120 = OpAccessChain %19 %16 %17 %28
        %121 = OpLoad %6 %120
        %122 = OpIEqual %43 %119 %121
               OpSelectionMerge %124 None
               OpBranchConditional %122 %123 %141
        %123 = OpLabel
        %128 = OpAccessChain %19 %16 %17 %17
        %129 = OpLoad %6 %128
        %130 = OpConvertSToF %48 %129
        %131 = OpAccessChain %19 %16 %17 %18
        %132 = OpLoad %6 %131
        %133 = OpConvertSToF %48 %132
        %134 = OpAccessChain %19 %16 %17 %18
        %135 = OpLoad %6 %134
        %136 = OpConvertSToF %48 %135
        %137 = OpAccessChain %19 %16 %17 %17
        %138 = OpLoad %6 %137
        %139 = OpConvertSToF %48 %138
        %140 = OpCompositeConstruct %125 %130 %133 %136 %139
               OpStore %127 %140
               OpBranch %124
        %141 = OpLabel
        %142 = OpAccessChain %19 %16 %17 %18
        %143 = OpLoad %6 %142
        %144 = OpConvertSToF %48 %143
        %145 = OpCompositeConstruct %125 %144 %144 %144 %144
               OpStore %127 %145
               OpBranch %124
        %124 = OpLabel
               OpReturn
               OpFunctionEnd
