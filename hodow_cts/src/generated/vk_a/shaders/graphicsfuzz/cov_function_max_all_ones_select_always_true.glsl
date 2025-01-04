#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 144
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %86
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %17 "buf1"
               OpMemberName %17 0 "_GLF_uniform_int_values"
               OpName %19 ""
               OpName %50 "buf0"
               OpMemberName %50 0 "_GLF_uniform_float_values"
               OpName %52 ""
               OpName %86 "_GLF_color"
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 1
               OpDecorate %49 ArrayStride 16
               OpMemberDecorate %50 0 Offset 0
               OpDecorate %50 Block
               OpDecorate %52 DescriptorSet 0
               OpDecorate %52 Binding 0
               OpDecorate %86 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
         %11 = OpTypeInt 32 1
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 2
         %16 = OpTypeArray %11 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpConstant %11 0
         %21 = OpTypePointer Uniform %11
         %25 = OpConstant %11 1
         %26 = OpTypeBool
         %36 = OpTypeVector %11 2
         %49 = OpTypeArray %6 %15
         %50 = OpTypeStruct %49
         %51 = OpTypePointer Uniform %50
         %52 = OpVariable %51 Uniform
         %53 = OpTypePointer Uniform %6
         %60 = OpTypePointer Function %6
         %79 = OpTypeVector %26 3
         %84 = OpTypeVector %6 4
         %85 = OpTypePointer Output %84
         %86 = OpVariable %85 Output
        %143 = OpUndef %11
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %109 = OpVariable %60 Function
        %113 = OpAccessChain %21 %19 %20 %20
        %114 = OpLoad %11 %113
        %119 = OpCompositeConstruct %36 %25 %143
        %125 = OpExtInst %36 %1 SMax %119 %119
        %126 = OpCompositeExtract %11 %125 0
        %127 = OpAccessChain %53 %52 %20 %20
        %128 = OpLoad %6 %127
        %132 = OpIEqual %26 %126 %114
               OpSelectionMerge %139 None
               OpBranchConditional %132 %136 %133
        %133 = OpLabel
               OpStore %109 %128
               OpBranch %139
        %136 = OpLabel
        %137 = OpAccessChain %53 %52 %20 %25
        %138 = OpLoad %6 %137
               OpStore %109 %138
               OpBranch %139
        %139 = OpLabel
        %140 = OpLoad %6 %109
        %141 = OpExtInst %6 %1 FMax %128 %140
        %142 = OpCompositeConstruct %7 %141 %141 %141
         %77 = OpConvertSToF %6 %114
         %78 = OpCompositeConstruct %7 %77 %77 %77
         %80 = OpFOrdEqual %79 %142 %78
         %81 = OpAll %26 %80
               OpSelectionMerge %83 None
               OpBranchConditional %81 %82 %100
        %100 = OpLabel
        %101 = OpAccessChain %21 %19 %20 %25
        %102 = OpLoad %11 %101
        %103 = OpConvertSToF %6 %102
        %104 = OpCompositeConstruct %84 %103 %103 %103 %103
               OpStore %86 %104
               OpBranch %83
         %82 = OpLabel
         %90 = OpAccessChain %21 %19 %20 %25
         %91 = OpLoad %11 %90
         %92 = OpConvertSToF %6 %91
         %99 = OpCompositeConstruct %84 %77 %92 %92 %77
               OpStore %86 %99
               OpBranch %83
         %83 = OpLabel
               OpReturn
               OpFunctionEnd
