#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 57
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %31
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "b"
               OpName %16 "c"
               OpName %31 "_GLF_color"
               OpName %34 "buf0"
               OpMemberName %34 0 "_GLF_uniform_int_values"
               OpName %36 ""
               OpDecorate %31 Location 0
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 2004318071
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 -1
         %14 = OpConstant %12 1
         %24 = OpTypeBool
         %28 = OpTypeFloat 32
         %29 = OpTypeVector %28 4
         %30 = OpTypePointer Output %29
         %31 = OpVariable %30 Output
         %32 = OpConstant %6 2
         %33 = OpTypeArray %12 %32
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpConstant %12 0
         %38 = OpTypePointer Uniform %12
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
         %16 = OpVariable %7 Function
               OpStore %8 %9
         %11 = OpLoad %6 %8
         %15 = OpBitFieldUExtract %6 %11 %13 %14
               OpStore %10 %15
         %17 = OpLoad %6 %8
         %18 = OpLoad %6 %10
         %19 = OpBitwiseOr %6 %17 %18
               OpStore %16 %19
         %20 = OpLoad %6 %16
         %21 = OpLoad %6 %8
         %22 = OpBitwiseAnd %6 %20 %21
         %23 = OpLoad %6 %8
         %25 = OpIEqual %24 %22 %23
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %52
         %26 = OpLabel
         %39 = OpAccessChain %38 %36 %37 %37
         %40 = OpLoad %12 %39
         %41 = OpConvertSToF %28 %40
         %42 = OpAccessChain %38 %36 %37 %14
         %43 = OpLoad %12 %42
         %44 = OpConvertSToF %28 %43
         %45 = OpAccessChain %38 %36 %37 %14
         %46 = OpLoad %12 %45
         %47 = OpConvertSToF %28 %46
         %48 = OpAccessChain %38 %36 %37 %37
         %49 = OpLoad %12 %48
         %50 = OpConvertSToF %28 %49
         %51 = OpCompositeConstruct %29 %41 %44 %47 %50
               OpStore %31 %51
               OpBranch %27
         %52 = OpLabel
         %53 = OpAccessChain %38 %36 %37 %14
         %54 = OpLoad %12 %53
         %55 = OpConvertSToF %28 %54
         %56 = OpCompositeConstruct %29 %55 %55 %55 %55
               OpStore %31 %56
               OpBranch %27
         %27 = OpLabel
               OpReturn
               OpFunctionEnd
