#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 90
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %21
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %21 "_GLF_color"
               OpName %38 "buf0"
               OpMemberName %38 0 "zero"
               OpName %40 ""
               OpDecorate %21 Location 0
               OpMemberDecorate %38 0 RelaxedPrecision
               OpMemberDecorate %38 0 Offset 0
               OpDecorate %38 Block
               OpDecorate %40 DescriptorSet 0
               OpDecorate %40 Binding 0
               OpDecorate %43 RelaxedPrecision
               OpDecorate %50 RelaxedPrecision
               OpDecorate %74 RelaxedPrecision
               OpDecorate %81 RelaxedPrecision
               OpDecorate %86 RelaxedPrecision
               OpDecorate %89 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 1
          %9 = OpTypeArray %6 %8
         %12 = OpTypePointer Function %6
         %18 = OpTypeFloat 32
         %19 = OpTypeVector %18 4
         %20 = OpTypePointer Output %19
         %21 = OpVariable %20 Output
         %22 = OpConstant %18 0
         %23 = OpConstantComposite %19 %22 %22 %22 %22
         %24 = OpConstant %6 0
         %28 = OpTypeBool
         %32 = OpConstant %6 1
         %34 = OpConstant %6 2
         %38 = OpTypeStruct %6
         %39 = OpTypePointer Uniform %38
         %40 = OpVariable %39 Uniform
         %41 = OpTypePointer Uniform %6
         %56 = OpConstant %18 1
         %57 = OpConstantComposite %19 %56 %22 %22 %56
         %63 = OpConstant %7 0
         %80 = OpTypePointer Function %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %86 = OpVariable %80 Function
         %81 = OpVariable %80 Function
         %42 = OpAccessChain %41 %40 %24
         %43 = OpLoad %6 %42
         %82 = OpAccessChain %12 %81 %24
               OpStore %82 %43
         %83 = OpLoad %9 %81
               OpStore %86 %83
         %85 = OpAccessChain %12 %81 %24
         %50 = OpLoad %6 %85
               OpSelectionMerge %71 None
               OpSwitch %63 %72
         %72 = OpLabel
               OpStore %21 %23
         %88 = OpAccessChain %12 %86 %24
         %74 = OpLoad %6 %88
         %76 = OpIEqual %28 %74 %50
               OpSelectionMerge %77 None
               OpBranchConditional %76 %78 %77
         %78 = OpLabel
               OpBranch %71
         %77 = OpLabel
               OpBranch %71
         %71 = OpLabel
         %89 = OpPhi %6 %32 %78 %34 %77
         %53 = OpIEqual %28 %89 %32
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %58
         %54 = OpLabel
               OpStore %21 %57
               OpBranch %55
         %58 = OpLabel
               OpStore %21 %23
               OpBranch %55
         %55 = OpLabel
               OpReturn
               OpFunctionEnd
