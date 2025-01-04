#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 275
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %139
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %24 "buf2"
               OpMemberName %24 0 "injectionSwitch"
               OpName %26 ""
               OpName %35 "buf1"
               OpMemberName %35 0 "_GLF_uniform_float_values"
               OpName %37 ""
               OpName %61 "buf0"
               OpMemberName %61 0 "_GLF_uniform_int_values"
               OpName %63 ""
               OpName %139 "_GLF_color"
               OpMemberDecorate %24 0 Offset 0
               OpDecorate %24 Block
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 2
               OpDecorate %34 ArrayStride 16
               OpMemberDecorate %35 0 Offset 0
               OpDecorate %35 Block
               OpDecorate %37 DescriptorSet 0
               OpDecorate %37 Binding 1
               OpDecorate %60 ArrayStride 16
               OpMemberDecorate %61 0 Offset 0
               OpDecorate %61 Block
               OpDecorate %63 DescriptorSet 0
               OpDecorate %63 Binding 0
               OpDecorate %139 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
          %9 = OpTypeBool
         %14 = OpTypeInt 32 1
         %23 = OpTypeVector %6 2
         %24 = OpTypeStruct %23
         %25 = OpTypePointer Uniform %24
         %26 = OpVariable %25 Uniform
         %27 = OpConstant %14 0
         %28 = OpTypeInt 32 0
         %29 = OpConstant %28 0
         %30 = OpTypePointer Uniform %6
         %33 = OpConstant %28 2
         %34 = OpTypeArray %6 %33
         %35 = OpTypeStruct %34
         %36 = OpTypePointer Uniform %35
         %37 = OpVariable %36 Uniform
         %41 = OpConstantFalse %9
         %47 = OpConstant %14 1
         %54 = OpConstantTrue %9
         %59 = OpConstant %28 5
         %60 = OpTypeArray %14 %59
         %61 = OpTypeStruct %60
         %62 = OpTypePointer Uniform %61
         %63 = OpVariable %62 Uniform
         %64 = OpConstant %14 2
         %65 = OpTypePointer Uniform %14
         %69 = OpConstant %14 3
         %89 = OpConstant %14 4
        %114 = OpConstant %28 8
        %115 = OpTypeArray %7 %114
        %119 = OpTypePointer Function %115
        %138 = OpTypePointer Output %7
        %139 = OpVariable %138 Output
        %263 = OpUndef %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %169 = OpVariable %119 Function
        %172 = OpAccessChain %65 %63 %27 %64
        %173 = OpLoad %14 %172
        %174 = OpAccessChain %65 %63 %27 %69
        %175 = OpLoad %14 %174
               OpBranch %176
        %176 = OpLabel
        %262 = OpPhi %9 %263 %5 %259 %223
        %256 = OpPhi %14 %173 %5 %274 %223
        %255 = OpPhi %14 %175 %5 %225 %223
        %179 = OpAccessChain %65 %63 %27 %27
        %180 = OpLoad %14 %179
        %181 = OpSLessThan %9 %255 %180
               OpLoopMerge %226 %223 None
               OpBranchConditional %181 %182 %226
        %182 = OpLabel
        %185 = OpConvertSToF %6 %175
        %186 = OpCompositeConstruct %7 %185 %185 %185 %185
        %191 = OpAccessChain %65 %63 %27 %89
        %192 = OpLoad %14 %191
        %193 = OpConvertSToF %6 %192
        %194 = OpCompositeConstruct %7 %193 %193 %193 %193
        %215 = OpCompositeConstruct %115 %186 %186 %194 %186 %186 %186 %186 %186
               OpStore %169 %215
        %217 = OpAccessChain %8 %169 %255
        %218 = OpLoad %7 %217
               OpSelectionMerge %252 None
               OpSwitch %29 %232
        %232 = OpLabel
               OpBranch %233
        %233 = OpLabel
        %235 = OpAccessChain %30 %26 %27 %29
        %236 = OpLoad %6 %235
        %237 = OpAccessChain %30 %37 %27 %27
        %238 = OpLoad %6 %237
        %239 = OpFOrdLessThan %9 %236 %238
               OpLoopMerge %242 %241 None
               OpBranchConditional %239 %240 %242
        %240 = OpLabel
               OpBranch %242
        %241 = OpLabel
               OpBranch %233
        %242 = OpLabel
        %260 = OpPhi %9 %262 %233 %41 %240
        %257 = OpPhi %9 %41 %233 %54 %240
               OpSelectionMerge %244 None
               OpBranchConditional %257 %252 %244
        %244 = OpLabel
        %246 = OpCompositeExtract %6 %218 1
        %247 = OpAccessChain %30 %37 %27 %47
        %248 = OpLoad %6 %247
        %249 = OpFOrdLessThan %9 %246 %248
               OpSelectionMerge %251 None
               OpBranchConditional %249 %250 %251
        %250 = OpLabel
               OpBranch %252
        %251 = OpLabel
               OpBranch %252
        %252 = OpLabel
        %259 = OpPhi %9 %260 %242 %41 %250 %54 %251
        %274 = OpSelect %14 %259 %255 %256
               OpBranch %223
        %223 = OpLabel
        %225 = OpIAdd %14 %255 %47
               OpBranch %176
        %226 = OpLabel
        %133 = OpAccessChain %65 %63 %27 %47
        %134 = OpLoad %14 %133
        %135 = OpIEqual %9 %256 %134
               OpSelectionMerge %137 None
               OpBranchConditional %135 %136 %153
        %153 = OpLabel
        %156 = OpConvertSToF %6 %173
        %157 = OpCompositeConstruct %7 %156 %156 %156 %156
               OpStore %139 %157
               OpBranch %137
        %136 = OpLabel
        %142 = OpConvertSToF %6 %175
        %145 = OpConvertSToF %6 %173
        %152 = OpCompositeConstruct %7 %142 %145 %145 %142
               OpStore %139 %152
               OpBranch %137
        %137 = OpLabel
               OpReturn
               OpFunctionEnd
