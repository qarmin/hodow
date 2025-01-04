#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 225
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %94
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %15 "buf0"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %94 "_GLF_color"
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %94 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 4
         %14 = OpTypeArray %6 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %6 0
         %19 = OpConstant %6 1
         %20 = OpTypePointer Uniform %6
         %30 = OpConstant %6 4
         %31 = OpTypeBool
         %42 = OpConstant %6 2
         %57 = OpConstant %6 3
         %91 = OpTypeFloat 32
         %92 = OpTypeVector %91 4
         %93 = OpTypePointer Output %92
         %94 = OpVariable %93 Output
        %117 = OpConstant %12 0
        %118 = OpConstantFalse %31
        %121 = OpConstantTrue %31
        %221 = OpUndef %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpSelectionMerge %196 None
               OpSwitch %117 %137
        %137 = OpLabel
        %138 = OpAccessChain %20 %17 %18 %19
        %139 = OpLoad %6 %138
               OpBranch %140
        %140 = OpLabel
        %210 = OpPhi %31 %118 %137 %214 %188
        %206 = OpPhi %6 %139 %137 %205 %188
        %198 = OpPhi %6 %19 %137 %190 %188
        %220 = OpPhi %6 %221 %137 %222 %188
        %143 = OpSLessThan %31 %198 %30
               OpLoopMerge %191 %188 None
               OpBranchConditional %143 %144 %191
        %144 = OpLabel
               OpBranch %147
        %147 = OpLabel
        %209 = OpPhi %31 %210 %144 %207 %182
        %205 = OpPhi %6 %206 %144 %181 %182
        %199 = OpPhi %6 %139 %144 %184 %182
        %223 = OpPhi %6 %220 %144 %224 %182
        %150 = OpAccessChain %20 %17 %18 %42
        %151 = OpLoad %6 %150
        %152 = OpSLessThan %31 %199 %151
               OpLoopMerge %185 %182 None
               OpBranchConditional %152 %153 %185
        %153 = OpLabel
               OpBranch %154
        %154 = OpLabel
        %203 = OpPhi %6 %18 %153 %165 %174
        %200 = OpPhi %6 %18 %153 %176 %174
        %158 = OpSLessThan %31 %200 %198
               OpLoopMerge %177 %174 None
               OpBranchConditional %158 %159 %177
        %159 = OpLabel
        %161 = OpSGreaterThanEqual %31 %203 %57
               OpSelectionMerge %163 None
               OpBranchConditional %161 %162 %163
        %162 = OpLabel
               OpBranch %177
        %163 = OpLabel
        %165 = OpIAdd %6 %203 %19
        %167 = OpAccessChain %20 %17 %18 %57
        %168 = OpLoad %6 %167
        %169 = OpIEqual %31 %205 %168
               OpSelectionMerge %173 None
               OpBranchConditional %169 %170 %173
        %170 = OpLabel
               OpBranch %177
        %173 = OpLabel
               OpBranch %174
        %174 = OpLabel
        %176 = OpIAdd %6 %200 %19
               OpBranch %154
        %177 = OpLabel
        %224 = OpPhi %6 %223 %154 %223 %162 %139 %170
        %207 = OpPhi %31 %209 %154 %209 %162 %121 %170
               OpSelectionMerge %179 None
               OpBranchConditional %207 %185 %179
        %179 = OpLabel
        %181 = OpIAdd %6 %205 %19
               OpBranch %182
        %182 = OpLabel
        %184 = OpIAdd %6 %199 %19
               OpBranch %147
        %185 = OpLabel
        %222 = OpPhi %6 %223 %147 %224 %177
        %214 = OpPhi %31 %209 %147 %207 %177
               OpSelectionMerge %187 None
               OpBranchConditional %214 %191 %187
        %187 = OpLabel
               OpBranch %188
        %188 = OpLabel
        %190 = OpIAdd %6 %198 %19
               OpBranch %140
        %191 = OpLabel
        %219 = OpPhi %6 %220 %140 %222 %185
        %217 = OpPhi %31 %210 %140 %214 %185
               OpSelectionMerge %193 None
               OpBranchConditional %217 %196 %193
        %193 = OpLabel
        %194 = OpAccessChain %20 %17 %18 %18
        %195 = OpLoad %6 %194
               OpBranch %196
        %196 = OpLabel
        %218 = OpPhi %6 %219 %191 %195 %193
         %88 = OpIEqual %31 %218 %139
               OpSelectionMerge %90 None
               OpBranchConditional %88 %89 %108
         %89 = OpLabel
         %97 = OpConvertSToF %91 %139
         %98 = OpAccessChain %20 %17 %18 %18
         %99 = OpLoad %6 %98
        %100 = OpConvertSToF %91 %99
        %107 = OpCompositeConstruct %92 %97 %100 %100 %97
               OpStore %94 %107
               OpBranch %90
        %108 = OpLabel
        %109 = OpAccessChain %20 %17 %18 %18
        %110 = OpLoad %6 %109
        %111 = OpConvertSToF %91 %110
        %112 = OpCompositeConstruct %92 %111 %111 %111 %111
               OpStore %94 %112
               OpBranch %90
         %90 = OpLabel
               OpReturn
               OpFunctionEnd
