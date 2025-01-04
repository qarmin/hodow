#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 358
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %13 %117
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %13 "_GLF_color"
               OpName %21 "sums"
               OpName %117 "gl_FragCoord"
               OpName %129 "buf0"
               OpMemberName %129 0 "zero"
               OpName %131 ""
               OpDecorate %13 Location 0
               OpDecorate %117 BuiltIn FragCoord
               OpMemberDecorate %129 0 Offset 0
               OpDecorate %129 Block
               OpDecorate %131 DescriptorSet 0
               OpDecorate %131 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %9 = OpConstant %6 0
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 4
         %12 = OpTypePointer Output %11
         %13 = OpVariable %12 Output
         %14 = OpConstant %10 0
         %15 = OpConstant %10 1
         %16 = OpConstantComposite %11 %14 %14 %14 %15
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 9
         %19 = OpTypeArray %10 %18
         %20 = OpTypePointer Function %19
         %22 = OpTypePointer Function %10
         %25 = OpConstant %6 2
         %32 = OpConstant %6 5
         %33 = OpTypeBool
         %42 = OpConstant %6 4
        %112 = OpConstant %6 1
        %116 = OpTypePointer Input %11
        %117 = OpVariable %116 Input
        %118 = OpConstant %17 1
        %119 = OpTypePointer Input %10
        %129 = OpTypeStruct %10
        %130 = OpTypePointer Uniform %129
        %131 = OpVariable %130 Uniform
        %132 = OpTypePointer Uniform %10
        %193 = OpTypePointer Output %10
        %225 = OpConstant %17 0
        %265 = OpConstantComposite %11 %14 %14 %14 %14
        %267 = OpConstantComposite %11 %15 %15 %15 %15
        %272 = OpConstantFalse %33
        %275 = OpConstantTrue %33
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %21 = OpVariable %20 Function
               OpBranch %269
        %269 = OpLabel
               OpStore %13 %16
         %23 = OpAccessChain %22 %21 %9
               OpStore %23 %14
               OpLoopMerge %268 %271 None
               OpBranch %26
         %26 = OpLabel
        %300 = OpPhi %33 %272 %269 %312 %29
        %295 = OpPhi %6 %9 %269 %356 %29
        %284 = OpPhi %6 %25 %269 %259 %29
         %34 = OpSLessThan %33 %284 %32
               OpLoopMerge %28 %29 None
               OpBranchConditional %34 %27 %28
         %27 = OpLabel
               OpBranch %36
         %36 = OpLabel
        %299 = OpPhi %33 %300 %27 %304 %39
        %294 = OpPhi %6 %295 %27 %357 %39
        %285 = OpPhi %6 %25 %27 %151 %39
         %43 = OpSLessThan %33 %285 %42
               OpLoopMerge %38 %39 None
               OpBranchConditional %43 %37 %38
         %37 = OpLabel
               OpBranch %45
         %45 = OpLabel
        %298 = OpPhi %33 %299 %37 %296 %48
        %286 = OpPhi %6 %9 %37 %115 %48
         %52 = OpSLessThan %33 %286 %284
               OpLoopMerge %47 %48 None
               OpBranchConditional %52 %46 %47
         %46 = OpLabel
               OpBranch %54
         %54 = OpLabel
        %289 = OpPhi %6 %9 %46 %113 %57
         %61 = OpSLessThan %33 %289 %285
               OpLoopMerge %56 %57 None
               OpBranchConditional %61 %55 %56
         %55 = OpLabel
               OpSelectionMerge %72 None
               OpSwitch %294 %72 0 %63 1 %64 2 %65 3 %66 4 %67 5 %68 6 %69 7 %70 8 %71
         %63 = OpLabel
         %74 = OpAccessChain %22 %21 %294
         %75 = OpLoad %10 %74
         %76 = OpFAdd %10 %75 %15
               OpStore %74 %76
               OpBranch %72
         %64 = OpLabel
         %79 = OpAccessChain %22 %21 %294
         %80 = OpLoad %10 %79
         %81 = OpFAdd %10 %80 %15
               OpStore %79 %81
               OpBranch %72
         %65 = OpLabel
         %84 = OpAccessChain %22 %21 %294
         %85 = OpLoad %10 %84
         %86 = OpFAdd %10 %85 %15
               OpStore %84 %86
               OpBranch %66
         %66 = OpLabel
         %88 = OpAccessChain %22 %21 %294
         %89 = OpLoad %10 %88
         %90 = OpFAdd %10 %89 %15
               OpStore %88 %90
               OpBranch %67
         %67 = OpLabel
         %92 = OpAccessChain %22 %21 %294
         %93 = OpLoad %10 %92
         %94 = OpFAdd %10 %93 %15
               OpStore %92 %94
               OpBranch %68
         %68 = OpLabel
         %96 = OpAccessChain %22 %21 %294
         %97 = OpLoad %10 %96
         %98 = OpFAdd %10 %97 %15
               OpStore %96 %98
               OpBranch %72
         %69 = OpLabel
               OpBranch %56
         %70 = OpLabel
        %102 = OpAccessChain %22 %21 %294
        %103 = OpLoad %10 %102
        %104 = OpFAdd %10 %103 %15
               OpStore %102 %104
               OpBranch %72
         %71 = OpLabel
        %107 = OpAccessChain %22 %21 %294
        %108 = OpLoad %10 %107
        %109 = OpFAdd %10 %108 %15
               OpStore %107 %109
               OpBranch %72
         %72 = OpLabel
               OpBranch %57
         %57 = OpLabel
        %113 = OpIAdd %6 %289 %112
               OpBranch %54
         %56 = OpLabel
        %296 = OpPhi %33 %298 %54 %275 %69
               OpSelectionMerge %276 None
               OpBranchConditional %296 %47 %276
        %276 = OpLabel
               OpBranch %48
         %48 = OpLabel
        %115 = OpIAdd %6 %286 %112
               OpBranch %45
         %47 = OpLabel
        %304 = OpPhi %33 %298 %45 %296 %56
               OpSelectionMerge %278 None
               OpBranchConditional %304 %38 %278
        %278 = OpLabel
        %120 = OpAccessChain %119 %117 %118
        %121 = OpLoad %10 %120
        %124 = OpExtInst %10 %1 FClamp %15 %121 %121
        %125 = OpFOrdLessThan %33 %124 %14
               OpSelectionMerge %127 None
               OpBranchConditional %125 %126 %127
        %126 = OpLabel
               OpBranch %39
        %127 = OpLabel
        %133 = OpAccessChain %132 %131 %9
        %134 = OpLoad %10 %133
        %135 = OpFOrdLessThan %33 %134 %14
               OpSelectionMerge %137 None
               OpBranchConditional %135 %136 %137
        %136 = OpLabel
        %139 = OpAccessChain %22 %21 %294
        %140 = OpLoad %10 %139
        %141 = OpFAdd %10 %140 %15
               OpStore %139 %141
               OpBranch %137
        %137 = OpLabel
        %144 = OpFOrdLessThan %33 %121 %14
               OpSelectionMerge %146 None
               OpBranchConditional %144 %145 %146
        %145 = OpLabel
               OpTerminateInvocation
        %146 = OpLabel
        %149 = OpIAdd %6 %294 %112
               OpBranch %39
         %39 = OpLabel
        %357 = OpPhi %6 %294 %126 %149 %146
        %151 = OpIAdd %6 %285 %112
               OpBranch %36
         %38 = OpLabel
        %312 = OpPhi %33 %299 %36 %304 %47
               OpSelectionMerge %280 None
               OpBranchConditional %312 %28 %280
        %280 = OpLabel
               OpBranch %153
        %153 = OpLabel
        %322 = OpPhi %6 %294 %280 %249 %156
        %313 = OpPhi %6 %42 %280 %257 %156
        %159 = OpSLessThan %33 %313 %32
               OpLoopMerge %155 %156 None
               OpBranchConditional %159 %154 %155
        %154 = OpLabel
               OpBranch %161
        %161 = OpLabel
        %314 = OpPhi %6 %9 %154 %247 %164
        %168 = OpSLessThan %33 %314 %284
               OpLoopMerge %163 %164 None
               OpBranchConditional %168 %162 %163
        %162 = OpLabel
               OpBranch %170
        %170 = OpLabel
        %326 = OpPhi %6 %9 %162 %245 %173
        %177 = OpSLessThan %33 %326 %313
               OpLoopMerge %172 %173 None
               OpBranchConditional %177 %171 %172
        %171 = OpLabel
               OpSelectionMerge %188 None
               OpSwitch %322 %188 0 %179 1 %180 2 %181 3 %182 4 %183 5 %184 6 %185 7 %186 8 %187
        %179 = OpLabel
        %190 = OpAccessChain %22 %21 %322
        %191 = OpLoad %10 %190
        %192 = OpFAdd %10 %191 %15
               OpStore %190 %192
        %194 = OpAccessChain %193 %13 %118
               OpStore %194 %15
               OpBranch %180
        %180 = OpLabel
        %196 = OpAccessChain %22 %21 %322
        %197 = OpLoad %10 %196
        %198 = OpFAdd %10 %197 %15
               OpStore %196 %198
        %199 = OpAccessChain %193 %13 %118
               OpStore %199 %15
               OpBranch %181
        %181 = OpLabel
        %201 = OpAccessChain %22 %21 %322
        %202 = OpLoad %10 %201
        %203 = OpFAdd %10 %202 %15
               OpStore %201 %203
               OpBranch %188
        %182 = OpLabel
        %206 = OpAccessChain %22 %21 %322
        %207 = OpLoad %10 %206
        %208 = OpFAdd %10 %207 %15
               OpStore %206 %208
        %209 = OpAccessChain %193 %13 %118
               OpStore %209 %15
               OpBranch %183
        %183 = OpLabel
        %211 = OpAccessChain %22 %21 %322
        %212 = OpLoad %10 %211
        %213 = OpFAdd %10 %212 %15
               OpStore %211 %213
        %214 = OpAccessChain %193 %13 %118
               OpStore %214 %15
               OpBranch %188
        %184 = OpLabel
        %217 = OpAccessChain %22 %21 %322
        %218 = OpLoad %10 %217
        %219 = OpFAdd %10 %218 %15
               OpStore %217 %219
        %221 = OpLoad %10 %23
        %222 = OpFOrdNotEqual %33 %221 %14
               OpSelectionMerge %224 None
               OpBranchConditional %222 %223 %224
        %223 = OpLabel
        %226 = OpAccessChain %193 %13 %225
               OpStore %226 %15
               OpBranch %224
        %224 = OpLabel
               OpBranch %188
        %185 = OpLabel
        %229 = OpAccessChain %22 %21 %322
        %230 = OpLoad %10 %229
        %231 = OpFAdd %10 %230 %15
               OpStore %229 %231
        %232 = OpAccessChain %193 %13 %118
               OpStore %232 %15
               OpBranch %186
        %186 = OpLabel
        %234 = OpAccessChain %22 %21 %322
        %235 = OpLoad %10 %234
        %236 = OpFAdd %10 %235 %15
               OpStore %234 %236
        %237 = OpAccessChain %193 %13 %118
               OpStore %237 %15
               OpBranch %187
        %187 = OpLabel
        %239 = OpAccessChain %22 %21 %322
        %240 = OpLoad %10 %239
        %241 = OpFAdd %10 %240 %15
               OpStore %239 %241
        %242 = OpAccessChain %193 %13 %118
               OpStore %242 %15
               OpBranch %188
        %188 = OpLabel
               OpBranch %173
        %173 = OpLabel
        %245 = OpIAdd %6 %326 %112
               OpBranch %170
        %172 = OpLabel
               OpBranch %164
        %164 = OpLabel
        %247 = OpIAdd %6 %314 %112
               OpBranch %161
        %163 = OpLabel
        %249 = OpIAdd %6 %322 %112
        %250 = OpAccessChain %132 %131 %9
        %251 = OpLoad %10 %250
        %252 = OpFOrdLessThan %33 %251 %15
               OpSelectionMerge %254 None
               OpBranchConditional %252 %253 %254
        %253 = OpLabel
               OpBranch %155
        %254 = OpLabel
               OpBranch %156
        %156 = OpLabel
        %257 = OpIAdd %6 %313 %112
               OpBranch %153
        %155 = OpLabel
        %356 = OpPhi %6 %322 %153 %249 %253
               OpBranch %29
         %29 = OpLabel
        %259 = OpIAdd %6 %284 %112
               OpBranch %26
         %28 = OpLabel
        %342 = OpPhi %33 %300 %26 %312 %38
               OpSelectionMerge %282 None
               OpBranchConditional %342 %268 %282
        %282 = OpLabel
        %261 = OpLoad %10 %23
        %262 = OpFOrdEqual %33 %261 %14
               OpSelectionMerge %264 None
               OpBranchConditional %262 %263 %266
        %263 = OpLabel
               OpStore %13 %265
               OpBranch %264
        %266 = OpLabel
               OpStore %13 %267
               OpBranch %264
        %264 = OpLabel
               OpBranch %268
        %271 = OpLabel
               OpBranch %269
        %268 = OpLabel
               OpReturn
               OpFunctionEnd
