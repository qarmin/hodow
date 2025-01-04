#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 196
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %41 %83
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %24 "buf0"
               OpMemberName %24 0 "_GLF_uniform_float_values"
               OpName %26 ""
               OpName %41 "gl_FragCoord"
               OpName %83 "_GLF_color"
               OpName %85 "buf1"
               OpMemberName %85 0 "_GLF_uniform_int_values"
               OpName %87 ""
               OpName %128 "indexable"
               OpDecorate %23 ArrayStride 16
               OpMemberDecorate %24 0 Offset 0
               OpDecorate %24 Block
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 0
               OpDecorate %41 BuiltIn FragCoord
               OpDecorate %83 Location 0
               OpDecorate %84 ArrayStride 16
               OpMemberDecorate %85 0 Offset 0
               OpDecorate %85 Block
               OpDecorate %87 DescriptorSet 0
               OpDecorate %87 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %9 = OpTypeVector %6 4
         %10 = OpTypePointer Function %9
         %11 = OpTypeBool
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 1
         %22 = OpConstant %17 2
         %23 = OpTypeArray %6 %22
         %24 = OpTypeStruct %23
         %25 = OpTypePointer Uniform %24
         %26 = OpVariable %25 Uniform
         %27 = OpTypeInt 32 1
         %28 = OpConstant %27 0
         %29 = OpTypePointer Uniform %6
         %35 = OpConstantTrue %11
         %37 = OpConstant %17 0
         %40 = OpTypePointer Input %9
         %41 = OpVariable %40 Input
         %42 = OpTypePointer Input %6
         %45 = OpConstant %27 1
         %55 = OpConstant %6 4.30000019
         %60 = OpConstantFalse %11
         %65 = OpTypeVector %6 3
         %66 = OpConstant %6 1
         %67 = OpConstant %6 7014.76416
         %68 = OpConstantComposite %65 %66 %67 %66
         %69 = OpConstant %6 -1
         %76 = OpTypeMatrix %65 2
         %82 = OpTypePointer Output %9
         %83 = OpVariable %82 Output
         %84 = OpTypeArray %27 %22
         %85 = OpTypeStruct %84
         %86 = OpTypePointer Uniform %85
         %87 = OpVariable %86 Uniform
         %88 = OpTypePointer Uniform %27
        %101 = OpConstant %27 5
        %103 = OpConstantComposite %9 %66 %66 %66 %66
        %120 = OpConstant %17 5
        %121 = OpTypeArray %9 %120
        %127 = OpTypePointer Function %121
        %195 = OpConstantComposite %65 %66 %69 %66
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %128 = OpVariable %127 Function
         %70 = OpAccessChain %29 %26 %28 %28
         %71 = OpLoad %6 %70
         %79 = OpCompositeConstruct %65 %71 %71 %71
         %80 = OpCompositeConstruct %76 %195 %79
         %81 = OpVectorTimesMatrix %7 %68 %80
         %89 = OpAccessChain %88 %87 %28 %45
         %90 = OpLoad %27 %89
         %91 = OpConvertSToF %6 %90
         %92 = OpCompositeConstruct %9 %91 %91 %91 %91
               OpStore %83 %92
               OpBranch %95
         %95 = OpLabel
        %189 = OpPhi %27 %28 %5 %148 %98
        %102 = OpSLessThan %11 %189 %101
               OpLoopMerge %97 %98 None
               OpBranchConditional %102 %96 %97
         %96 = OpLabel
        %104 = OpAccessChain %88 %87 %28 %28
        %105 = OpLoad %27 %104
        %106 = OpConvertSToF %6 %105
        %107 = OpCompositeConstruct %9 %106 %106 %106 %106
        %122 = OpCompositeConstruct %121 %103 %107 %107 %107 %107
               OpStore %128 %122
        %129 = OpAccessChain %10 %128 %189
        %130 = OpLoad %9 %129
               OpSelectionMerge %184 None
               OpSwitch %37 %160
        %160 = OpLabel
        %162 = OpCompositeExtract %6 %130 1
        %165 = OpFOrdGreaterThan %11 %162 %71
               OpSelectionMerge %167 None
               OpBranchConditional %165 %166 %167
        %166 = OpLabel
               OpBranch %184
        %167 = OpLabel
        %169 = OpCompositeExtract %6 %81 0
        %170 = OpAccessChain %42 %41 %18
        %171 = OpLoad %6 %170
        %172 = OpAccessChain %29 %26 %28 %45
        %173 = OpLoad %6 %172
        %174 = OpFOrdLessThan %11 %171 %173
               OpSelectionMerge %179 None
               OpBranchConditional %174 %175 %178
        %175 = OpLabel
        %177 = OpCompositeExtract %6 %130 2
               OpBranch %179
        %178 = OpLabel
               OpBranch %179
        %179 = OpLabel
        %190 = OpPhi %6 %177 %175 %55 %178
        %181 = OpFOrdGreaterThan %11 %169 %190
               OpSelectionMerge %183 None
               OpBranchConditional %181 %182 %183
        %182 = OpLabel
               OpBranch %184
        %183 = OpLabel
               OpBranch %184
        %184 = OpLabel
        %191 = OpPhi %11 %35 %166 %60 %182 %35 %183
               OpSelectionMerge %133 None
               OpBranchConditional %191 %132 %133
        %132 = OpLabel
        %146 = OpCompositeConstruct %9 %106 %91 %91 %106
               OpStore %83 %146
               OpBranch %133
        %133 = OpLabel
               OpBranch %98
         %98 = OpLabel
        %148 = OpIAdd %27 %189 %45
               OpBranch %95
         %97 = OpLabel
               OpReturn
               OpFunctionEnd
