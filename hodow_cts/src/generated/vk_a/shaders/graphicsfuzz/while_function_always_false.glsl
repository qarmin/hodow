#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 52
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %19 "j"
               OpName %21 "buf0"
               OpMemberName %21 0 "injectionSwitch"
               OpName %23 ""
               OpDecorate %9 Location 0
               OpDecorate %19 RelaxedPrecision
               OpMemberDecorate %21 0 Offset 0
               OpDecorate %21 Block
               OpDecorate %23 DescriptorSet 0
               OpDecorate %23 Binding 0
               OpDecorate %30 RelaxedPrecision
               OpDecorate %36 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %17 = OpTypeInt 32 1
         %18 = OpTypePointer Function %17
         %20 = OpTypeVector %6 2
         %21 = OpTypeStruct %20
         %22 = OpTypePointer Uniform %21
         %23 = OpVariable %22 Uniform
         %24 = OpConstant %17 0
         %25 = OpTypeInt 32 0
         %26 = OpConstant %25 0
         %27 = OpTypePointer Uniform %6
         %37 = OpConstant %17 2
         %38 = OpTypeBool
         %42 = OpConstant %17 1
         %44 = OpConstant %25 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %19 = OpVariable %18 Function
               OpStore %9 %12
               OpBranch %13
         %13 = OpLabel
         %28 = OpAccessChain %27 %23 %24 %26
         %29 = OpLoad %6 %28
         %30 = OpConvertFToS %17 %29
               OpStore %19 %30
               OpLoopMerge %15 %33 None
               OpBranch %31
         %31 = OpLabel
         %36 = OpLoad %17 %19
         %39 = OpSLessThan %38 %36 %37
               OpLoopMerge %51 %34 None
               OpBranchConditional %39 %32 %51
         %32 = OpLabel
               OpReturn
         %34 = OpLabel
               OpBranch %31
         %51 = OpLabel
               OpBranch %33
         %33 = OpLabel
         %45 = OpAccessChain %27 %23 %24 %44
         %46 = OpLoad %6 %45
         %47 = OpFOrdGreaterThan %38 %11 %46
               OpBranchConditional %47 %13 %15
         %15 = OpLabel
         %50 = OpConvertFToS %17 %46
               OpReturn
               OpFunctionEnd
