#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 319
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %84 %169
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %20 "buf1"
               OpMemberName %20 0 "_GLF_uniform_int_values"
               OpName %22 ""
               OpName %44 "buf0"
               OpMemberName %44 0 "_GLF_uniform_float_values"
               OpName %46 ""
               OpName %84 "gl_FragCoord"
               OpName %169 "_GLF_color"
               OpDecorate %19 ArrayStride 16
               OpMemberDecorate %20 0 Offset 0
               OpDecorate %20 Block
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 1
               OpDecorate %43 ArrayStride 16
               OpMemberDecorate %44 0 Offset 0
               OpDecorate %44 Block
               OpDecorate %46 DescriptorSet 0
               OpDecorate %46 Binding 0
               OpDecorate %84 BuiltIn FragCoord
               OpDecorate %169 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %9 = OpTypeVector %6 3
         %14 = OpTypeInt 32 1
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 3
         %19 = OpTypeArray %14 %18
         %20 = OpTypeStruct %19
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpConstant %14 0
         %24 = OpTypePointer Uniform %14
         %33 = OpConstant %14 1
         %36 = OpTypeBool
         %38 = OpConstant %17 0
         %42 = OpConstant %17 2
         %43 = OpTypeArray %6 %42
         %44 = OpTypeStruct %43
         %45 = OpTypePointer Uniform %44
         %46 = OpVariable %45 Uniform
         %47 = OpTypePointer Uniform %6
         %70 = OpConstant %17 1
         %82 = OpTypeVector %6 4
         %83 = OpTypePointer Input %82
         %84 = OpVariable %83 Input
         %85 = OpTypePointer Input %6
         %88 = OpConstant %6 5
         %94 = OpConstant %6 0
         %99 = OpConstant %14 2
        %114 = OpConstantFalse %36
        %151 = OpTypeMatrix %7 2
        %163 = OpTypeVector %36 3
        %168 = OpTypePointer Output %82
        %169 = OpVariable %168 Output
        %195 = OpConstantTrue %36
        %312 = OpUndef %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %131
        %131 = OpLabel
        %135 = OpAccessChain %47 %46 %23 %33
        %136 = OpLoad %6 %135
        %137 = OpAccessChain %85 %84 %70
        %138 = OpLoad %6 %137
        %139 = OpFOrdLessThan %36 %138 %94
               OpLoopMerge %133 %131 None
               OpBranchConditional %139 %131 %133
        %133 = OpLabel
        %140 = OpAccessChain %47 %46 %23 %23
        %141 = OpLoad %6 %140
        %142 = OpCompositeConstruct %7 %141 %141
        %143 = OpAccessChain %24 %22 %23 %33
        %144 = OpLoad %14 %143
        %145 = OpConvertSToF %6 %144
        %153 = OpCompositeConstruct %7 %145 %136
        %155 = OpCompositeConstruct %151 %153 %153
        %156 = OpVectorTimesMatrix %7 %142 %155
               OpSelectionMerge %293 None
               OpSwitch %38 %208
        %208 = OpLabel
        %209 = OpAccessChain %24 %22 %23 %23
        %210 = OpLoad %14 %209
               OpBranch %211
        %211 = OpLabel
        %297 = OpPhi %14 %210 %208 %231 %229
        %216 = OpSLessThan %36 %297 %144
               OpLoopMerge %232 %229 None
               OpBranchConditional %216 %217 %232
        %217 = OpLabel
        %219 = OpCompositeExtract %6 %156 0
        %222 = OpFOrdLessThan %36 %219 %136
               OpSelectionMerge %228 None
               OpBranchConditional %222 %223 %228
        %223 = OpLabel
        %227 = OpCompositeConstruct %9 %145 %145 %145
               OpBranch %232
        %228 = OpLabel
               OpBranch %229
        %229 = OpLabel
        %231 = OpIAdd %14 %297 %33
               OpBranch %211
        %232 = OpLabel
        %309 = OpPhi %9 %312 %211 %227 %223
        %298 = OpPhi %36 %114 %211 %195 %223
               OpSelectionMerge %234 None
               OpBranchConditional %298 %293 %234
        %234 = OpLabel
               OpBranch %235
        %235 = OpLabel
        %303 = OpPhi %36 %298 %234 %318 %278
        %300 = OpPhi %14 %23 %234 %280 %278
        %314 = OpPhi %9 %309 %234 %315 %278
        %240 = OpSLessThan %36 %300 %144
               OpLoopMerge %281 %278 None
               OpBranchConditional %240 %241 %281
        %241 = OpLabel
        %243 = OpCompositeExtract %6 %156 1
        %246 = OpFOrdGreaterThan %36 %243 %136
               OpSelectionMerge %277 None
               OpBranchConditional %246 %247 %277
        %247 = OpLabel
               OpBranch %248
        %248 = OpLabel
               OpLoopMerge %274 %273 None
               OpBranch %249
        %249 = OpLabel
        %250 = OpAccessChain %85 %84 %38
        %251 = OpLoad %6 %250
        %252 = OpFOrdGreaterThan %36 %251 %88
               OpSelectionMerge %272 None
               OpBranchConditional %252 %253 %272
        %253 = OpLabel
        %257 = OpLogicalNot %36 %139
               OpSelectionMerge %271 None
               OpBranchConditional %257 %258 %266
        %266 = OpLabel
        %270 = OpCompositeConstruct %9 %145 %145 %145
               OpBranch %274
        %258 = OpLabel
        %263 = OpBitFieldSExtract %14 %99 %144 %144
        %264 = OpConvertSToF %6 %263
        %265 = OpCompositeConstruct %9 %264 %264 %264
               OpBranch %274
        %271 = OpLabel
               OpUnreachable
        %272 = OpLabel
               OpBranch %273
        %273 = OpLabel
               OpBranchConditional %114 %248 %274
        %274 = OpLabel
        %316 = OpPhi %9 %265 %258 %270 %266 %314 %273
        %301 = OpPhi %36 %195 %258 %195 %266 %303 %273
               OpSelectionMerge %276 None
               OpBranchConditional %301 %281 %276
        %276 = OpLabel
               OpBranch %277
        %277 = OpLabel
        %318 = OpPhi %36 %303 %241 %301 %276
        %315 = OpPhi %9 %314 %241 %316 %276
               OpBranch %278
        %278 = OpLabel
        %280 = OpIAdd %14 %300 %33
               OpBranch %235
        %281 = OpLabel
        %313 = OpPhi %9 %314 %235 %316 %274
        %307 = OpPhi %36 %303 %235 %301 %274
               OpSelectionMerge %283 None
               OpBranchConditional %307 %293 %283
        %283 = OpLabel
        %284 = OpAccessChain %24 %22 %23 %99
        %285 = OpLoad %14 %284
        %290 = OpBitFieldSExtract %14 %285 %144 %144
        %291 = OpConvertSToF %6 %290
        %292 = OpCompositeConstruct %9 %291 %291 %291
               OpBranch %293
        %293 = OpLabel
        %308 = OpPhi %9 %309 %232 %313 %281 %292 %283
        %162 = OpCompositeConstruct %9 %145 %145 %145
        %164 = OpFUnordNotEqual %163 %308 %162
        %165 = OpAny %36 %164
               OpSelectionMerge %167 None
               OpBranchConditional %165 %166 %183
        %183 = OpLabel
        %186 = OpConvertSToF %6 %210
        %187 = OpCompositeConstruct %82 %186 %186 %186 %186
               OpStore %169 %187
               OpBranch %167
        %166 = OpLabel
        %175 = OpConvertSToF %6 %210
        %182 = OpCompositeConstruct %82 %145 %175 %175 %145
               OpStore %169 %182
               OpBranch %167
        %167 = OpLabel
               OpReturn
               OpFunctionEnd
