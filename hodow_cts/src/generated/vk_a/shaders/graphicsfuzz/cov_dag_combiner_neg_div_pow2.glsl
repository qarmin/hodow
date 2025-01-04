#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 60
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %54
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "b"
               OpName %11 "i"
               OpName %18 "buf1"
               OpMemberName %18 0 "ten"
               OpName %20 ""
               OpName %32 "buf0"
               OpMemberName %32 0 "minusEight"
               OpName %34 ""
               OpName %54 "_GLF_color"
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 1
               OpMemberDecorate %32 0 Offset 0
               OpDecorate %32 Block
               OpDecorate %34 DescriptorSet 0
               OpDecorate %34 Binding 0
               OpDecorate %54 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %18 = OpTypeStruct %6
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypePointer Uniform %6
         %24 = OpTypeBool
         %27 = OpConstant %6 5
         %32 = OpTypeStruct %6
         %33 = OpTypePointer Uniform %32
         %34 = OpVariable %33 Uniform
         %37 = OpConstant %6 -4
         %42 = OpConstant %6 1
         %47 = OpConstant %6 3
         %51 = OpTypeFloat 32
         %52 = OpTypeVector %51 4
         %53 = OpTypePointer Output %52
         %54 = OpVariable %53 Output
         %55 = OpConstant %51 1
         %56 = OpConstant %51 0
         %57 = OpConstantComposite %52 %55 %56 %56 %55
         %59 = OpConstantComposite %52 %56 %56 %56 %56
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
         %11 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %9
               OpStore %11 %9
               OpBranch %12
         %12 = OpLabel
               OpLoopMerge %14 %15 None
               OpBranch %16
         %16 = OpLabel
         %17 = OpLoad %6 %11
         %22 = OpAccessChain %21 %20 %9
         %23 = OpLoad %6 %22
         %25 = OpSLessThan %24 %17 %23
               OpBranchConditional %25 %13 %14
         %13 = OpLabel
         %26 = OpLoad %6 %8
         %28 = OpSGreaterThan %24 %26 %27
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %30
         %29 = OpLabel
               OpBranch %14
         %30 = OpLabel
         %35 = OpAccessChain %21 %34 %9
         %36 = OpLoad %6 %35
         %38 = OpSDiv %6 %36 %37
         %39 = OpLoad %6 %8
         %40 = OpIAdd %6 %39 %38
               OpStore %8 %40
         %41 = OpLoad %6 %10
         %43 = OpIAdd %6 %41 %42
               OpStore %10 %43
               OpBranch %15
         %15 = OpLabel
         %44 = OpLoad %6 %11
         %45 = OpIAdd %6 %44 %42
               OpStore %11 %45
               OpBranch %12
         %14 = OpLabel
         %46 = OpLoad %6 %10
         %48 = OpIEqual %24 %46 %47
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %58
         %49 = OpLabel
               OpStore %54 %57
               OpBranch %50
         %58 = OpLabel
               OpStore %54 %59
               OpBranch %50
         %50 = OpLabel
               OpReturn
               OpFunctionEnd
