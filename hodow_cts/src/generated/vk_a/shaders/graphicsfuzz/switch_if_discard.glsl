#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 38
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "injectionSwitch"
               OpName %10 ""
               OpName %34 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %34 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeStruct %7
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 1
         %15 = OpTypePointer Uniform %6
         %23 = OpConstant %13 0
         %26 = OpTypeBool
         %32 = OpTypeVector %6 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
         %35 = OpConstant %6 1
         %36 = OpConstant %6 0
         %37 = OpConstantComposite %32 %35 %36 %36 %35
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %16 = OpAccessChain %15 %10 %12 %14
         %17 = OpLoad %6 %16
         %18 = OpConvertFToS %11 %17
               OpSelectionMerge %20 None
               OpSwitch %18 %20 -1 %19
         %19 = OpLabel
         %21 = OpAccessChain %15 %10 %12 %14
         %22 = OpLoad %6 %21
         %24 = OpAccessChain %15 %10 %12 %23
         %25 = OpLoad %6 %24
         %27 = OpFOrdGreaterThan %26 %22 %25
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %29
         %28 = OpLabel
               OpTerminateInvocation
         %29 = OpLabel
               OpBranch %20
         %20 = OpLabel
               OpStore %34 %37
               OpReturn
               OpFunctionEnd
