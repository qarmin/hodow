#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 48
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %27
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "merge("
               OpName %11 "buf0"
               OpMemberName %11 0 "zero"
               OpName %13 ""
               OpName %27 "_GLF_color"
               OpName %43 "res"
               OpDecorate %8 RelaxedPrecision
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 0
               OpDecorate %27 Location 0
               OpDecorate %43 RelaxedPrecision
               OpDecorate %44 RelaxedPrecision
               OpDecorate %45 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypeFloat 32
         %11 = OpTypeStruct %10
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpConstant %6 0
         %15 = OpTypePointer Uniform %10
         %18 = OpConstant %10 0
         %19 = OpTypeBool
         %25 = OpTypeVector %10 4
         %26 = OpTypePointer Output %25
         %27 = OpVariable %26 Output
         %28 = OpConstant %10 1
         %29 = OpConstantComposite %25 %28 %18 %18 %28
         %41 = OpConstantFalse %19
         %42 = OpTypePointer Function %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %43 = OpVariable %42 Function
               OpStore %27 %29
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %31
         %31 = OpLabel
         %34 = OpAccessChain %15 %13 %14
         %35 = OpLoad %10 %34
         %36 = OpConvertFToS %6 %35
               OpSelectionMerge %38 None
               OpSwitch %36 %38 0 %37
         %37 = OpLabel
               OpReturn
         %38 = OpLabel
               OpBranch %33
         %33 = OpLabel
               OpBranchConditional %41 %30 %32
         %32 = OpLabel
         %44 = OpFunctionCall %6 %8
               OpStore %43 %44
         %45 = OpLoad %6 %43
         %46 = OpConvertSToF %10 %45
         %47 = OpCompositeConstruct %25 %46 %46 %46 %46
               OpStore %27 %47
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %16 = OpAccessChain %15 %13 %14
         %17 = OpLoad %10 %16
         %20 = OpFOrdLessThan %19 %17 %18
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %22
         %21 = OpLabel
               OpReturnValue %14
         %22 = OpLabel
         %24 = OpUndef %6
               OpReturnValue %24
               OpFunctionEnd
