#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 270
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %17 %154
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %17 "gl_FragCoord"
               OpName %55 "buf0"
               OpMemberName %55 0 "injectionSwitch"
               OpName %57 ""
               OpName %101 "data"
               OpName %154 "_GLF_color"
               OpDecorate %17 BuiltIn FragCoord
               OpMemberDecorate %55 0 Offset 0
               OpDecorate %55 Block
               OpDecorate %57 DescriptorSet 0
               OpDecorate %57 Binding 0
               OpDecorate %128 RelaxedPrecision
               OpDecorate %130 RelaxedPrecision
               OpDecorate %142 RelaxedPrecision
               OpDecorate %144 RelaxedPrecision
               OpDecorate %154 Location 0
               OpDecorate %228 RelaxedPrecision
               OpDecorate %230 RelaxedPrecision
               OpDecorate %240 RelaxedPrecision
               OpDecorate %241 RelaxedPrecision
               OpDecorate %243 RelaxedPrecision
               OpDecorate %253 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
         %11 = OpTypeInt 32 1
         %14 = OpConstant %11 0
         %15 = OpTypeVector %6 4
         %16 = OpTypePointer Input %15
         %17 = OpVariable %16 Input
         %18 = OpTypeInt 32 0
         %19 = OpConstant %18 1
         %20 = OpTypePointer Input %6
         %23 = OpConstant %6 0
         %24 = OpTypeBool
         %28 = OpConstant %6 1
         %29 = OpConstantComposite %7 %28 %28 %28
         %38 = OpConstant %11 50
         %50 = OpConstant %6 4
         %54 = OpTypeVector %6 2
         %55 = OpTypeStruct %54
         %56 = OpTypePointer Uniform %55
         %57 = OpVariable %56 Uniform
         %58 = OpConstant %18 0
         %59 = OpTypePointer Uniform %6
         %78 = OpConstant %6 2
         %84 = OpConstant %11 1
         %90 = OpTypePointer Function %7
         %98 = OpConstant %18 16
         %99 = OpTypeArray %7 %98
        %100 = OpTypePointer Function %99
        %102 = OpConstantComposite %7 %23 %23 %23
        %111 = OpConstant %11 4
        %147 = OpConstantComposite %15 %28 %23 %23 %28
        %153 = OpTypePointer Output %15
        %154 = OpVariable %153 Output
        %248 = OpUndef %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %101 = OpVariable %100 Function
        %103 = OpAccessChain %90 %101 %84
               OpStore %103 %102
               OpBranch %105
        %105 = OpLabel
        %240 = OpPhi %11 %14 %5 %144 %122
        %252 = OpPhi %6 %248 %5 %251 %122
        %247 = OpPhi %6 %248 %5 %246 %122
        %112 = OpSLessThan %24 %240 %111
               OpLoopMerge %107 %122 None
               OpBranchConditional %112 %106 %107
        %106 = OpLabel
        %113 = OpAccessChain %59 %57 %14 %58
        %114 = OpLoad %6 %113
        %115 = OpFOrdLessThan %24 %114 %28
               OpSelectionMerge %117 None
               OpBranchConditional %115 %116 %117
        %116 = OpLabel
               OpBranch %107
        %117 = OpLabel
               OpBranch %120
        %120 = OpLabel
        %251 = OpPhi %6 %252 %117 %266 %139
        %246 = OpPhi %6 %247 %117 %264 %139
        %241 = OpPhi %11 %14 %117 %142 %139
        %126 = OpSLessThan %24 %241 %111
               OpLoopMerge %267 %139 None
               OpBranchConditional %126 %121 %267
        %121 = OpLabel
        %128 = OpIMul %11 %111 %241
        %130 = OpIAdd %11 %128 %240
               OpBranch %181
        %181 = OpLabel
               OpLoopMerge %182 %183 None
               OpBranch %184
        %184 = OpLabel
        %185 = OpAccessChain %20 %17 %19
        %186 = OpLoad %6 %185
        %187 = OpFOrdLessThan %24 %186 %23
               OpSelectionMerge %188 None
               OpBranchConditional %187 %189 %188
        %189 = OpLabel
               OpBranch %182
        %188 = OpLabel
               OpBranch %190
        %190 = OpLabel
        %253 = OpPhi %11 %14 %188 %228 %220
        %249 = OpPhi %6 %251 %188 %225 %220
        %244 = OpPhi %6 %246 %188 %216 %220
        %243 = OpPhi %11 %14 %188 %230 %220
        %195 = OpSLessThan %24 %243 %38
               OpLoopMerge %191 %220 None
               OpBranchConditional %195 %196 %191
        %196 = OpLabel
        %199 = OpFMul %6 %244 %244
        %202 = OpFMul %6 %249 %249
        %203 = OpFAdd %6 %199 %202
        %204 = OpFOrdGreaterThan %24 %203 %50
               OpSelectionMerge %205 None
               OpBranchConditional %204 %206 %205
        %206 = OpLabel
        %209 = OpAccessChain %59 %57 %14 %19
        %210 = OpLoad %6 %209
        %211 = OpFOrdGreaterThan %24 %114 %210
               OpSelectionMerge %212 None
               OpBranchConditional %211 %213 %212
        %213 = OpLabel
               OpTerminateInvocation
        %212 = OpLabel
               OpBranch %191
        %205 = OpLabel
        %216 = OpFSub %6 %28 %249
        %217 = OpAccessChain %20 %17 %58
        %218 = OpLoad %6 %217
        %219 = OpFOrdLessThan %24 %218 %23
               OpSelectionMerge %269 None
               OpBranchConditional %219 %221 %220
        %221 = OpLabel
               OpTerminateInvocation
        %269 = OpLabel
               OpBranch %220
        %220 = OpLabel
        %224 = OpFMul %6 %78 %249
        %225 = OpFAdd %6 %224 %28
        %228 = OpIAdd %11 %253 %84
        %230 = OpIAdd %11 %243 %84
               OpBranch %190
        %191 = OpLabel
        %233 = OpConvertSToF %6 %253
        %234 = OpCompositeConstruct %7 %28 %28 %233
               OpBranch %182
        %183 = OpLabel
               OpBranch %181
        %182 = OpLabel
        %266 = OpPhi %6 %251 %189 %249 %191
        %264 = OpPhi %6 %246 %189 %244 %191
        %255 = OpPhi %7 %29 %189 %234 %191
        %132 = OpAccessChain %90 %101 %130
               OpStore %132 %255
        %135 = OpAccessChain %59 %57 %14 %19
        %136 = OpLoad %6 %135
        %137 = OpFOrdGreaterThan %24 %114 %136
               OpSelectionMerge %268 None
               OpBranchConditional %137 %138 %139
        %138 = OpLabel
               OpTerminateInvocation
        %268 = OpLabel
               OpBranch %139
        %139 = OpLabel
        %142 = OpIAdd %11 %241 %84
               OpBranch %120
        %267 = OpLabel
               OpBranch %122
        %122 = OpLabel
        %144 = OpIAdd %11 %240 %84
               OpBranch %105
        %107 = OpLabel
        %149 = OpLoad %7 %103
        %150 = OpVectorShuffle %15 %149 %149 0 0 1 2
        %152 = OpFAdd %15 %147 %150
               OpStore %154 %152
               OpReturn
               OpFunctionEnd
