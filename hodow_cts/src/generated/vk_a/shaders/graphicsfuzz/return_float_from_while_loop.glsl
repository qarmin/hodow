#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 120
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %23 %64
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %23 "gl_FragCoord"
               OpName %34 "buf0"
               OpMemberName %34 0 "injectionSwitch"
               OpName %36 ""
               OpName %64 "_GLF_color"
               OpDecorate %23 BuiltIn FragCoord
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 0
               OpDecorate %64 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
         %10 = OpTypeInt 32 1
         %19 = OpTypeBool
         %21 = OpTypeVector %6 4
         %22 = OpTypePointer Input %21
         %23 = OpVariable %22 Input
         %24 = OpTypeInt 32 0
         %25 = OpConstant %24 0
         %26 = OpTypePointer Input %6
         %29 = OpConstant %6 0
         %33 = OpTypeVector %6 2
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpConstant %10 0
         %38 = OpTypePointer Uniform %6
         %41 = OpConstant %6 1
         %63 = OpTypePointer Output %21
         %64 = OpVariable %63 Output
         %66 = OpConstantComposite %21 %41 %29 %29 %41
        %110 = OpUndef %6
        %118 = OpUndef %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %53 = OpAccessChain %38 %36 %37 %25
         %54 = OpLoad %6 %53
         %55 = OpFOrdGreaterThan %19 %54 %41
               OpSelectionMerge %57 None
               OpBranchConditional %55 %56 %57
         %56 = OpLabel
               OpBranch %83
         %83 = OpLabel
               OpLoopMerge %84 %85 None
               OpBranch %87
         %87 = OpLabel
               OpLoopMerge %88 %100 None
               OpBranch %91
         %91 = OpLabel
         %92 = OpAccessChain %26 %23 %25
         %93 = OpLoad %6 %92
         %94 = OpFOrdLessThan %19 %93 %29
               OpSelectionMerge %95 None
               OpBranchConditional %94 %96 %95
         %96 = OpLabel
               OpSelectionMerge %119 None
               OpBranchConditional %55 %101 %100
        %101 = OpLabel
               OpBranch %88
        %119 = OpLabel
               OpBranch %100
        %100 = OpLabel
               OpBranch %87
         %95 = OpLabel
               OpBranch %88
         %88 = OpLabel
        %113 = OpPhi %6 %41 %101 %110 %95
               OpBranch %84
         %85 = OpLabel
               OpBranch %83
         %84 = OpLabel
        %107 = OpCompositeInsert %21 %113 %118 1
               OpStore %64 %107
               OpBranch %57
         %57 = OpLabel
               OpStore %64 %66
               OpReturn
               OpFunctionEnd
