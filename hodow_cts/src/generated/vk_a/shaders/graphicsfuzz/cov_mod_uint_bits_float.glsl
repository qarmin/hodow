#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 46
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %16
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %16 "_GLF_color"
               OpName %19 "buf0"
               OpMemberName %19 0 "_GLF_uniform_float_values"
               OpName %21 ""
               OpDecorate %16 Location 0
               OpDecorate %18 ArrayStride 16
               OpMemberDecorate %19 0 Offset 0
               OpDecorate %19 Block
               OpDecorate %21 DescriptorSet 0
               OpDecorate %21 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 1
         %12 = OpConstant %6 1
         %14 = OpTypeVector %6 4
         %15 = OpTypePointer Output %14
         %16 = OpVariable %15 Output
         %17 = OpConstant %9 3
         %18 = OpTypeArray %6 %17
         %19 = OpTypeStruct %18
         %20 = OpTypePointer Uniform %19
         %21 = OpVariable %20 Uniform
         %22 = OpTypeInt 32 1
         %23 = OpConstant %22 0
         %24 = OpConstant %22 1
         %25 = OpTypePointer Uniform %6
         %30 = OpConstant %22 2
         %33 = OpTypeBool
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %11 = OpBitcast %6 %10
         %13 = OpFMod %6 %11 %12
               OpStore %8 %13
         %26 = OpAccessChain %25 %21 %23 %24
         %27 = OpLoad %6 %26
         %28 = OpCompositeConstruct %14 %27 %27 %27 %27
               OpStore %16 %28
         %29 = OpLoad %6 %8
         %31 = OpAccessChain %25 %21 %23 %30
         %32 = OpLoad %6 %31
         %34 = OpFOrdLessThan %33 %29 %32
               OpSelectionMerge %36 None
               OpBranchConditional %34 %35 %36
         %35 = OpLabel
         %37 = OpAccessChain %25 %21 %23 %23
         %38 = OpLoad %6 %37
         %39 = OpAccessChain %25 %21 %23 %24
         %40 = OpLoad %6 %39
         %41 = OpAccessChain %25 %21 %23 %24
         %42 = OpLoad %6 %41
         %43 = OpAccessChain %25 %21 %23 %23
         %44 = OpLoad %6 %43
         %45 = OpCompositeConstruct %14 %38 %40 %42 %44
               OpStore %16 %45
               OpBranch %36
         %36 = OpLabel
               OpReturn
               OpFunctionEnd
