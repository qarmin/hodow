#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 50
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %34 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %19 RelaxedPrecision
               OpDecorate %34 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 2
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpTypePointer Uniform %6
         %20 = OpConstant %6 1
         %27 = OpTypeBool
         %31 = OpTypeFloat 32
         %32 = OpTypeVector %31 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %17 = OpAccessChain %16 %14 %15 %15
         %18 = OpLoad %6 %17
         %19 = OpBitCount %6 %15
         %21 = OpAccessChain %16 %14 %15 %20
         %22 = OpLoad %6 %21
         %23 = OpBitFieldSExtract %6 %18 %19 %22
               OpStore %8 %23
         %24 = OpLoad %6 %8
         %25 = OpAccessChain %16 %14 %15 %15
         %26 = OpLoad %6 %25
         %28 = OpIEqual %27 %24 %26
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %46
         %29 = OpLabel
         %35 = OpAccessChain %16 %14 %15 %20
         %36 = OpLoad %6 %35
         %37 = OpConvertSToF %31 %36
         %38 = OpLoad %6 %8
         %39 = OpConvertSToF %31 %38
         %40 = OpLoad %6 %8
         %41 = OpConvertSToF %31 %40
         %42 = OpAccessChain %16 %14 %15 %20
         %43 = OpLoad %6 %42
         %44 = OpConvertSToF %31 %43
         %45 = OpCompositeConstruct %32 %37 %39 %41 %44
               OpStore %34 %45
               OpBranch %30
         %46 = OpLabel
         %47 = OpLoad %6 %8
         %48 = OpConvertSToF %31 %47
         %49 = OpCompositeConstruct %32 %48 %48 %48 %48
               OpStore %34 %49
               OpBranch %30
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
