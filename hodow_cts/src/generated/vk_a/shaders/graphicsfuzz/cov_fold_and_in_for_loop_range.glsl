#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 53
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %47
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %11 "ret"
               OpName %13 "i"
               OpName %28 "buf0"
               OpMemberName %28 0 "one"
               OpName %30 ""
               OpName %47 "_GLF_color"
               OpMemberDecorate %28 0 Offset 0
               OpDecorate %28 Block
               OpDecorate %30 DescriptorSet 0
               OpDecorate %30 Binding 0
               OpDecorate %47 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 0
         %14 = OpConstant %6 3
         %22 = OpConstant %6 1
         %24 = OpTypeBool
         %28 = OpTypeStruct %6
         %29 = OpTypePointer Uniform %28
         %30 = OpVariable %29 Uniform
         %31 = OpTypePointer Uniform %6
         %40 = OpConstant %6 2
         %44 = OpTypeFloat 32
         %45 = OpTypeVector %44 4
         %46 = OpTypePointer Output %45
         %47 = OpVariable %46 Output
         %48 = OpConstant %44 1
         %49 = OpConstant %44 0
         %50 = OpConstantComposite %45 %48 %49 %49 %48
         %52 = OpConstantComposite %45 %49 %49 %49 %49
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %39 = OpFunctionCall %6 %8
         %41 = OpIEqual %24 %39 %40
               OpSelectionMerge %43 None
               OpBranchConditional %41 %42 %51
         %42 = OpLabel
               OpStore %47 %50
               OpBranch %43
         %51 = OpLabel
               OpStore %47 %52
               OpBranch %43
         %43 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
         %13 = OpVariable %10 Function
               OpStore %11 %12
               OpStore %13 %14
               OpBranch %15
         %15 = OpLabel
               OpLoopMerge %17 %18 None
               OpBranch %19
         %19 = OpLabel
         %20 = OpLoad %6 %13
         %21 = OpLoad %6 %13
         %23 = OpBitwiseAnd %6 %21 %22
         %25 = OpSGreaterThan %24 %20 %23
               OpBranchConditional %25 %16 %17
         %16 = OpLabel
         %26 = OpLoad %6 %11
         %27 = OpIAdd %6 %26 %22
               OpStore %11 %27
               OpBranch %18
         %18 = OpLabel
         %32 = OpAccessChain %31 %30 %12
         %33 = OpLoad %6 %32
         %34 = OpLoad %6 %13
         %35 = OpISub %6 %34 %33
               OpStore %13 %35
               OpBranch %15
         %17 = OpLabel
         %36 = OpLoad %6 %11
               OpReturnValue %36
               OpFunctionEnd
