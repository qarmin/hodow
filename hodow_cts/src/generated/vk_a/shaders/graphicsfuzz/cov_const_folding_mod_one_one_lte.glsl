#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 42
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %16
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %16 "_GLF_color"
               OpName %21 "buf0"
               OpMemberName %21 0 "_GLF_uniform_int_values"
               OpName %23 ""
               OpDecorate %16 Location 0
               OpDecorate %20 ArrayStride 16
               OpMemberDecorate %21 0 Offset 0
               OpDecorate %21 Block
               OpDecorate %23 DescriptorSet 0
               OpDecorate %23 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpConstant %6 1
          %9 = OpConstant %6 0.00999999978
         %10 = OpTypeBool
         %14 = OpTypeVector %6 4
         %15 = OpTypePointer Output %14
         %16 = OpVariable %15 Output
         %17 = OpTypeInt 32 1
         %18 = OpTypeInt 32 0
         %19 = OpConstant %18 2
         %20 = OpTypeArray %17 %19
         %21 = OpTypeStruct %20
         %22 = OpTypePointer Uniform %21
         %23 = OpVariable %22 Uniform
         %24 = OpConstant %17 0
         %25 = OpTypePointer Uniform %17
         %32 = OpConstant %17 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpFMod %6 %7 %7
         %11 = OpFOrdLessThanEqual %10 %8 %9
               OpSelectionMerge %13 None
               OpBranchConditional %11 %12 %37
         %12 = OpLabel
         %26 = OpAccessChain %25 %23 %24 %24
         %27 = OpLoad %17 %26
         %28 = OpConvertSToF %6 %27
         %29 = OpAccessChain %25 %23 %24 %24
         %30 = OpLoad %17 %29
         %31 = OpConvertSToF %6 %30
         %33 = OpAccessChain %25 %23 %24 %32
         %34 = OpLoad %17 %33
         %35 = OpConvertSToF %6 %34
         %36 = OpCompositeConstruct %14 %7 %28 %31 %35
               OpStore %16 %36
               OpBranch %13
         %37 = OpLabel
         %38 = OpAccessChain %25 %23 %24 %24
         %39 = OpLoad %17 %38
         %40 = OpConvertSToF %6 %39
         %41 = OpCompositeConstruct %14 %40 %40 %40 %40
               OpStore %16 %41
               OpBranch %13
         %13 = OpLabel
               OpReturn
               OpFunctionEnd
