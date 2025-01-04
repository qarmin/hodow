#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 51
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %45
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "i"
               OpName %18 "buf0"
               OpMemberName %18 0 "three"
               OpName %20 ""
               OpName %45 "_GLF_color"
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %45 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %17 = OpConstant %6 7
         %18 = OpTypeStruct %6
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypePointer Uniform %6
         %25 = OpTypeBool
         %31 = OpConstant %6 1
         %38 = OpConstant %6 2
         %42 = OpTypeFloat 32
         %43 = OpTypeVector %42 4
         %44 = OpTypePointer Output %43
         %45 = OpVariable %44 Output
         %46 = OpConstant %42 1
         %47 = OpConstant %42 0
         %48 = OpConstantComposite %43 %46 %47 %47 %46
         %50 = OpConstantComposite %43 %47 %47 %47 %47
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %9
               OpBranch %11
         %11 = OpLabel
               OpLoopMerge %13 %14 None
               OpBranch %15
         %15 = OpLabel
         %16 = OpLoad %6 %10
         %22 = OpAccessChain %21 %20 %9
         %23 = OpLoad %6 %22
         %24 = OpIAdd %6 %17 %23
         %26 = OpSLessThan %25 %16 %24
               OpBranchConditional %26 %12 %13
         %12 = OpLabel
         %27 = OpLoad %6 %10
               OpSelectionMerge %29 None
               OpSwitch %27 %29 7 %28 8 %28
         %28 = OpLabel
         %30 = OpLoad %6 %8
         %32 = OpIAdd %6 %30 %31
               OpStore %8 %32
               OpBranch %29
         %29 = OpLabel
               OpBranch %14
         %14 = OpLabel
         %35 = OpLoad %6 %10
         %36 = OpIAdd %6 %35 %31
               OpStore %10 %36
               OpBranch %11
         %13 = OpLabel
         %37 = OpLoad %6 %8
         %39 = OpIEqual %25 %37 %38
               OpSelectionMerge %41 None
               OpBranchConditional %39 %40 %49
         %40 = OpLabel
               OpStore %45 %48
               OpBranch %41
         %49 = OpLabel
               OpStore %45 %50
               OpBranch %41
         %41 = OpLabel
               OpReturn
               OpFunctionEnd
