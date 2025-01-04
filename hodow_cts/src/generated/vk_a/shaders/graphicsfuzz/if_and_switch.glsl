#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 58
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %30
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "data"
               OpName %15 "buf0"
               OpMemberName %15 0 "injectionSwitch"
               OpName %17 ""
               OpName %30 "_GLF_color"
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %30 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpTypeVector %6 2
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %7 0
         %19 = OpTypePointer Uniform %6
         %22 = OpTypePointer Function %6
         %24 = OpConstant %12 1
         %28 = OpTypeVector %6 4
         %29 = OpTypePointer Output %28
         %30 = OpVariable %29 Output
         %31 = OpConstant %6 1
         %32 = OpConstant %6 0
         %33 = OpConstantComposite %28 %31 %32 %32 %31
         %36 = OpTypeBool
         %53 = OpConstantComposite %28 %32 %32 %32 %32
         %57 = OpUndef %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %20 = OpAccessChain %19 %17 %13 %18
         %21 = OpLoad %6 %20
         %23 = OpAccessChain %22 %11 %13
               OpStore %23 %21
         %27 = OpAccessChain %22 %11 %24
               OpStore %27 %21
               OpStore %30 %33
         %35 = OpLoad %6 %27
         %37 = OpFOrdGreaterThan %36 %35 %31
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
         %42 = OpConvertFToS %12 %21
               OpSelectionMerge %45 None
               OpSwitch %42 %45 0 %43 1 %44
         %45 = OpLabel
               OpBranch %39
         %43 = OpLabel
               OpBranch %44
         %44 = OpLabel
         %56 = OpPhi %6 %57 %38 %31 %43
         %52 = OpAccessChain %22 %11 %42
               OpStore %52 %56
               OpStore %30 %53
               OpBranch %45
         %39 = OpLabel
               OpReturn
               OpFunctionEnd
