#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 170
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %30 %151
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f1("
               OpName %11 "buf3"
               OpMemberName %11 0 "A"
               OpName %13 ""
               OpName %30 "gl_FragCoord"
               OpName %36 "buf2"
               OpMemberName %36 0 "_GLF_uniform_float_values"
               OpName %38 ""
               OpName %66 "i"
               OpName %69 "buf1"
               OpMemberName %69 0 "_GLF_uniform_int_values"
               OpName %71 ""
               OpName %102 "data"
               OpName %108 "j"
               OpName %122 "index"
               OpName %124 "buf0"
               OpMemberName %124 0 "_GLF_uniform_uint_values"
               OpName %126 ""
               OpName %138 "ResType"
               OpName %151 "_GLF_color"
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 3
               OpDecorate %30 BuiltIn FragCoord
               OpDecorate %35 ArrayStride 16
               OpMemberDecorate %36 0 Offset 0
               OpDecorate %36 Block
               OpDecorate %38 DescriptorSet 0
               OpDecorate %38 Binding 2
               OpDecorate %68 ArrayStride 16
               OpMemberDecorate %69 0 Offset 0
               OpDecorate %69 Block
               OpDecorate %71 DescriptorSet 0
               OpDecorate %71 Binding 1
               OpDecorate %123 ArrayStride 16
               OpMemberDecorate %124 0 Offset 0
               OpDecorate %124 Block
               OpDecorate %126 DescriptorSet 0
               OpDecorate %126 Binding 0
               OpDecorate %151 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypeVector %6 2
         %11 = OpTypeStruct %10
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpTypeInt 32 1
         %15 = OpConstant %14 0
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %21 = OpConstant %16 1
         %24 = OpTypeBool
         %28 = OpTypeVector %6 4
         %29 = OpTypePointer Input %28
         %30 = OpVariable %29 Input
         %31 = OpTypePointer Input %6
         %34 = OpConstant %16 2
         %35 = OpTypeArray %6 %34
         %36 = OpTypeStruct %35
         %37 = OpTypePointer Uniform %36
         %38 = OpVariable %37 Uniform
         %39 = OpConstant %14 1
         %65 = OpTypePointer Function %14
         %67 = OpConstant %16 5
         %68 = OpTypeArray %14 %67
         %69 = OpTypeStruct %68
         %70 = OpTypePointer Uniform %69
         %71 = OpVariable %70 Uniform
         %72 = OpConstant %14 2
         %73 = OpTypePointer Uniform %14
        %101 = OpTypePointer Function %35
        %103 = OpConstant %6 0.100000001
        %104 = OpTypePointer Function %6
        %106 = OpConstant %6 0.200000003
        %121 = OpTypePointer Function %16
        %123 = OpTypeArray %16 %34
        %124 = OpTypeStruct %123
        %125 = OpTypePointer Uniform %124
        %126 = OpVariable %125 Uniform
        %127 = OpTypePointer Uniform %16
        %130 = OpConstant %14 4
        %138 = OpTypeStruct %16 %16
        %150 = OpTypePointer Output %28
        %151 = OpVariable %150 Output
        %156 = OpConstant %14 3
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %102 = OpVariable %101 Function
        %108 = OpVariable %65 Function
        %122 = OpVariable %121 Function
        %105 = OpAccessChain %104 %102 %15
               OpStore %105 %103
        %107 = OpAccessChain %104 %102 %39
               OpStore %107 %106
        %109 = OpAccessChain %73 %71 %15 %72
        %110 = OpLoad %14 %109
               OpStore %108 %110
               OpBranch %111
        %111 = OpLabel
               OpLoopMerge %113 %114 None
               OpBranch %115
        %115 = OpLabel
        %116 = OpLoad %14 %108
        %117 = OpAccessChain %73 %71 %15 %39
        %118 = OpLoad %14 %117
        %119 = OpExtInst %14 %1 FindILsb %118
        %120 = OpSLessThan %24 %116 %119
               OpBranchConditional %120 %112 %113
        %112 = OpLabel
        %128 = OpAccessChain %127 %126 %15 %15
        %129 = OpLoad %16 %128
               OpStore %122 %129
        %131 = OpAccessChain %73 %71 %15 %130
        %132 = OpLoad %14 %131
        %133 = OpLoad %14 %108
        %134 = OpIMul %14 %132 %133
        %135 = OpBitcast %16 %134
        %136 = OpAccessChain %127 %126 %15 %39
        %137 = OpLoad %16 %136
        %139 = OpIAddCarry %138 %135 %137
        %140 = OpCompositeExtract %16 %139 1
               OpStore %122 %140
        %141 = OpCompositeExtract %16 %139 0
        %142 = OpLoad %16 %122
        %143 = OpFunctionCall %6 %8
        %144 = OpLoad %16 %122
        %145 = OpConvertUToF %6 %144
        %146 = OpFSub %6 %143 %145
        %147 = OpAccessChain %104 %102 %142
               OpStore %147 %146
               OpBranch %114
        %114 = OpLabel
        %148 = OpLoad %14 %108
        %149 = OpIAdd %14 %148 %39
               OpStore %108 %149
               OpBranch %111
        %113 = OpLabel
        %152 = OpAccessChain %73 %71 %15 %72
        %153 = OpLoad %14 %152
        %154 = OpAccessChain %104 %102 %153
        %155 = OpLoad %6 %154
        %157 = OpAccessChain %73 %71 %15 %156
        %158 = OpLoad %14 %157
        %159 = OpAccessChain %104 %102 %158
        %160 = OpLoad %6 %159
        %161 = OpAccessChain %73 %71 %15 %156
        %162 = OpLoad %14 %161
        %163 = OpAccessChain %104 %102 %162
        %164 = OpLoad %6 %163
        %165 = OpAccessChain %73 %71 %15 %72
        %166 = OpLoad %14 %165
        %167 = OpAccessChain %104 %102 %166
        %168 = OpLoad %6 %167
        %169 = OpCompositeConstruct %28 %155 %160 %164 %168
               OpStore %151 %169
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %66 = OpVariable %65 Function
         %19 = OpAccessChain %18 %13 %15 %17
         %20 = OpLoad %6 %19
         %22 = OpAccessChain %18 %13 %15 %21
         %23 = OpLoad %6 %22
         %25 = OpFOrdGreaterThan %24 %20 %23
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %27
         %26 = OpLabel
         %32 = OpAccessChain %31 %30 %21
         %33 = OpLoad %6 %32
         %40 = OpAccessChain %18 %38 %15 %39
         %41 = OpLoad %6 %40
         %42 = OpFOrdLessThan %24 %33 %41
               OpSelectionMerge %44 None
               OpBranchConditional %42 %43 %44
         %43 = OpLabel
         %45 = OpAccessChain %18 %38 %15 %39
         %46 = OpLoad %6 %45
               OpReturnValue %46
         %44 = OpLabel
               OpBranch %27
         %27 = OpLabel
         %48 = OpAccessChain %18 %38 %15 %39
         %49 = OpLoad %6 %48
         %50 = OpAccessChain %18 %13 %15 %17
         %51 = OpLoad %6 %50
         %52 = OpFOrdGreaterThan %24 %49 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %55 = OpAccessChain %18 %13 %15 %17
         %56 = OpLoad %6 %55
         %57 = OpAccessChain %18 %13 %15 %21
         %58 = OpLoad %6 %57
         %59 = OpFOrdGreaterThan %24 %56 %58
               OpSelectionMerge %61 None
               OpBranchConditional %59 %60 %61
         %60 = OpLabel
         %62 = OpAccessChain %18 %38 %15 %39
         %63 = OpLoad %6 %62
               OpReturnValue %63
         %61 = OpLabel
               OpBranch %54
         %54 = OpLabel
         %74 = OpAccessChain %73 %71 %15 %72
         %75 = OpLoad %14 %74
               OpStore %66 %75
               OpBranch %76
         %76 = OpLabel
               OpLoopMerge %78 %79 None
               OpBranch %80
         %80 = OpLabel
         %81 = OpLoad %14 %66
         %82 = OpAccessChain %73 %71 %15 %15
         %83 = OpLoad %14 %82
         %84 = OpSLessThan %24 %81 %83
               OpBranchConditional %84 %77 %78
         %77 = OpLabel
         %85 = OpAccessChain %31 %30 %17
         %86 = OpLoad %6 %85
         %87 = OpAccessChain %18 %38 %15 %39
         %88 = OpLoad %6 %87
         %89 = OpFOrdLessThan %24 %86 %88
               OpSelectionMerge %91 None
               OpBranchConditional %89 %90 %91
         %90 = OpLabel
         %92 = OpAccessChain %18 %38 %15 %39
         %93 = OpLoad %6 %92
               OpReturnValue %93
         %91 = OpLabel
               OpBranch %79
         %79 = OpLabel
         %95 = OpLoad %14 %66
         %96 = OpIAdd %14 %95 %39
               OpStore %66 %96
               OpBranch %76
         %78 = OpLabel
         %97 = OpAccessChain %18 %38 %15 %15
         %98 = OpLoad %6 %97
               OpReturnValue %98
               OpFunctionEnd
