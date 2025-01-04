#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 193
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %172
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %11 "A"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %55 "ref"
               OpName %109 "a"
               OpName %112 "i"
               OpName %143 "ok"
               OpName %145 "i"
               OpName %172 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %172 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 17
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpConstant %7 19
         %13 = OpTypeArray %6 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %6 0
         %18 = OpConstant %6 2
         %19 = OpTypePointer Uniform %6
         %56 = OpConstant %6 3
         %59 = OpConstant %6 4
         %62 = OpConstant %6 5
         %65 = OpConstant %6 6
         %68 = OpConstant %6 7
         %71 = OpConstant %6 8
         %74 = OpConstant %6 9
         %77 = OpConstant %6 10
         %80 = OpConstant %6 11
         %83 = OpConstant %6 12
         %86 = OpConstant %6 13
         %89 = OpConstant %6 14
         %92 = OpConstant %6 15
         %95 = OpConstant %6 16
         %98 = OpConstant %6 17
        %101 = OpConstant %6 18
        %104 = OpConstant %6 1
        %108 = OpTypePointer Function %6
        %123 = OpTypeBool
        %142 = OpTypePointer Function %123
        %144 = OpConstantTrue %123
        %166 = OpConstantFalse %123
        %169 = OpTypeFloat 32
        %170 = OpTypeVector %169 4
        %171 = OpTypePointer Output %170
        %172 = OpVariable %171 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %55 = OpVariable %10 Function
        %109 = OpVariable %108 Function
        %112 = OpVariable %108 Function
        %143 = OpVariable %142 Function
        %145 = OpVariable %108 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %16 %17 %18
         %23 = OpLoad %6 %22
         %24 = OpAccessChain %19 %16 %17 %18
         %25 = OpLoad %6 %24
         %26 = OpAccessChain %19 %16 %17 %18
         %27 = OpLoad %6 %26
         %28 = OpAccessChain %19 %16 %17 %18
         %29 = OpLoad %6 %28
         %30 = OpAccessChain %19 %16 %17 %18
         %31 = OpLoad %6 %30
         %32 = OpAccessChain %19 %16 %17 %18
         %33 = OpLoad %6 %32
         %34 = OpAccessChain %19 %16 %17 %18
         %35 = OpLoad %6 %34
         %36 = OpAccessChain %19 %16 %17 %18
         %37 = OpLoad %6 %36
         %38 = OpAccessChain %19 %16 %17 %18
         %39 = OpLoad %6 %38
         %40 = OpAccessChain %19 %16 %17 %18
         %41 = OpLoad %6 %40
         %42 = OpAccessChain %19 %16 %17 %18
         %43 = OpLoad %6 %42
         %44 = OpAccessChain %19 %16 %17 %18
         %45 = OpLoad %6 %44
         %46 = OpAccessChain %19 %16 %17 %18
         %47 = OpLoad %6 %46
         %48 = OpAccessChain %19 %16 %17 %18
         %49 = OpLoad %6 %48
         %50 = OpAccessChain %19 %16 %17 %18
         %51 = OpLoad %6 %50
         %52 = OpAccessChain %19 %16 %17 %18
         %53 = OpLoad %6 %52
         %54 = OpCompositeConstruct %9 %21 %23 %25 %27 %29 %31 %33 %35 %37 %39 %41 %43 %45 %47 %49 %51 %53
               OpStore %11 %54
         %57 = OpAccessChain %19 %16 %17 %56
         %58 = OpLoad %6 %57
         %60 = OpAccessChain %19 %16 %17 %59
         %61 = OpLoad %6 %60
         %63 = OpAccessChain %19 %16 %17 %62
         %64 = OpLoad %6 %63
         %66 = OpAccessChain %19 %16 %17 %65
         %67 = OpLoad %6 %66
         %69 = OpAccessChain %19 %16 %17 %68
         %70 = OpLoad %6 %69
         %72 = OpAccessChain %19 %16 %17 %71
         %73 = OpLoad %6 %72
         %75 = OpAccessChain %19 %16 %17 %74
         %76 = OpLoad %6 %75
         %78 = OpAccessChain %19 %16 %17 %77
         %79 = OpLoad %6 %78
         %81 = OpAccessChain %19 %16 %17 %80
         %82 = OpLoad %6 %81
         %84 = OpAccessChain %19 %16 %17 %83
         %85 = OpLoad %6 %84
         %87 = OpAccessChain %19 %16 %17 %86
         %88 = OpLoad %6 %87
         %90 = OpAccessChain %19 %16 %17 %89
         %91 = OpLoad %6 %90
         %93 = OpAccessChain %19 %16 %17 %92
         %94 = OpLoad %6 %93
         %96 = OpAccessChain %19 %16 %17 %95
         %97 = OpLoad %6 %96
         %99 = OpAccessChain %19 %16 %17 %98
        %100 = OpLoad %6 %99
        %102 = OpAccessChain %19 %16 %17 %101
        %103 = OpLoad %6 %102
        %105 = OpAccessChain %19 %16 %17 %104
        %106 = OpLoad %6 %105
        %107 = OpCompositeConstruct %9 %58 %61 %64 %67 %70 %73 %76 %79 %82 %85 %88 %91 %94 %97 %100 %103 %106
               OpStore %55 %107
        %110 = OpAccessChain %19 %16 %17 %18
        %111 = OpLoad %6 %110
               OpStore %109 %111
        %113 = OpAccessChain %19 %16 %17 %18
        %114 = OpLoad %6 %113
               OpStore %112 %114
               OpBranch %115
        %115 = OpLabel
               OpLoopMerge %117 %118 None
               OpBranch %119
        %119 = OpLabel
        %120 = OpLoad %6 %112
        %121 = OpAccessChain %19 %16 %17 %104
        %122 = OpLoad %6 %121
        %124 = OpSLessThan %123 %120 %122
               OpBranchConditional %124 %116 %117
        %116 = OpLabel
        %125 = OpLoad %6 %112
        %126 = OpLoad %6 %109
        %127 = OpISub %6 %126 %104
               OpStore %109 %127
        %128 = OpAccessChain %108 %11 %125
               OpStore %128 %126
        %129 = OpLoad %6 %112
        %130 = OpAccessChain %19 %16 %17 %18
        %131 = OpLoad %6 %130
        %132 = OpAccessChain %19 %16 %17 %101
        %133 = OpLoad %6 %132
        %134 = OpExtInst %6 %1 SClamp %129 %131 %133
        %135 = OpLoad %6 %112
        %136 = OpAccessChain %19 %16 %17 %56
        %137 = OpLoad %6 %136
        %138 = OpIAdd %6 %135 %137
        %139 = OpAccessChain %108 %11 %134
               OpStore %139 %138
               OpBranch %118
        %118 = OpLabel
        %140 = OpLoad %6 %112
        %141 = OpIAdd %6 %140 %104
               OpStore %112 %141
               OpBranch %115
        %117 = OpLabel
               OpStore %143 %144
        %146 = OpAccessChain %19 %16 %17 %18
        %147 = OpLoad %6 %146
               OpStore %145 %147
               OpBranch %148
        %148 = OpLabel
               OpLoopMerge %150 %151 None
               OpBranch %152
        %152 = OpLabel
        %153 = OpLoad %6 %145
        %154 = OpAccessChain %19 %16 %17 %104
        %155 = OpLoad %6 %154
        %156 = OpSLessThan %123 %153 %155
               OpBranchConditional %156 %149 %150
        %149 = OpLabel
        %157 = OpLoad %6 %145
        %158 = OpAccessChain %108 %11 %157
        %159 = OpLoad %6 %158
        %160 = OpLoad %6 %145
        %161 = OpAccessChain %108 %55 %160
        %162 = OpLoad %6 %161
        %163 = OpINotEqual %123 %159 %162
               OpSelectionMerge %165 None
               OpBranchConditional %163 %164 %165
        %164 = OpLabel
               OpStore %143 %166
               OpBranch %165
        %165 = OpLabel
               OpBranch %151
        %151 = OpLabel
        %167 = OpLoad %6 %145
        %168 = OpIAdd %6 %167 %104
               OpStore %145 %168
               OpBranch %148
        %150 = OpLabel
        %173 = OpAccessChain %19 %16 %17 %18
        %174 = OpLoad %6 %173
        %175 = OpConvertSToF %169 %174
        %176 = OpCompositeConstruct %170 %175 %175 %175 %175
               OpStore %172 %176
        %177 = OpLoad %123 %143
               OpSelectionMerge %179 None
               OpBranchConditional %177 %178 %179
        %178 = OpLabel
        %180 = OpAccessChain %19 %16 %17 %56
        %181 = OpLoad %6 %180
        %182 = OpConvertSToF %169 %181
        %183 = OpAccessChain %19 %16 %17 %18
        %184 = OpLoad %6 %183
        %185 = OpConvertSToF %169 %184
        %186 = OpAccessChain %19 %16 %17 %18
        %187 = OpLoad %6 %186
        %188 = OpConvertSToF %169 %187
        %189 = OpAccessChain %19 %16 %17 %56
        %190 = OpLoad %6 %189
        %191 = OpConvertSToF %169 %190
        %192 = OpCompositeConstruct %170 %182 %185 %188 %191
               OpStore %172 %192
               OpBranch %179
        %179 = OpLabel
               OpReturn
               OpFunctionEnd
