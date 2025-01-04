#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 72
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %30
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "gl_FragCoord"
               OpName %17 "buf0"
               OpMemberName %17 0 "_GLF_uniform_float_values"
               OpName %19 ""
               OpName %30 "_GLF_color"
               OpDecorate %9 BuiltIn FragCoord
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %30 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Input %7
          %9 = OpVariable %8 Input
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 0
         %12 = OpTypePointer Input %6
         %15 = OpConstant %10 5
         %16 = OpTypeArray %6 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypeInt 32 1
         %21 = OpConstant %20 0
         %22 = OpTypePointer Uniform %6
         %25 = OpTypeBool
         %29 = OpTypePointer Output %7
         %30 = OpVariable %29 Output
         %31 = OpConstant %20 2
         %35 = OpConstant %10 1
         %43 = OpConstant %20 4
         %47 = OpConstant %20 3
         %53 = OpConstant %20 1
         %58 = OpConstant %6 10
         %62 = OpTypeMatrix %7 4
         %64 = OpConstant %6 0
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %13 = OpAccessChain %12 %9 %11
         %14 = OpLoad %6 %13
         %23 = OpAccessChain %22 %19 %21 %21
         %24 = OpLoad %6 %23
         %26 = OpFOrdGreaterThan %25 %14 %24
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %28
         %27 = OpLabel
         %32 = OpAccessChain %22 %19 %21 %31
         %33 = OpLoad %6 %32
         %34 = OpCompositeConstruct %7 %33 %33 %33 %33
               OpStore %30 %34
         %36 = OpAccessChain %12 %9 %35
         %37 = OpLoad %6 %36
         %40 = OpFOrdGreaterThan %25 %37 %24
               OpSelectionMerge %42 None
               OpBranchConditional %40 %41 %42
         %41 = OpLabel
         %44 = OpAccessChain %22 %19 %21 %43
         %45 = OpLoad %6 %44
         %46 = OpCompositeConstruct %7 %45 %45 %45 %45
               OpStore %30 %46
               OpBranch %42
         %42 = OpLabel
         %48 = OpAccessChain %22 %19 %21 %47
         %49 = OpLoad %6 %48
         %50 = OpCompositeConstruct %7 %49 %49 %49 %49
               OpStore %30 %50
               OpBranch %28
         %28 = OpLabel
         %54 = OpAccessChain %22 %19 %21 %53
         %55 = OpLoad %6 %54
         %59 = OpCompositeConstruct %7 %24 %55 %55 %58
               OpStore %30 %59
         %65 = OpCompositeConstruct %7 %24 %64 %64 %64
         %66 = OpCompositeConstruct %7 %64 %24 %64 %64
         %67 = OpCompositeConstruct %7 %64 %64 %24 %64
         %68 = OpCompositeConstruct %7 %64 %64 %64 %24
         %69 = OpCompositeConstruct %62 %65 %66 %67 %68
         %70 = OpLoad %7 %30
         %71 = OpMatrixTimesVector %7 %69 %70
               OpStore %30 %71
               OpReturn
               OpFunctionEnd
