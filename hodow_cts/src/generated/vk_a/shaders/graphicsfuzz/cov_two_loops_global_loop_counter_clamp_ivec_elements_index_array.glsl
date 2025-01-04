#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 188
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %169
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %14 "arr0"
               OpName %17 "buf1"
               OpMemberName %17 0 "_GLF_uniform_int_values"
               OpName %19 ""
               OpName %66 "arr1"
               OpName %68 "buf0"
               OpMemberName %68 0 "_GLF_uniform_float_values"
               OpName %70 ""
               OpName %78 "a"
               OpName %115 "v"
               OpName %169 "_GLF_color"
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 1
               OpDecorate %67 ArrayStride 16
               OpMemberDecorate %68 0 Offset 0
               OpDecorate %68 Block
               OpDecorate %70 DescriptorSet 0
               OpDecorate %70 Binding 0
               OpDecorate %169 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 20
         %12 = OpTypeArray %6 %11
         %13 = OpTypePointer Function %12
         %15 = OpConstant %10 2
         %16 = OpTypeArray %6 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypePointer Uniform %6
         %23 = OpConstant %6 1
         %63 = OpTypeFloat 32
         %64 = OpTypeArray %63 %15
         %65 = OpTypePointer Function %64
         %67 = OpTypeArray %63 %15
         %68 = OpTypeStruct %67
         %69 = OpTypePointer Uniform %68
         %70 = OpVariable %69 Uniform
         %71 = OpTypePointer Uniform %63
         %77 = OpTypePointer Function %6
         %87 = OpConstant %6 6
         %88 = OpTypeBool
         %97 = OpTypePointer Function %63
        %102 = OpConstant %6 90
        %113 = OpTypeVector %6 2
        %114 = OpTypePointer Function %113
        %116 = OpConstant %6 20
        %117 = OpConstantComposite %113 %23 %116
        %127 = OpConstant %10 0
        %132 = OpConstant %6 19
        %140 = OpConstant %10 1
        %143 = OpConstant %6 16
        %167 = OpTypeVector %63 4
        %168 = OpTypePointer Output %167
        %169 = OpVariable %168 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpVariable %13 Function
         %66 = OpVariable %65 Function
         %78 = OpVariable %77 Function
        %115 = OpVariable %114 Function
               OpStore %8 %9
         %21 = OpAccessChain %20 %19 %9 %9
         %22 = OpLoad %6 %21
         %24 = OpAccessChain %20 %19 %9 %23
         %25 = OpLoad %6 %24
         %26 = OpAccessChain %20 %19 %9 %9
         %27 = OpLoad %6 %26
         %28 = OpAccessChain %20 %19 %9 %9
         %29 = OpLoad %6 %28
         %30 = OpAccessChain %20 %19 %9 %9
         %31 = OpLoad %6 %30
         %32 = OpAccessChain %20 %19 %9 %9
         %33 = OpLoad %6 %32
         %34 = OpAccessChain %20 %19 %9 %9
         %35 = OpLoad %6 %34
         %36 = OpAccessChain %20 %19 %9 %9
         %37 = OpLoad %6 %36
         %38 = OpAccessChain %20 %19 %9 %9
         %39 = OpLoad %6 %38
         %40 = OpAccessChain %20 %19 %9 %9
         %41 = OpLoad %6 %40
         %42 = OpAccessChain %20 %19 %9 %9
         %43 = OpLoad %6 %42
         %44 = OpAccessChain %20 %19 %9 %9
         %45 = OpLoad %6 %44
         %46 = OpAccessChain %20 %19 %9 %9
         %47 = OpLoad %6 %46
         %48 = OpAccessChain %20 %19 %9 %9
         %49 = OpLoad %6 %48
         %50 = OpAccessChain %20 %19 %9 %9
         %51 = OpLoad %6 %50
         %52 = OpAccessChain %20 %19 %9 %9
         %53 = OpLoad %6 %52
         %54 = OpAccessChain %20 %19 %9 %9
         %55 = OpLoad %6 %54
         %56 = OpAccessChain %20 %19 %9 %9
         %57 = OpLoad %6 %56
         %58 = OpAccessChain %20 %19 %9 %9
         %59 = OpLoad %6 %58
         %60 = OpAccessChain %20 %19 %9 %9
         %61 = OpLoad %6 %60
         %62 = OpCompositeConstruct %12 %22 %25 %27 %29 %31 %33 %35 %37 %39 %41 %43 %45 %47 %49 %51 %53 %55 %57 %59 %61
               OpStore %14 %62
         %72 = OpAccessChain %71 %70 %9 %9
         %73 = OpLoad %63 %72
         %74 = OpAccessChain %71 %70 %9 %23
         %75 = OpLoad %63 %74
         %76 = OpCompositeConstruct %64 %73 %75
               OpStore %66 %76
               OpStore %78 %23
               OpBranch %79
         %79 = OpLabel
               OpLoopMerge %81 %82 None
               OpBranch %80
         %80 = OpLabel
         %83 = OpLoad %6 %8
         %84 = OpIAdd %6 %83 %23
               OpStore %8 %84
         %85 = OpLoad %6 %78
         %86 = OpIAdd %6 %85 %23
               OpStore %78 %86
         %89 = OpSGreaterThanEqual %88 %85 %87
               OpSelectionMerge %91 None
               OpBranchConditional %89 %90 %91
         %90 = OpLabel
               OpBranch %81
         %91 = OpLabel
         %93 = OpAccessChain %20 %19 %9 %9
         %94 = OpLoad %6 %93
         %95 = OpAccessChain %20 %19 %9 %23
         %96 = OpLoad %6 %95
         %98 = OpAccessChain %97 %66 %96
         %99 = OpLoad %63 %98
        %100 = OpAccessChain %97 %66 %94
               OpStore %100 %99
               OpBranch %82
         %82 = OpLabel
        %101 = OpLoad %6 %8
        %103 = OpSLessThan %88 %101 %102
               OpBranchConditional %103 %79 %81
         %81 = OpLabel
               OpBranch %104
        %104 = OpLabel
               OpLoopMerge %106 %107 None
               OpBranch %108
        %108 = OpLabel
        %109 = OpLoad %6 %8
        %110 = OpSLessThan %88 %109 %102
               OpBranchConditional %110 %105 %106
        %105 = OpLabel
        %111 = OpLoad %6 %8
        %112 = OpIAdd %6 %111 %23
               OpStore %8 %112
               OpStore %115 %117
        %118 = OpAccessChain %20 %19 %9 %23
        %119 = OpLoad %6 %118
        %120 = OpAccessChain %77 %14 %119
        %121 = OpLoad %6 %120
        %122 = OpAccessChain %20 %19 %9 %23
        %123 = OpLoad %6 %122
        %124 = OpIEqual %88 %121 %123
               OpSelectionMerge %126 None
               OpBranchConditional %124 %125 %126
        %125 = OpLabel
        %128 = OpAccessChain %77 %115 %127
        %129 = OpLoad %6 %128
        %130 = OpISub %6 %129 %23
        %131 = OpAccessChain %77 %115 %127
               OpStore %131 %130
               OpBranch %126
        %126 = OpLabel
        %133 = OpAccessChain %77 %14 %132
        %134 = OpLoad %6 %133
        %135 = OpIEqual %88 %134 %9
               OpSelectionMerge %137 None
               OpBranchConditional %135 %136 %137
        %136 = OpLabel
        %138 = OpAccessChain %77 %115 %127
        %139 = OpLoad %6 %138
        %141 = OpAccessChain %77 %115 %140
        %142 = OpLoad %6 %141
        %144 = OpIMul %6 %142 %143
        %145 = OpIAdd %6 %139 %144
        %146 = OpAccessChain %20 %19 %9 %9
        %147 = OpLoad %6 %146
        %148 = OpExtInst %6 %1 SClamp %145 %147 %132
        %149 = OpAccessChain %77 %14 %148
               OpStore %149 %23
               OpBranch %137
        %137 = OpLabel
               OpBranch %107
        %107 = OpLabel
               OpBranch %104
        %106 = OpLabel
        %150 = OpAccessChain %77 %14 %132
        %151 = OpLoad %6 %150
        %152 = OpAccessChain %20 %19 %9 %23
        %153 = OpLoad %6 %152
        %154 = OpIEqual %88 %151 %153
               OpSelectionMerge %156 None
               OpBranchConditional %154 %155 %156
        %155 = OpLabel
        %157 = OpAccessChain %20 %19 %9 %9
        %158 = OpLoad %6 %157
        %159 = OpAccessChain %97 %66 %158
        %160 = OpLoad %63 %159
        %161 = OpAccessChain %71 %70 %9 %23
        %162 = OpLoad %63 %161
        %163 = OpFOrdEqual %88 %160 %162
               OpBranch %156
        %156 = OpLabel
        %164 = OpPhi %88 %154 %106 %163 %155
               OpSelectionMerge %166 None
               OpBranchConditional %164 %165 %183
        %165 = OpLabel
        %170 = OpAccessChain %20 %19 %9 %23
        %171 = OpLoad %6 %170
        %172 = OpConvertSToF %63 %171
        %173 = OpAccessChain %20 %19 %9 %9
        %174 = OpLoad %6 %173
        %175 = OpConvertSToF %63 %174
        %176 = OpAccessChain %20 %19 %9 %9
        %177 = OpLoad %6 %176
        %178 = OpConvertSToF %63 %177
        %179 = OpAccessChain %20 %19 %9 %23
        %180 = OpLoad %6 %179
        %181 = OpConvertSToF %63 %180
        %182 = OpCompositeConstruct %167 %172 %175 %178 %181
               OpStore %169 %182
               OpBranch %166
        %183 = OpLabel
        %184 = OpAccessChain %20 %19 %9 %9
        %185 = OpLoad %6 %184
        %186 = OpConvertSToF %63 %185
        %187 = OpCompositeConstruct %167 %186 %186 %186 %186
               OpStore %169 %187
               OpBranch %166
        %166 = OpLabel
               OpReturn
               OpFunctionEnd
