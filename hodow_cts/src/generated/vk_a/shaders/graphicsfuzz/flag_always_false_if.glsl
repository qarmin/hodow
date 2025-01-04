#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 109
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %30 %60
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "loop_count"
               OpName %12 "buf0"
               OpMemberName %12 0 "injectionSwitch"
               OpName %14 ""
               OpName %30 "gl_FragCoord"
               OpName %60 "_GLF_color"
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %30 BuiltIn FragCoord
               OpDecorate %60 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 2
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %10
         %20 = OpConstant %15 1
         %23 = OpTypeBool
         %28 = OpTypeVector %10 4
         %29 = OpTypePointer Input %28
         %30 = OpVariable %29 Input
         %31 = OpTypePointer Input %10
         %34 = OpConstant %10 0
         %42 = OpConstant %6 100
         %59 = OpTypePointer Output %28
         %60 = OpVariable %59 Output
         %61 = OpConstant %10 1
         %62 = OpConstantComposite %28 %61 %61 %61 %61
         %78 = OpConstantComposite %28 %61 %34 %34 %61
        %100 = OpConstant %6 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
         %18 = OpAccessChain %17 %14 %9 %16
         %19 = OpLoad %10 %18
         %21 = OpAccessChain %17 %14 %9 %20
         %22 = OpLoad %10 %21
         %24 = OpFOrdGreaterThan %23 %19 %22
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %26
         %25 = OpLabel
               OpReturn
         %26 = OpLabel
         %32 = OpAccessChain %31 %30 %16
         %33 = OpLoad %10 %32
         %35 = OpFOrdLessThan %23 %33 %34
               OpBranch %36
         %36 = OpLabel
         %41 = OpLoad %6 %8
         %43 = OpSLessThan %23 %41 %42
               OpLoopMerge %38 %39 None
               OpBranchConditional %43 %37 %38
         %37 = OpLabel
               OpSelectionMerge %50 None
               OpBranchConditional %24 %49 %50
         %49 = OpLabel
               OpBranch %38
         %50 = OpLabel
               OpSelectionMerge %58 None
               OpBranchConditional %24 %57 %63
         %57 = OpLabel
               OpStore %60 %62
               OpBranch %58
         %63 = OpLabel
               OpSelectionMerge %68 None
               OpBranchConditional %35 %67 %68
         %67 = OpLabel
               OpReturn
         %68 = OpLabel
               OpBranch %58
         %58 = OpLabel
               OpSelectionMerge %76 None
               OpBranchConditional %24 %75 %77
         %75 = OpLabel
               OpStore %60 %62
               OpBranch %76
         %77 = OpLabel
               OpStore %60 %78
               OpBranch %76
         %76 = OpLabel
               OpSelectionMerge %85 None
               OpBranchConditional %24 %84 %85
         %84 = OpLabel
               OpReturn
         %85 = OpLabel
               OpSelectionMerge %91 None
               OpBranchConditional %35 %90 %91
         %90 = OpLabel
               OpBranch %92
         %92 = OpLabel
         %97 = OpLoad %6 %8
         %98 = OpSLessThan %23 %97 %42
               OpLoopMerge %94 %93 None
               OpBranchConditional %98 %93 %94
         %93 = OpLabel
         %99 = OpLoad %6 %8
        %101 = OpIAdd %6 %99 %100
               OpStore %8 %101
               OpBranch %92
         %94 = OpLabel
               OpBranch %91
         %91 = OpLabel
               OpBranch %39
         %39 = OpLabel
        %102 = OpLoad %6 %8
        %103 = OpIAdd %6 %102 %100
               OpStore %8 %103
               OpBranch %36
         %38 = OpLabel
        %104 = OpLoad %6 %8
        %105 = OpSGreaterThanEqual %23 %104 %42
               OpSelectionMerge %107 None
               OpBranchConditional %105 %106 %108
        %106 = OpLabel
               OpStore %60 %78
               OpBranch %107
        %108 = OpLabel
               OpStore %60 %62
               OpBranch %107
        %107 = OpLabel
               OpReturn
               OpFunctionEnd
