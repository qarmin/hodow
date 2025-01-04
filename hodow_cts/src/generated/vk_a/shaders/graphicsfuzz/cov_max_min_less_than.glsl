#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 53
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %13 %29
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %13 "gl_FragCoord"
               OpName %29 "_GLF_color"
               OpName %33 "buf0"
               OpMemberName %33 0 "_GLF_uniform_int_values"
               OpName %35 ""
               OpDecorate %13 BuiltIn FragCoord
               OpDecorate %29 Location 0
               OpDecorate %32 ArrayStride 16
               OpMemberDecorate %33 0 Offset 0
               OpDecorate %33 Block
               OpDecorate %35 DescriptorSet 0
               OpDecorate %35 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 4
         %12 = OpTypePointer Input %11
         %13 = OpVariable %12 Input
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 0
         %16 = OpTypePointer Input %10
         %23 = OpConstant %6 2
         %24 = OpTypeBool
         %28 = OpTypePointer Output %11
         %29 = OpVariable %28 Output
         %30 = OpConstant %10 1
         %31 = OpConstant %14 2
         %32 = OpTypeArray %6 %31
         %33 = OpTypeStruct %32
         %34 = OpTypePointer Uniform %33
         %35 = OpVariable %34 Uniform
         %36 = OpConstant %6 0
         %37 = OpTypePointer Uniform %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %17 = OpAccessChain %16 %13 %15
         %18 = OpLoad %10 %17
         %19 = OpConvertFToS %6 %18
         %20 = OpExtInst %6 %1 SMin %9 %19
         %21 = OpExtInst %6 %1 SMax %9 %20
               OpStore %8 %21
         %22 = OpLoad %6 %8
         %25 = OpSLessThan %24 %22 %23
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %48
         %26 = OpLabel
         %38 = OpAccessChain %37 %35 %36 %36
         %39 = OpLoad %6 %38
         %40 = OpConvertSToF %10 %39
         %41 = OpAccessChain %37 %35 %36 %36
         %42 = OpLoad %6 %41
         %43 = OpConvertSToF %10 %42
         %44 = OpAccessChain %37 %35 %36 %9
         %45 = OpLoad %6 %44
         %46 = OpConvertSToF %10 %45
         %47 = OpCompositeConstruct %11 %30 %40 %43 %46
               OpStore %29 %47
               OpBranch %27
         %48 = OpLabel
         %49 = OpAccessChain %37 %35 %36 %9
         %50 = OpLoad %6 %49
         %51 = OpConvertSToF %10 %50
         %52 = OpCompositeConstruct %11 %51 %51 %51 %51
               OpStore %29 %52
               OpBranch %27
         %27 = OpLabel
               OpReturn
               OpFunctionEnd
