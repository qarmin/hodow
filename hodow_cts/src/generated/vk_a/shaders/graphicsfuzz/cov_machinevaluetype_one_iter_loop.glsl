#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 56
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %50
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "i"
               OpName %19 "buf0"
               OpMemberName %19 0 "injectionSwitch"
               OpName %21 ""
               OpName %50 "_GLF_color"
               OpMemberDecorate %19 0 Offset 0
               OpDecorate %19 Block
               OpDecorate %21 DescriptorSet 0
               OpDecorate %21 Binding 0
               OpDecorate %50 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %17 = OpTypeFloat 32
         %18 = OpTypeVector %17 2
         %19 = OpTypeStruct %18
         %20 = OpTypePointer Uniform %19
         %21 = OpVariable %20 Uniform
         %22 = OpTypeInt 32 0
         %23 = OpConstant %22 1
         %24 = OpTypePointer Uniform %17
         %28 = OpTypeBool
         %38 = OpConstant %6 2
         %42 = OpConstant %6 1
         %48 = OpTypeVector %17 4
         %49 = OpTypePointer Output %48
         %50 = OpVariable %49 Output
         %51 = OpConstant %17 1
         %52 = OpConstant %17 0
         %53 = OpConstantComposite %48 %51 %52 %52 %51
         %55 = OpConstantComposite %48 %52 %52 %52 %52
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
         %25 = OpAccessChain %24 %21 %9 %23
         %26 = OpLoad %17 %25
         %27 = OpConvertFToS %6 %26
         %29 = OpSLessThan %28 %16 %27
               OpBranchConditional %29 %12 %13
         %12 = OpLabel
         %30 = OpLoad %6 %8
         %31 = OpSGreaterThan %28 %30 %9
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %33
         %32 = OpLabel
               OpBranch %13
         %33 = OpLabel
         %35 = OpAccessChain %24 %21 %9 %23
         %36 = OpLoad %17 %35
         %37 = OpConvertFToS %6 %36
         %39 = OpIMul %6 %37 %38
         %40 = OpSDiv %6 %39 %38
               OpStore %8 %40
               OpBranch %14
         %14 = OpLabel
         %41 = OpLoad %6 %10
         %43 = OpIAdd %6 %41 %42
               OpStore %10 %43
               OpBranch %11
         %13 = OpLabel
         %44 = OpLoad %6 %8
         %45 = OpIEqual %28 %44 %42
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %54
         %46 = OpLabel
               OpStore %50 %53
               OpBranch %47
         %54 = OpLabel
               OpStore %50 %55
               OpBranch %47
         %47 = OpLabel
               OpReturn
               OpFunctionEnd
