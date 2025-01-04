#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 45
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %39
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "func(i1;"
               OpName %9 "x"
               OpName %12 "buf0"
               OpMemberName %12 0 "one"
               OpName %14 ""
               OpName %31 "param"
               OpName %39 "_GLF_color"
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %39 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %12 = OpTypeStruct %6
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpTypePointer Uniform %6
         %19 = OpConstant %6 1
         %20 = OpTypeBool
         %30 = OpConstant %6 -1
         %36 = OpTypeFloat 32
         %37 = OpTypeVector %36 4
         %38 = OpTypePointer Output %37
         %39 = OpVariable %38 Output
         %40 = OpConstant %36 1
         %41 = OpConstant %36 0
         %42 = OpConstantComposite %37 %40 %41 %41 %40
         %44 = OpConstantComposite %37 %41 %41 %41 %41
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %31 = OpVariable %7 Function
               OpStore %31 %30
         %32 = OpFunctionCall %6 %10 %31
         %33 = OpSLessThanEqual %20 %32 %15
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %43
         %34 = OpLabel
               OpStore %39 %42
               OpBranch %35
         %43 = OpLabel
               OpStore %39 %44
               OpBranch %35
         %35 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %17 = OpAccessChain %16 %14 %15
         %18 = OpLoad %6 %17
         %21 = OpIEqual %20 %18 %19
               OpSelectionMerge %23 None
               OpBranchConditional %21 %22 %23
         %22 = OpLabel
         %24 = OpLoad %6 %9
               OpReturnValue %24
         %23 = OpLabel
         %26 = OpAccessChain %16 %14 %15
         %27 = OpLoad %6 %26
               OpReturnValue %27
               OpFunctionEnd
