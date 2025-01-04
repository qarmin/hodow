#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 47
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %32
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf0"
               OpMemberName %14 0 "injectionSwitch"
               OpName %16 ""
               OpName %32 "gl_FragCoord"
               OpDecorate %9 Location 0
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %32 BuiltIn FragCoord
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 0
         %11 = OpConstant %6 1
         %12 = OpConstantComposite %7 %10 %10 %10 %11
         %13 = OpTypeVector %6 2
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Uniform %6
         %28 = OpConstant %17 1
         %31 = OpTypePointer Input %7
         %32 = OpVariable %31 Input
         %33 = OpConstant %19 1
         %34 = OpTypePointer Input %6
         %37 = OpTypeBool
         %41 = OpConstantComposite %7 %11 %10 %10 %11
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpStore %9 %12
         %22 = OpAccessChain %21 %16 %18 %20
         %23 = OpLoad %6 %22
         %24 = OpConvertFToS %17 %23
               OpSelectionMerge %27 None
               OpSwitch %24 %27 0 %25 42 %26
         %25 = OpLabel
               OpSelectionMerge %30 None
               OpSwitch %28 %30 1 %29
         %29 = OpLabel
         %35 = OpAccessChain %34 %32 %33
         %36 = OpLoad %6 %35
         %38 = OpFOrdGreaterThanEqual %37 %36 %10
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %40
         %39 = OpLabel
               OpStore %9 %41
               OpBranch %30
         %40 = OpLabel
               OpTerminateInvocation
         %30 = OpLabel
               OpBranch %26
         %26 = OpLabel
               OpBranch %27
         %27 = OpLabel
               OpReturn
               OpFunctionEnd
