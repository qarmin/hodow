#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 13
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %11
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %11 "frag_color"
               OpDecorate %9 Location 0
               OpDecorate %11 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypePointer Input %7
         %11 = OpVariable %10 Input
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %12 = OpLoad %7 %11
               OpStore %9 %12
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 345
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Vertex %4 "main" %157 %333 %342
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "swap(i1;i1;"
               OpName %9 "i"
               OpName %10 "j"
               OpName %16 "performPartition(i1;i1;"
               OpName %14 "l"
               OpName %15 "h"
               OpName %18 "quicksort("
               OpName %20 "temp"
               OpName %24 "QuicksortObject"
               OpMemberName %24 0 "numbers"
               OpName %26 "obj"
               OpName %40 "pivot"
               OpName %44 "i"
               OpName %48 "j"
               OpName %69 "param"
               OpName %71 "param"
               OpName %78 "param"
               OpName %79 "param"
               OpName %86 "l"
               OpName %87 "h"
               OpName %89 "top"
               OpName %92 "stack"
               OpName %116 "p"
               OpName %117 "param"
               OpName %119 "param"
               OpName %155 "_GLF_FragCoord"
               OpName %157 "_GLF_pos"
               OpName %166 "i"
               OpName %193 "uv"
               OpName %196 "buf0"
               OpMemberName %196 0 "resolution"
               OpName %198 ""
               OpName %205 "color"
               OpName %333 "frag_color"
               OpName %340 "gl_PerVertex"
               OpMemberName %340 0 "gl_Position"
               OpMemberName %340 1 "gl_PointSize"
               OpName %342 ""
               OpDecorate %157 Location 0
               OpMemberDecorate %196 0 Offset 0
               OpDecorate %196 Block
               OpDecorate %198 DescriptorSet 0
               OpDecorate %198 Binding 0
               OpDecorate %333 Location 0
               OpMemberDecorate %340 0 BuiltIn Position
               OpMemberDecorate %340 1 BuiltIn PointSize
               OpDecorate %340 Block
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %2 %7 %7
         %13 = OpTypeFunction %6 %7 %7
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 10
         %23 = OpTypeArray %6 %22
         %24 = OpTypeStruct %23
         %25 = OpTypePointer Private %24
         %26 = OpVariable %25 Private
         %27 = OpConstant %6 0
         %29 = OpTypePointer Private %6
         %46 = OpConstant %6 1
         %58 = OpTypeBool
         %88 = OpConstant %6 9
         %90 = OpConstant %6 -1
         %91 = OpTypePointer Function %23
        %152 = OpTypeFloat 32
        %153 = OpTypeVector %152 4
        %154 = OpTypePointer Private %153
        %155 = OpVariable %154 Private
        %156 = OpTypePointer Input %153
        %157 = OpVariable %156 Input
        %159 = OpConstant %152 1
        %160 = OpConstant %152 0
        %161 = OpConstantComposite %153 %159 %159 %160 %160
        %163 = OpConstant %152 128
        %164 = OpConstantComposite %153 %163 %163 %159 %159
        %173 = OpConstant %6 10
        %191 = OpTypeVector %152 2
        %192 = OpTypePointer Function %191
        %196 = OpTypeStruct %191
        %197 = OpTypePointer Uniform %196
        %198 = OpVariable %197 Uniform
        %199 = OpTypePointer Uniform %191
        %203 = OpTypeVector %152 3
        %204 = OpTypePointer Function %203
        %206 = OpConstant %152 2
        %207 = OpConstant %152 3
        %208 = OpConstantComposite %203 %159 %206 %207
        %212 = OpConstant %21 0
        %213 = OpTypePointer Function %152
        %220 = OpConstant %152 0.25
        %233 = OpConstant %152 0.5
        %237 = OpConstant %6 2
        %241 = OpConstant %21 1
        %248 = OpConstant %152 0.75
        %252 = OpConstant %6 3
        %256 = OpConstant %21 2
        %261 = OpConstant %6 4
        %274 = OpConstant %6 5
        %287 = OpConstant %6 6
        %300 = OpConstant %6 7
        %308 = OpConstant %6 8
        %332 = OpTypePointer Output %153
        %333 = OpVariable %332 Output
        %340 = OpTypeStruct %153 %152
        %341 = OpTypePointer Output %340
        %342 = OpVariable %341 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %166 = OpVariable %7 Function
        %193 = OpVariable %192 Function
        %205 = OpVariable %204 Function
        %158 = OpLoad %153 %157
        %162 = OpFAdd %153 %158 %161
        %165 = OpFMul %153 %162 %164
               OpStore %155 %165
               OpStore %166 %27
               OpBranch %167
        %167 = OpLabel
               OpLoopMerge %169 %170 None
               OpBranch %171
        %171 = OpLabel
        %172 = OpLoad %6 %166
        %174 = OpSLessThan %58 %172 %173
               OpBranchConditional %174 %168 %169
        %168 = OpLabel
        %175 = OpLoad %6 %166
        %176 = OpLoad %6 %166
        %177 = OpISub %6 %173 %176
        %178 = OpAccessChain %29 %26 %27 %175
               OpStore %178 %177
        %179 = OpLoad %6 %166
        %180 = OpLoad %6 %166
        %181 = OpAccessChain %29 %26 %27 %180
        %182 = OpLoad %6 %181
        %183 = OpLoad %6 %166
        %184 = OpAccessChain %29 %26 %27 %183
        %185 = OpLoad %6 %184
        %186 = OpIMul %6 %182 %185
        %187 = OpAccessChain %29 %26 %27 %179
               OpStore %187 %186
               OpBranch %170
        %170 = OpLabel
        %188 = OpLoad %6 %166
        %189 = OpIAdd %6 %188 %46
               OpStore %166 %189
               OpBranch %167
        %169 = OpLabel
        %190 = OpFunctionCall %2 %18
        %194 = OpLoad %153 %155
        %195 = OpVectorShuffle %191 %194 %194 0 1
        %200 = OpAccessChain %199 %198 %27
        %201 = OpLoad %191 %200
        %202 = OpFDiv %191 %195 %201
               OpStore %193 %202
               OpStore %205 %208
        %209 = OpAccessChain %29 %26 %27 %27
        %210 = OpLoad %6 %209
        %211 = OpConvertSToF %152 %210
        %214 = OpAccessChain %213 %205 %212
        %215 = OpLoad %152 %214
        %216 = OpFAdd %152 %215 %211
        %217 = OpAccessChain %213 %205 %212
               OpStore %217 %216
        %218 = OpAccessChain %213 %193 %212
        %219 = OpLoad %152 %218
        %221 = OpFOrdGreaterThan %58 %219 %220
               OpSelectionMerge %223 None
               OpBranchConditional %221 %222 %223
        %222 = OpLabel
        %224 = OpAccessChain %29 %26 %27 %46
        %225 = OpLoad %6 %224
        %226 = OpConvertSToF %152 %225
        %227 = OpAccessChain %213 %205 %212
        %228 = OpLoad %152 %227
        %229 = OpFAdd %152 %228 %226
        %230 = OpAccessChain %213 %205 %212
               OpStore %230 %229
               OpBranch %223
        %223 = OpLabel
        %231 = OpAccessChain %213 %193 %212
        %232 = OpLoad %152 %231
        %234 = OpFOrdGreaterThan %58 %232 %233
               OpSelectionMerge %236 None
               OpBranchConditional %234 %235 %236
        %235 = OpLabel
        %238 = OpAccessChain %29 %26 %27 %237
        %239 = OpLoad %6 %238
        %240 = OpConvertSToF %152 %239
        %242 = OpAccessChain %213 %205 %241
        %243 = OpLoad %152 %242
        %244 = OpFAdd %152 %243 %240
        %245 = OpAccessChain %213 %205 %241
               OpStore %245 %244
               OpBranch %236
        %236 = OpLabel
        %246 = OpAccessChain %213 %193 %212
        %247 = OpLoad %152 %246
        %249 = OpFOrdGreaterThan %58 %247 %248
               OpSelectionMerge %251 None
               OpBranchConditional %249 %250 %251
        %250 = OpLabel
        %253 = OpAccessChain %29 %26 %27 %252
        %254 = OpLoad %6 %253
        %255 = OpConvertSToF %152 %254
        %257 = OpAccessChain %213 %205 %256
        %258 = OpLoad %152 %257
        %259 = OpFAdd %152 %258 %255
        %260 = OpAccessChain %213 %205 %256
               OpStore %260 %259
               OpBranch %251
        %251 = OpLabel
        %262 = OpAccessChain %29 %26 %27 %261
        %263 = OpLoad %6 %262
        %264 = OpConvertSToF %152 %263
        %265 = OpAccessChain %213 %205 %241
        %266 = OpLoad %152 %265
        %267 = OpFAdd %152 %266 %264
        %268 = OpAccessChain %213 %205 %241
               OpStore %268 %267
        %269 = OpAccessChain %213 %193 %241
        %270 = OpLoad %152 %269
        %271 = OpFOrdGreaterThan %58 %270 %220
               OpSelectionMerge %273 None
               OpBranchConditional %271 %272 %273
        %272 = OpLabel
        %275 = OpAccessChain %29 %26 %27 %274
        %276 = OpLoad %6 %275
        %277 = OpConvertSToF %152 %276
        %278 = OpAccessChain %213 %205 %212
        %279 = OpLoad %152 %278
        %280 = OpFAdd %152 %279 %277
        %281 = OpAccessChain %213 %205 %212
               OpStore %281 %280
               OpBranch %273
        %273 = OpLabel
        %282 = OpAccessChain %213 %193 %241
        %283 = OpLoad %152 %282
        %284 = OpFOrdGreaterThan %58 %283 %233
               OpSelectionMerge %286 None
               OpBranchConditional %284 %285 %286
        %285 = OpLabel
        %288 = OpAccessChain %29 %26 %27 %287
        %289 = OpLoad %6 %288
        %290 = OpConvertSToF %152 %289
        %291 = OpAccessChain %213 %205 %241
        %292 = OpLoad %152 %291
        %293 = OpFAdd %152 %292 %290
        %294 = OpAccessChain %213 %205 %241
               OpStore %294 %293
               OpBranch %286
        %286 = OpLabel
        %295 = OpAccessChain %213 %193 %241
        %296 = OpLoad %152 %295
        %297 = OpFOrdGreaterThan %58 %296 %248
               OpSelectionMerge %299 None
               OpBranchConditional %297 %298 %299
        %298 = OpLabel
        %301 = OpAccessChain %29 %26 %27 %300
        %302 = OpLoad %6 %301
        %303 = OpConvertSToF %152 %302
        %304 = OpAccessChain %213 %205 %256
        %305 = OpLoad %152 %304
        %306 = OpFAdd %152 %305 %303
        %307 = OpAccessChain %213 %205 %256
               OpStore %307 %306
               OpBranch %299
        %299 = OpLabel
        %309 = OpAccessChain %29 %26 %27 %308
        %310 = OpLoad %6 %309
        %311 = OpConvertSToF %152 %310
        %312 = OpAccessChain %213 %205 %256
        %313 = OpLoad %152 %312
        %314 = OpFAdd %152 %313 %311
        %315 = OpAccessChain %213 %205 %256
               OpStore %315 %314
        %316 = OpAccessChain %213 %193 %212
        %317 = OpLoad %152 %316
        %318 = OpAccessChain %213 %193 %241
        %319 = OpLoad %152 %318
        %320 = OpFSub %152 %317 %319
        %321 = OpExtInst %152 %1 FAbs %320
        %322 = OpFOrdLessThan %58 %321 %220
               OpSelectionMerge %324 None
               OpBranchConditional %322 %323 %324
        %323 = OpLabel
        %325 = OpAccessChain %29 %26 %27 %88
        %326 = OpLoad %6 %325
        %327 = OpConvertSToF %152 %326
        %328 = OpAccessChain %213 %205 %212
        %329 = OpLoad %152 %328
        %330 = OpFAdd %152 %329 %327
        %331 = OpAccessChain %213 %205 %212
               OpStore %331 %330
               OpBranch %324
        %324 = OpLabel
        %334 = OpLoad %203 %205
        %335 = OpExtInst %203 %1 Normalize %334
        %336 = OpCompositeExtract %152 %335 0
        %337 = OpCompositeExtract %152 %335 1
        %338 = OpCompositeExtract %152 %335 2
        %339 = OpCompositeConstruct %153 %336 %337 %338 %159
               OpStore %333 %339
        %343 = OpLoad %153 %157
        %344 = OpAccessChain %332 %342 %27
               OpStore %344 %343
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %2 None %8
          %9 = OpFunctionParameter %7
         %10 = OpFunctionParameter %7
         %12 = OpLabel
         %20 = OpVariable %7 Function
         %28 = OpLoad %6 %9
         %30 = OpAccessChain %29 %26 %27 %28
         %31 = OpLoad %6 %30
               OpStore %20 %31
         %32 = OpLoad %6 %9
         %33 = OpLoad %6 %10
         %34 = OpAccessChain %29 %26 %27 %33
         %35 = OpLoad %6 %34
         %36 = OpAccessChain %29 %26 %27 %32
               OpStore %36 %35
         %37 = OpLoad %6 %10
         %38 = OpLoad %6 %20
         %39 = OpAccessChain %29 %26 %27 %37
               OpStore %39 %38
               OpReturn
               OpFunctionEnd
         %16 = OpFunction %6 None %13
         %14 = OpFunctionParameter %7
         %15 = OpFunctionParameter %7
         %17 = OpLabel
         %40 = OpVariable %7 Function
         %44 = OpVariable %7 Function
         %48 = OpVariable %7 Function
         %69 = OpVariable %7 Function
         %71 = OpVariable %7 Function
         %78 = OpVariable %7 Function
         %79 = OpVariable %7 Function
         %41 = OpLoad %6 %15
         %42 = OpAccessChain %29 %26 %27 %41
         %43 = OpLoad %6 %42
               OpStore %40 %43
         %45 = OpLoad %6 %14
         %47 = OpISub %6 %45 %46
               OpStore %44 %47
         %49 = OpLoad %6 %14
               OpStore %48 %49
               OpBranch %50
         %50 = OpLabel
               OpLoopMerge %52 %53 None
               OpBranch %54
         %54 = OpLabel
         %55 = OpLoad %6 %48
         %56 = OpLoad %6 %15
         %57 = OpISub %6 %56 %46
         %59 = OpSLessThanEqual %58 %55 %57
               OpBranchConditional %59 %51 %52
         %51 = OpLabel
         %60 = OpLoad %6 %48
         %61 = OpAccessChain %29 %26 %27 %60
         %62 = OpLoad %6 %61
         %63 = OpLoad %6 %40
         %64 = OpSLessThanEqual %58 %62 %63
               OpSelectionMerge %66 None
               OpBranchConditional %64 %65 %66
         %65 = OpLabel
         %67 = OpLoad %6 %44
         %68 = OpIAdd %6 %67 %46
               OpStore %44 %68
         %70 = OpLoad %6 %44
               OpStore %69 %70
         %72 = OpLoad %6 %48
               OpStore %71 %72
         %73 = OpFunctionCall %2 %11 %69 %71
               OpBranch %66
         %66 = OpLabel
               OpBranch %53
         %53 = OpLabel
         %74 = OpLoad %6 %48
         %75 = OpIAdd %6 %74 %46
               OpStore %48 %75
               OpBranch %50
         %52 = OpLabel
         %76 = OpLoad %6 %44
         %77 = OpIAdd %6 %76 %46
               OpStore %78 %77
         %80 = OpLoad %6 %15
               OpStore %79 %80
         %81 = OpFunctionCall %2 %11 %78 %79
         %82 = OpLoad %6 %44
         %83 = OpIAdd %6 %82 %46
               OpReturnValue %83
               OpFunctionEnd
         %18 = OpFunction %2 None %3
         %19 = OpLabel
         %86 = OpVariable %7 Function
         %87 = OpVariable %7 Function
         %89 = OpVariable %7 Function
         %92 = OpVariable %91 Function
        %116 = OpVariable %7 Function
        %117 = OpVariable %7 Function
        %119 = OpVariable %7 Function
               OpStore %86 %27
               OpStore %87 %88
               OpStore %89 %90
         %93 = OpLoad %6 %89
         %94 = OpIAdd %6 %93 %46
               OpStore %89 %94
         %95 = OpLoad %6 %86
         %96 = OpAccessChain %7 %92 %94
               OpStore %96 %95
         %97 = OpLoad %6 %89
         %98 = OpIAdd %6 %97 %46
               OpStore %89 %98
         %99 = OpLoad %6 %87
        %100 = OpAccessChain %7 %92 %98
               OpStore %100 %99
               OpBranch %101
        %101 = OpLabel
               OpLoopMerge %103 %104 None
               OpBranch %105
        %105 = OpLabel
        %106 = OpLoad %6 %89
        %107 = OpSGreaterThanEqual %58 %106 %27
               OpBranchConditional %107 %102 %103
        %102 = OpLabel
        %108 = OpLoad %6 %89
        %109 = OpISub %6 %108 %46
               OpStore %89 %109
        %110 = OpAccessChain %7 %92 %108
        %111 = OpLoad %6 %110
               OpStore %87 %111
        %112 = OpLoad %6 %89
        %113 = OpISub %6 %112 %46
               OpStore %89 %113
        %114 = OpAccessChain %7 %92 %112
        %115 = OpLoad %6 %114
               OpStore %86 %115
        %118 = OpLoad %6 %86
               OpStore %117 %118
        %120 = OpLoad %6 %87
               OpStore %119 %120
        %121 = OpFunctionCall %6 %16 %117 %119
               OpStore %116 %121
        %122 = OpLoad %6 %116
        %123 = OpISub %6 %122 %46
        %124 = OpLoad %6 %86
        %125 = OpSGreaterThan %58 %123 %124
               OpSelectionMerge %127 None
               OpBranchConditional %125 %126 %127
        %126 = OpLabel
        %128 = OpLoad %6 %89
        %129 = OpIAdd %6 %128 %46
               OpStore %89 %129
        %130 = OpLoad %6 %86
        %131 = OpAccessChain %7 %92 %129
               OpStore %131 %130
        %132 = OpLoad %6 %89
        %133 = OpIAdd %6 %132 %46
               OpStore %89 %133
        %134 = OpLoad %6 %116
        %135 = OpISub %6 %134 %46
        %136 = OpAccessChain %7 %92 %133
               OpStore %136 %135
               OpBranch %127
        %127 = OpLabel
        %137 = OpLoad %6 %116
        %138 = OpIAdd %6 %137 %46
        %139 = OpLoad %6 %87
        %140 = OpSLessThan %58 %138 %139
               OpSelectionMerge %142 None
               OpBranchConditional %140 %141 %142
        %141 = OpLabel
        %143 = OpLoad %6 %89
        %144 = OpIAdd %6 %143 %46
               OpStore %89 %144
        %145 = OpLoad %6 %116
        %146 = OpIAdd %6 %145 %46
        %147 = OpAccessChain %7 %92 %144
               OpStore %147 %146
        %148 = OpLoad %6 %89
        %149 = OpIAdd %6 %148 %46
               OpStore %89 %149
        %150 = OpLoad %6 %87
        %151 = OpAccessChain %7 %92 %149
               OpStore %151 %150
               OpBranch %142
        %142 = OpLabel
               OpBranch %104
        %104 = OpLabel
               OpBranch %101
        %103 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 363
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Vertex %4 "main" %157 %351 %360
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "swap(i1;i1;"
               OpName %9 "i"
               OpName %10 "j"
               OpName %16 "performPartition(i1;i1;"
               OpName %14 "l"
               OpName %15 "h"
               OpName %18 "quicksort("
               OpName %20 "temp"
               OpName %24 "QuicksortObject"
               OpMemberName %24 0 "numbers"
               OpName %26 "obj"
               OpName %40 "pivot"
               OpName %44 "i"
               OpName %48 "j"
               OpName %69 "param"
               OpName %71 "param"
               OpName %78 "param"
               OpName %79 "param"
               OpName %86 "l"
               OpName %87 "h"
               OpName %89 "top"
               OpName %92 "stack"
               OpName %116 "p"
               OpName %117 "param"
               OpName %119 "param"
               OpName %155 "_GLF_FragCoord"
               OpName %157 "_GLF_pos"
               OpName %166 "i"
               OpName %193 "uv"
               OpName %196 "buf1"
               OpMemberName %196 0 "resolution"
               OpName %198 ""
               OpName %205 "color"
               OpName %238 "buf0"
               OpMemberName %238 0 "injectionSwitch"
               OpName %240 ""
               OpName %351 "frag_color"
               OpName %358 "gl_PerVertex"
               OpMemberName %358 0 "gl_Position"
               OpMemberName %358 1 "gl_PointSize"
               OpName %360 ""
               OpDecorate %157 Location 0
               OpMemberDecorate %196 0 Offset 0
               OpDecorate %196 Block
               OpDecorate %198 DescriptorSet 0
               OpDecorate %198 Binding 1
               OpMemberDecorate %238 0 Offset 0
               OpDecorate %238 Block
               OpDecorate %240 DescriptorSet 0
               OpDecorate %240 Binding 0
               OpDecorate %351 Location 0
               OpMemberDecorate %358 0 BuiltIn Position
               OpMemberDecorate %358 1 BuiltIn PointSize
               OpDecorate %358 Block
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %2 %7 %7
         %13 = OpTypeFunction %6 %7 %7
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 10
         %23 = OpTypeArray %6 %22
         %24 = OpTypeStruct %23
         %25 = OpTypePointer Private %24
         %26 = OpVariable %25 Private
         %27 = OpConstant %6 0
         %29 = OpTypePointer Private %6
         %46 = OpConstant %6 1
         %58 = OpTypeBool
         %88 = OpConstant %6 9
         %90 = OpConstant %6 -1
         %91 = OpTypePointer Function %23
        %152 = OpTypeFloat 32
        %153 = OpTypeVector %152 4
        %154 = OpTypePointer Private %153
        %155 = OpVariable %154 Private
        %156 = OpTypePointer Input %153
        %157 = OpVariable %156 Input
        %159 = OpConstant %152 1
        %160 = OpConstant %152 0
        %161 = OpConstantComposite %153 %159 %159 %160 %160
        %163 = OpConstant %152 128
        %164 = OpConstantComposite %153 %163 %163 %159 %159
        %173 = OpConstant %6 10
        %191 = OpTypeVector %152 2
        %192 = OpTypePointer Function %191
        %196 = OpTypeStruct %191
        %197 = OpTypePointer Uniform %196
        %198 = OpVariable %197 Uniform
        %199 = OpTypePointer Uniform %191
        %203 = OpTypeVector %152 3
        %204 = OpTypePointer Function %203
        %206 = OpConstant %152 2
        %207 = OpConstant %152 3
        %208 = OpConstantComposite %203 %159 %206 %207
        %212 = OpConstant %21 0
        %213 = OpTypePointer Function %152
        %220 = OpConstant %152 0.25
        %233 = OpConstant %152 0.5
        %237 = OpConstant %6 2
        %238 = OpTypeStruct %191
        %239 = OpTypePointer Uniform %238
        %240 = OpVariable %239 Uniform
        %241 = OpConstant %21 1
        %242 = OpTypePointer Uniform %152
        %266 = OpConstant %152 0.75
        %270 = OpConstant %6 3
        %274 = OpConstant %21 2
        %279 = OpConstant %6 4
        %292 = OpConstant %6 5
        %305 = OpConstant %6 6
        %318 = OpConstant %6 7
        %326 = OpConstant %6 8
        %350 = OpTypePointer Output %153
        %351 = OpVariable %350 Output
        %358 = OpTypeStruct %153 %152
        %359 = OpTypePointer Output %358
        %360 = OpVariable %359 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %166 = OpVariable %7 Function
        %193 = OpVariable %192 Function
        %205 = OpVariable %204 Function
        %158 = OpLoad %153 %157
        %162 = OpFAdd %153 %158 %161
        %165 = OpFMul %153 %162 %164
               OpStore %155 %165
               OpStore %166 %27
               OpBranch %167
        %167 = OpLabel
               OpLoopMerge %169 %170 None
               OpBranch %171
        %171 = OpLabel
        %172 = OpLoad %6 %166
        %174 = OpSLessThan %58 %172 %173
               OpBranchConditional %174 %168 %169
        %168 = OpLabel
        %175 = OpLoad %6 %166
        %176 = OpLoad %6 %166
        %177 = OpISub %6 %173 %176
        %178 = OpAccessChain %29 %26 %27 %175
               OpStore %178 %177
        %179 = OpLoad %6 %166
        %180 = OpLoad %6 %166
        %181 = OpAccessChain %29 %26 %27 %180
        %182 = OpLoad %6 %181
        %183 = OpLoad %6 %166
        %184 = OpAccessChain %29 %26 %27 %183
        %185 = OpLoad %6 %184
        %186 = OpIMul %6 %182 %185
        %187 = OpAccessChain %29 %26 %27 %179
               OpStore %187 %186
               OpBranch %170
        %170 = OpLabel
        %188 = OpLoad %6 %166
        %189 = OpIAdd %6 %188 %46
               OpStore %166 %189
               OpBranch %167
        %169 = OpLabel
        %190 = OpFunctionCall %2 %18
        %194 = OpLoad %153 %155
        %195 = OpVectorShuffle %191 %194 %194 0 1
        %200 = OpAccessChain %199 %198 %27
        %201 = OpLoad %191 %200
        %202 = OpFDiv %191 %195 %201
               OpStore %193 %202
               OpStore %205 %208
        %209 = OpAccessChain %29 %26 %27 %27
        %210 = OpLoad %6 %209
        %211 = OpConvertSToF %152 %210
        %214 = OpAccessChain %213 %205 %212
        %215 = OpLoad %152 %214
        %216 = OpFAdd %152 %215 %211
        %217 = OpAccessChain %213 %205 %212
               OpStore %217 %216
        %218 = OpAccessChain %213 %193 %212
        %219 = OpLoad %152 %218
        %221 = OpFOrdGreaterThan %58 %219 %220
               OpSelectionMerge %223 None
               OpBranchConditional %221 %222 %223
        %222 = OpLabel
        %224 = OpAccessChain %29 %26 %27 %46
        %225 = OpLoad %6 %224
        %226 = OpConvertSToF %152 %225
        %227 = OpAccessChain %213 %205 %212
        %228 = OpLoad %152 %227
        %229 = OpFAdd %152 %228 %226
        %230 = OpAccessChain %213 %205 %212
               OpStore %230 %229
               OpBranch %223
        %223 = OpLabel
        %231 = OpAccessChain %213 %193 %212
        %232 = OpLoad %152 %231
        %234 = OpFOrdGreaterThan %58 %232 %233
               OpSelectionMerge %236 None
               OpBranchConditional %234 %235 %236
        %235 = OpLabel
        %243 = OpAccessChain %242 %240 %27 %241
        %244 = OpLoad %152 %243
        %245 = OpConvertFToS %6 %244
        %246 = OpIMul %6 %237 %245
        %247 = OpExtInst %6 %1 SMax %246 %237
        %248 = OpAccessChain %29 %26 %27 %247
        %249 = OpLoad %6 %248
        %250 = OpConvertSToF %152 %249
        %251 = OpAccessChain %242 %240 %27 %241
        %252 = OpLoad %152 %251
        %253 = OpConvertFToS %6 %252
        %254 = OpIMul %6 %237 %253
        %255 = OpExtInst %6 %1 SMax %254 %237
        %256 = OpAccessChain %29 %26 %27 %255
        %257 = OpLoad %6 %256
        %258 = OpConvertSToF %152 %257
        %259 = OpExtInst %152 %1 FMax %250 %258
        %260 = OpAccessChain %213 %205 %241
        %261 = OpLoad %152 %260
        %262 = OpFAdd %152 %261 %259
        %263 = OpAccessChain %213 %205 %241
               OpStore %263 %262
               OpBranch %236
        %236 = OpLabel
        %264 = OpAccessChain %213 %193 %212
        %265 = OpLoad %152 %264
        %267 = OpFOrdGreaterThan %58 %265 %266
               OpSelectionMerge %269 None
               OpBranchConditional %267 %268 %269
        %268 = OpLabel
        %271 = OpAccessChain %29 %26 %27 %270
        %272 = OpLoad %6 %271
        %273 = OpConvertSToF %152 %272
        %275 = OpAccessChain %213 %205 %274
        %276 = OpLoad %152 %275
        %277 = OpFAdd %152 %276 %273
        %278 = OpAccessChain %213 %205 %274
               OpStore %278 %277
               OpBranch %269
        %269 = OpLabel
        %280 = OpAccessChain %29 %26 %27 %279
        %281 = OpLoad %6 %280
        %282 = OpConvertSToF %152 %281
        %283 = OpAccessChain %213 %205 %241
        %284 = OpLoad %152 %283
        %285 = OpFAdd %152 %284 %282
        %286 = OpAccessChain %213 %205 %241
               OpStore %286 %285
        %287 = OpAccessChain %213 %193 %241
        %288 = OpLoad %152 %287
        %289 = OpFOrdGreaterThan %58 %288 %220
               OpSelectionMerge %291 None
               OpBranchConditional %289 %290 %291
        %290 = OpLabel
        %293 = OpAccessChain %29 %26 %27 %292
        %294 = OpLoad %6 %293
        %295 = OpConvertSToF %152 %294
        %296 = OpAccessChain %213 %205 %212
        %297 = OpLoad %152 %296
        %298 = OpFAdd %152 %297 %295
        %299 = OpAccessChain %213 %205 %212
               OpStore %299 %298
               OpBranch %291
        %291 = OpLabel
        %300 = OpAccessChain %213 %193 %241
        %301 = OpLoad %152 %300
        %302 = OpFOrdGreaterThan %58 %301 %233
               OpSelectionMerge %304 None
               OpBranchConditional %302 %303 %304
        %303 = OpLabel
        %306 = OpAccessChain %29 %26 %27 %305
        %307 = OpLoad %6 %306
        %308 = OpConvertSToF %152 %307
        %309 = OpAccessChain %213 %205 %241
        %310 = OpLoad %152 %309
        %311 = OpFAdd %152 %310 %308
        %312 = OpAccessChain %213 %205 %241
               OpStore %312 %311
               OpBranch %304
        %304 = OpLabel
        %313 = OpAccessChain %213 %193 %241
        %314 = OpLoad %152 %313
        %315 = OpFOrdGreaterThan %58 %314 %266
               OpSelectionMerge %317 None
               OpBranchConditional %315 %316 %317
        %316 = OpLabel
        %319 = OpAccessChain %29 %26 %27 %318
        %320 = OpLoad %6 %319
        %321 = OpConvertSToF %152 %320
        %322 = OpAccessChain %213 %205 %274
        %323 = OpLoad %152 %322
        %324 = OpFAdd %152 %323 %321
        %325 = OpAccessChain %213 %205 %274
               OpStore %325 %324
               OpBranch %317
        %317 = OpLabel
        %327 = OpAccessChain %29 %26 %27 %326
        %328 = OpLoad %6 %327
        %329 = OpConvertSToF %152 %328
        %330 = OpAccessChain %213 %205 %274
        %331 = OpLoad %152 %330
        %332 = OpFAdd %152 %331 %329
        %333 = OpAccessChain %213 %205 %274
               OpStore %333 %332
        %334 = OpAccessChain %213 %193 %212
        %335 = OpLoad %152 %334
        %336 = OpAccessChain %213 %193 %241
        %337 = OpLoad %152 %336
        %338 = OpFSub %152 %335 %337
        %339 = OpExtInst %152 %1 FAbs %338
        %340 = OpFOrdLessThan %58 %339 %220
               OpSelectionMerge %342 None
               OpBranchConditional %340 %341 %342
        %341 = OpLabel
        %343 = OpAccessChain %29 %26 %27 %88
        %344 = OpLoad %6 %343
        %345 = OpConvertSToF %152 %344
        %346 = OpAccessChain %213 %205 %212
        %347 = OpLoad %152 %346
        %348 = OpFAdd %152 %347 %345
        %349 = OpAccessChain %213 %205 %212
               OpStore %349 %348
               OpBranch %342
        %342 = OpLabel
        %352 = OpLoad %203 %205
        %353 = OpExtInst %203 %1 Normalize %352
        %354 = OpCompositeExtract %152 %353 0
        %355 = OpCompositeExtract %152 %353 1
        %356 = OpCompositeExtract %152 %353 2
        %357 = OpCompositeConstruct %153 %354 %355 %356 %159
               OpStore %351 %357
        %361 = OpLoad %153 %157
        %362 = OpAccessChain %350 %360 %27
               OpStore %362 %361
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %2 None %8
          %9 = OpFunctionParameter %7
         %10 = OpFunctionParameter %7
         %12 = OpLabel
         %20 = OpVariable %7 Function
         %28 = OpLoad %6 %9
         %30 = OpAccessChain %29 %26 %27 %28
         %31 = OpLoad %6 %30
               OpStore %20 %31
         %32 = OpLoad %6 %9
         %33 = OpLoad %6 %10
         %34 = OpAccessChain %29 %26 %27 %33
         %35 = OpLoad %6 %34
         %36 = OpAccessChain %29 %26 %27 %32
               OpStore %36 %35
         %37 = OpLoad %6 %10
         %38 = OpLoad %6 %20
         %39 = OpAccessChain %29 %26 %27 %37
               OpStore %39 %38
               OpReturn
               OpFunctionEnd
         %16 = OpFunction %6 None %13
         %14 = OpFunctionParameter %7
         %15 = OpFunctionParameter %7
         %17 = OpLabel
         %40 = OpVariable %7 Function
         %44 = OpVariable %7 Function
         %48 = OpVariable %7 Function
         %69 = OpVariable %7 Function
         %71 = OpVariable %7 Function
         %78 = OpVariable %7 Function
         %79 = OpVariable %7 Function
         %41 = OpLoad %6 %15
         %42 = OpAccessChain %29 %26 %27 %41
         %43 = OpLoad %6 %42
               OpStore %40 %43
         %45 = OpLoad %6 %14
         %47 = OpISub %6 %45 %46
               OpStore %44 %47
         %49 = OpLoad %6 %14
               OpStore %48 %49
               OpBranch %50
         %50 = OpLabel
               OpLoopMerge %52 %53 None
               OpBranch %54
         %54 = OpLabel
         %55 = OpLoad %6 %48
         %56 = OpLoad %6 %15
         %57 = OpISub %6 %56 %46
         %59 = OpSLessThanEqual %58 %55 %57
               OpBranchConditional %59 %51 %52
         %51 = OpLabel
         %60 = OpLoad %6 %48
         %61 = OpAccessChain %29 %26 %27 %60
         %62 = OpLoad %6 %61
         %63 = OpLoad %6 %40
         %64 = OpSLessThanEqual %58 %62 %63
               OpSelectionMerge %66 None
               OpBranchConditional %64 %65 %66
         %65 = OpLabel
         %67 = OpLoad %6 %44
         %68 = OpIAdd %6 %67 %46
               OpStore %44 %68
         %70 = OpLoad %6 %44
               OpStore %69 %70
         %72 = OpLoad %6 %48
               OpStore %71 %72
         %73 = OpFunctionCall %2 %11 %69 %71
               OpBranch %66
         %66 = OpLabel
               OpBranch %53
         %53 = OpLabel
         %74 = OpLoad %6 %48
         %75 = OpIAdd %6 %74 %46
               OpStore %48 %75
               OpBranch %50
         %52 = OpLabel
         %76 = OpLoad %6 %44
         %77 = OpIAdd %6 %76 %46
               OpStore %78 %77
         %80 = OpLoad %6 %15
               OpStore %79 %80
         %81 = OpFunctionCall %2 %11 %78 %79
         %82 = OpLoad %6 %44
         %83 = OpIAdd %6 %82 %46
               OpReturnValue %83
               OpFunctionEnd
         %18 = OpFunction %2 None %3
         %19 = OpLabel
         %86 = OpVariable %7 Function
         %87 = OpVariable %7 Function
         %89 = OpVariable %7 Function
         %92 = OpVariable %91 Function
        %116 = OpVariable %7 Function
        %117 = OpVariable %7 Function
        %119 = OpVariable %7 Function
               OpStore %86 %27
               OpStore %87 %88
               OpStore %89 %90
         %93 = OpLoad %6 %89
         %94 = OpIAdd %6 %93 %46
               OpStore %89 %94
         %95 = OpLoad %6 %86
         %96 = OpAccessChain %7 %92 %94
               OpStore %96 %95
         %97 = OpLoad %6 %89
         %98 = OpIAdd %6 %97 %46
               OpStore %89 %98
         %99 = OpLoad %6 %87
        %100 = OpAccessChain %7 %92 %98
               OpStore %100 %99
               OpBranch %101
        %101 = OpLabel
               OpLoopMerge %103 %104 None
               OpBranch %105
        %105 = OpLabel
        %106 = OpLoad %6 %89
        %107 = OpSGreaterThanEqual %58 %106 %27
               OpBranchConditional %107 %102 %103
        %102 = OpLabel
        %108 = OpLoad %6 %89
        %109 = OpISub %6 %108 %46
               OpStore %89 %109
        %110 = OpAccessChain %7 %92 %108
        %111 = OpLoad %6 %110
               OpStore %87 %111
        %112 = OpLoad %6 %89
        %113 = OpISub %6 %112 %46
               OpStore %89 %113
        %114 = OpAccessChain %7 %92 %112
        %115 = OpLoad %6 %114
               OpStore %86 %115
        %118 = OpLoad %6 %86
               OpStore %117 %118
        %120 = OpLoad %6 %87
               OpStore %119 %120
        %121 = OpFunctionCall %6 %16 %117 %119
               OpStore %116 %121
        %122 = OpLoad %6 %116
        %123 = OpISub %6 %122 %46
        %124 = OpLoad %6 %86
        %125 = OpSGreaterThan %58 %123 %124
               OpSelectionMerge %127 None
               OpBranchConditional %125 %126 %127
        %126 = OpLabel
        %128 = OpLoad %6 %89
        %129 = OpIAdd %6 %128 %46
               OpStore %89 %129
        %130 = OpLoad %6 %86
        %131 = OpAccessChain %7 %92 %129
               OpStore %131 %130
        %132 = OpLoad %6 %89
        %133 = OpIAdd %6 %132 %46
               OpStore %89 %133
        %134 = OpLoad %6 %116
        %135 = OpISub %6 %134 %46
        %136 = OpAccessChain %7 %92 %133
               OpStore %136 %135
               OpBranch %127
        %127 = OpLabel
        %137 = OpLoad %6 %116
        %138 = OpIAdd %6 %137 %46
        %139 = OpLoad %6 %87
        %140 = OpSLessThan %58 %138 %139
               OpSelectionMerge %142 None
               OpBranchConditional %140 %141 %142
        %141 = OpLabel
        %143 = OpLoad %6 %89
        %144 = OpIAdd %6 %143 %46
               OpStore %89 %144
        %145 = OpLoad %6 %116
        %146 = OpIAdd %6 %145 %46
        %147 = OpAccessChain %7 %92 %144
               OpStore %147 %146
        %148 = OpLoad %6 %89
        %149 = OpIAdd %6 %148 %46
               OpStore %89 %149
        %150 = OpLoad %6 %87
        %151 = OpAccessChain %7 %92 %149
               OpStore %151 %150
               OpBranch %142
        %142 = OpLabel
               OpBranch %104
        %104 = OpLabel
               OpBranch %101
        %103 = OpLabel
               OpReturn
               OpFunctionEnd
