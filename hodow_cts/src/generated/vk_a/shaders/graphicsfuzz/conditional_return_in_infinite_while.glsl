#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 57
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %54
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "GLF_live6search("
               OpName %11 "GLF_live6index"
               OpName %20 "GLF_live6currentNode"
               OpName %25 "GLF_live6tree"
               OpName %40 "buf0"
               OpMemberName %40 0 "injectionSwitch"
               OpName %42 ""
               OpName %54 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %11 RelaxedPrecision
               OpDecorate %20 RelaxedPrecision
               OpDecorate %25 RelaxedPrecision
               OpDecorate %26 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpDecorate %30 RelaxedPrecision
               OpMemberDecorate %40 0 Offset 0
               OpDecorate %40 Block
               OpDecorate %42 DescriptorSet 0
               OpDecorate %42 Binding 0
               OpDecorate %51 RelaxedPrecision
               OpDecorate %54 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 0
         %18 = OpTypeBool
         %19 = OpConstantTrue %18
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 10
         %23 = OpTypeArray %6 %22
         %24 = OpTypePointer Private %23
         %25 = OpVariable %24 Private
         %27 = OpTypePointer Private %6
         %31 = OpConstant %6 1
         %38 = OpTypeFloat 32
         %39 = OpTypeVector %38 2
         %40 = OpTypeStruct %39
         %41 = OpTypePointer Uniform %40
         %42 = OpVariable %41 Uniform
         %43 = OpConstant %21 0
         %44 = OpTypePointer Uniform %38
         %47 = OpConstant %38 1
         %52 = OpTypeVector %38 4
         %53 = OpTypePointer Output %52
         %54 = OpVariable %53 Output
         %55 = OpConstant %38 0
         %56 = OpConstantComposite %52 %47 %55 %55 %47
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %45 = OpAccessChain %44 %42 %12 %43
         %46 = OpLoad %38 %45
         %48 = OpFOrdGreaterThan %18 %46 %47
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %50
         %49 = OpLabel
         %51 = OpFunctionCall %6 %8
               OpBranch %50
         %50 = OpLabel
               OpStore %54 %56
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
         %20 = OpVariable %10 Function
               OpStore %11 %12
               OpBranch %13
         %13 = OpLabel
               OpLoopMerge %15 %16 None
               OpBranch %17
         %17 = OpLabel
               OpBranchConditional %19 %14 %15
         %14 = OpLabel
         %26 = OpLoad %6 %11
         %28 = OpAccessChain %27 %25 %26
         %29 = OpLoad %6 %28
               OpStore %20 %29
         %30 = OpLoad %6 %20
         %32 = OpINotEqual %18 %30 %31
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %34
         %33 = OpLabel
               OpReturnValue %31
         %34 = OpLabel
               OpStore %11 %31
               OpBranch %16
         %16 = OpLabel
               OpBranch %13
         %15 = OpLabel
               OpReturnValue %31
               OpFunctionEnd
