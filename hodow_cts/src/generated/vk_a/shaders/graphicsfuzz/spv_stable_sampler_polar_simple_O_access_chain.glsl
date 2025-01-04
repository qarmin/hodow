#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 254
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %115 %130
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %115 "gl_FragCoord"
               OpName %130 "_GLF_color"
               OpName %134 "tex"
               OpDecorate %115 BuiltIn FragCoord
               OpDecorate %130 Location 0
               OpDecorate %134 RelaxedPrecision
               OpDecorate %134 DescriptorSet 0
               OpDecorate %134 Binding 0
               OpDecorate %135 RelaxedPrecision
               OpDecorate %137 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
         %19 = OpConstant %6 0.318309873
         %22 = OpConstant %6 0.00100000005
         %23 = OpTypeBool
         %27 = OpConstant %6 0
         %32 = OpTypeInt 32 0
         %36 = OpConstant %32 0
         %55 = OpConstant %6 0.970000029
         %56 = OpConstant %6 0.189999998
         %73 = OpConstant %6 0.5
         %81 = OpConstant %6 1
         %98 = OpConstantComposite %7 %73 %73
        %113 = OpTypeVector %6 4
        %114 = OpTypePointer Input %113
        %115 = OpVariable %114 Input
        %118 = OpConstant %6 0.00390625
        %124 = OpConstant %6 256
        %129 = OpTypePointer Output %113
        %130 = OpVariable %129 Output
        %131 = OpTypeImage %6 2D 0 0 0 1 Unknown
        %132 = OpTypeSampledImage %131
        %133 = OpTypePointer UniformConstant %132
        %134 = OpVariable %133 UniformConstant
        %253 = OpConstantComposite %7 %118 %118
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %116 = OpLoad %113 %115
        %117 = OpVectorShuffle %7 %116 %116 0 1
        %119 = OpVectorTimesScalar %7 %117 %118
        %160 = OpFSub %7 %119 %98
        %162 = OpExtInst %6 %1 Length %160
               OpSelectionMerge %235 None
               OpSwitch %36 %176
        %176 = OpLabel
        %179 = OpFOrdLessThan %23 %162 %22
               OpSelectionMerge %181 None
               OpBranchConditional %179 %180 %181
        %180 = OpLabel
               OpBranch %235
        %181 = OpLabel
        %183 = OpExtInst %7 %1 FAbs %160
        %185 = OpCompositeExtract %6 %183 1
        %187 = OpCompositeExtract %6 %183 0
        %188 = OpFOrdGreaterThan %23 %185 %187
               OpSelectionMerge %201 None
               OpBranchConditional %188 %189 %195
        %189 = OpLabel
        %194 = OpFDiv %6 %187 %185
               OpBranch %201
        %195 = OpLabel
        %200 = OpFDiv %6 %185 %187
               OpBranch %201
        %201 = OpLabel
        %247 = OpPhi %6 %194 %189 %200 %195
        %203 = OpFMul %6 %56 %247
        %205 = OpFMul %6 %203 %247
        %206 = OpFSub %6 %55 %205
        %208 = OpFMul %6 %206 %247
        %210 = OpFMul %6 %208 %19
        %215 = OpFOrdLessThan %23 %185 %187
               OpSelectionMerge %219 None
               OpBranchConditional %215 %216 %219
        %216 = OpLabel
        %218 = OpFSub %6 %73 %210
               OpBranch %219
        %219 = OpLabel
        %248 = OpPhi %6 %210 %201 %218 %216
        %221 = OpCompositeExtract %6 %160 0
        %222 = OpFOrdLessThan %23 %221 %27
               OpSelectionMerge %226 None
               OpBranchConditional %222 %223 %226
        %223 = OpLabel
        %225 = OpFSub %6 %81 %248
               OpBranch %226
        %226 = OpLabel
        %249 = OpPhi %6 %248 %219 %225 %223
        %228 = OpCompositeExtract %6 %160 1
        %229 = OpFOrdLessThan %23 %228 %27
               OpSelectionMerge %233 None
               OpBranchConditional %229 %230 %233
        %230 = OpLabel
        %232 = OpFNegate %6 %249
               OpBranch %233
        %233 = OpLabel
        %250 = OpPhi %6 %249 %226 %232 %230
               OpBranch %235
        %235 = OpLabel
        %251 = OpPhi %6 %27 %180 %250 %233
        %167 = OpCompositeConstruct %7 %162 %251
        %125 = OpVectorTimesScalar %7 %167 %124
        %126 = OpExtInst %7 %1 Floor %125
        %128 = OpFMul %7 %126 %253
        %135 = OpLoad %132 %134
        %137 = OpImageSampleImplicitLod %113 %135 %128
        %140 = OpCompositeExtract %6 %137 0
        %141 = OpCompositeExtract %6 %137 1
        %142 = OpCompositeExtract %6 %137 2
        %143 = OpCompositeConstruct %113 %140 %141 %142 %81
               OpStore %130 %143
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 529
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %115 %130
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %115 "gl_FragCoord"
               OpName %130 "_GLF_color"
               OpName %134 "tex"
               OpDecorate %115 BuiltIn FragCoord
               OpDecorate %130 Location 0
               OpDecorate %134 RelaxedPrecision
               OpDecorate %134 DescriptorSet 0
               OpDecorate %134 Binding 0
               OpDecorate %135 RelaxedPrecision
               OpDecorate %137 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
         %19 = OpConstant %6 0.318309873
         %22 = OpConstant %6 0.00100000005
         %23 = OpTypeBool
         %27 = OpConstant %6 0
         %32 = OpTypeInt 32 0
         %36 = OpConstant %32 0
         %55 = OpConstant %6 0.970000029
         %56 = OpConstant %6 0.189999998
         %73 = OpConstant %6 0.5
         %81 = OpConstant %6 1
         %98 = OpConstantComposite %7 %73 %73
        %113 = OpTypeVector %6 4
        %114 = OpTypePointer Input %113
        %115 = OpVariable %114 Input
        %118 = OpConstant %6 0.00390625
        %124 = OpConstant %6 256
        %129 = OpTypePointer Output %113
        %130 = OpVariable %129 Output
        %131 = OpTypeImage %6 2D 0 0 0 1 Unknown
        %132 = OpTypeSampledImage %131
        %133 = OpTypePointer UniformConstant %132
        %134 = OpVariable %133 UniformConstant
        %253 = OpConstantComposite %7 %118 %118
        %379 = OpTypeInt 32 1
        %380 = OpConstant %379 3
        %383 = OpConstant %379 0
        %384 = OpTypePointer Input %6
        %475 = OpConstantFalse %23
        %526 = OpTypePointer Function %23
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %527 = OpVariable %526 Function %475
        %116 = OpLoad %113 %115
        %117 = OpVectorShuffle %7 %116 %116 0 1
        %119 = OpVectorTimesScalar %7 %117 %118
        %160 = OpFSub %7 %119 %98
        %162 = OpExtInst %6 %1 Length %160
               OpSelectionMerge %235 None
               OpSwitch %36 %176
        %176 = OpLabel
        %179 = OpFOrdLessThan %23 %162 %22
               OpSelectionMerge %181 None
               OpBranchConditional %179 %180 %181
        %180 = OpLabel
               OpBranch %235
        %181 = OpLabel
        %183 = OpExtInst %7 %1 FAbs %160
        %185 = OpCompositeExtract %6 %183 1
        %187 = OpCompositeExtract %6 %183 0
        %188 = OpFOrdGreaterThan %23 %185 %187
               OpSelectionMerge %201 None
               OpBranchConditional %188 %189 %195
        %189 = OpLabel
        %194 = OpFDiv %6 %187 %185
               OpBranch %201
        %195 = OpLabel
        %200 = OpFDiv %6 %185 %187
               OpBranch %201
        %201 = OpLabel
        %247 = OpPhi %6 %194 %189 %200 %195
        %203 = OpFMul %6 %56 %247
        %205 = OpFMul %6 %203 %247
        %206 = OpFSub %6 %55 %205
        %208 = OpFMul %6 %206 %247
        %210 = OpFMul %6 %208 %19
        %215 = OpFOrdLessThan %23 %185 %187
               OpSelectionMerge %219 None
               OpBranchConditional %215 %216 %219
        %216 = OpLabel
        %218 = OpFSub %6 %73 %210
               OpBranch %219
        %219 = OpLabel
        %248 = OpPhi %6 %210 %201 %218 %216
        %221 = OpCompositeExtract %6 %160 0
        %222 = OpFOrdLessThan %23 %221 %27
               OpSelectionMerge %226 None
               OpBranchConditional %222 %223 %226
        %223 = OpLabel
        %225 = OpFSub %6 %81 %248
               OpBranch %226
        %226 = OpLabel
        %249 = OpPhi %6 %248 %219 %225 %223
        %228 = OpCompositeExtract %6 %160 1
        %229 = OpFOrdLessThan %23 %228 %27
               OpSelectionMerge %233 None
               OpBranchConditional %229 %230 %233
        %230 = OpLabel
        %232 = OpFNegate %6 %249
               OpBranch %233
        %233 = OpLabel
        %250 = OpPhi %6 %249 %226 %232 %230
               OpBranch %235
        %235 = OpLabel
        %251 = OpPhi %6 %27 %180 %250 %233
        %167 = OpCompositeConstruct %7 %162 %251
        %125 = OpVectorTimesScalar %7 %167 %124
        %126 = OpExtInst %7 %1 Floor %125
        %128 = OpFMul %7 %126 %253
        %135 = OpLoad %132 %134
        %137 = OpImageSampleImplicitLod %113 %135 %128
        %140 = OpCompositeExtract %6 %137 0
        %141 = OpCompositeExtract %6 %137 1
        %142 = OpCompositeExtract %6 %137 2
               OpStore %527 %179
        %528 = OpLoad %23 %527
        %381 = OpULessThanEqual %23 %383 %380
        %382 = OpSelect %379 %381 %383 %380
        %385 = OpAccessChain %384 %115 %382
        %143 = OpCompositeConstruct %113 %140 %141 %142 %81
               OpStore %130 %143
               OpReturn
               OpFunctionEnd
