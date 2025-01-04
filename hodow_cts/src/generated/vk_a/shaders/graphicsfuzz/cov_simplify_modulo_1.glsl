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
               OpEntryPoint Fragment %4 "main" %31
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %31 "_GLF_color"
               OpName %34 "buf1"
               OpMemberName %34 0 "_GLF_uniform_int_values"
               OpName %36 ""
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %31 Location 0
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 2
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %6
         %20 = OpConstant %6 1
         %25 = OpTypeBool
         %29 = OpTypeVector %6 4
         %30 = OpTypePointer Output %29
         %31 = OpVariable %30 Output
         %32 = OpConstant %9 1
         %33 = OpTypeArray %15 %32
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpTypePointer Uniform %15
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %16 %16
         %19 = OpLoad %6 %18
         %21 = OpFMod %6 %19 %20
               OpStore %8 %21
         %22 = OpLoad %6 %8
         %23 = OpAccessChain %17 %14 %16 %16
         %24 = OpLoad %6 %23
         %26 = OpFOrdEqual %25 %22 %24
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %47
         %27 = OpLabel
         %38 = OpAccessChain %37 %36 %16 %16
         %39 = OpLoad %15 %38
         %40 = OpConvertSToF %6 %39
         %41 = OpLoad %6 %8
         %42 = OpLoad %6 %8
         %43 = OpAccessChain %37 %36 %16 %16
         %44 = OpLoad %15 %43
         %45 = OpConvertSToF %6 %44
         %46 = OpCompositeConstruct %29 %40 %41 %42 %45
               OpStore %31 %46
               OpBranch %28
         %47 = OpLabel
         %48 = OpLoad %6 %8
         %49 = OpCompositeConstruct %29 %48 %48 %48 %48
               OpStore %31 %49
               OpBranch %28
         %28 = OpLabel
               OpReturn
               OpFunctionEnd
