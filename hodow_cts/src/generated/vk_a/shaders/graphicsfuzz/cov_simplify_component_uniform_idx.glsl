#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 55
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %49
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %10 "r"
               OpName %17 "buf0"
               OpMemberName %17 0 "two"
               OpName %19 ""
               OpName %49 "_GLF_color"
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %49 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %17 = OpTypeStruct %6
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypePointer Uniform %6
         %23 = OpConstant %6 4
         %25 = OpTypeBool
         %27 = OpTypeVector %6 4
         %28 = OpConstant %6 1
         %29 = OpConstant %6 2
         %30 = OpConstant %6 3
         %31 = OpConstantComposite %27 %28 %29 %30 %23
         %42 = OpConstant %6 10
         %46 = OpTypeFloat 32
         %47 = OpTypeVector %46 4
         %48 = OpTypePointer Output %47
         %49 = OpVariable %48 Output
         %50 = OpConstant %46 1
         %51 = OpConstant %46 0
         %52 = OpConstantComposite %47 %50 %51 %51 %50
         %54 = OpConstantComposite %47 %51 %51 %51 %51
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
         %21 = OpAccessChain %20 %19 %9
         %22 = OpLoad %6 %21
         %24 = OpIMul %6 %22 %23
         %26 = OpSLessThan %25 %16 %24
               OpBranchConditional %26 %12 %13
         %12 = OpLabel
         %32 = OpLoad %6 %10
         %33 = OpAccessChain %20 %19 %9
         %34 = OpLoad %6 %33
         %35 = OpSDiv %6 %32 %34
         %36 = OpVectorExtractDynamic %6 %31 %35
         %37 = OpLoad %6 %8
         %38 = OpIAdd %6 %37 %36
               OpStore %8 %38
               OpBranch %14
         %14 = OpLabel
         %39 = OpLoad %6 %10
         %40 = OpIAdd %6 %39 %29
               OpStore %10 %40
               OpBranch %11
         %13 = OpLabel
         %41 = OpLoad %6 %8
         %43 = OpIEqual %25 %41 %42
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %53
         %44 = OpLabel
               OpStore %49 %52
               OpBranch %45
         %53 = OpLabel
               OpStore %49 %54
               OpBranch %45
         %45 = OpLabel
               OpReturn
               OpFunctionEnd
