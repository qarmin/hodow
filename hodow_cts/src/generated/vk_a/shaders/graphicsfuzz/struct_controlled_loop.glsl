#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 63
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %50
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "S"
               OpMemberName %9 0 "f0"
               OpMemberName %9 1 "f1"
               OpName %11 "ll"
               OpName %26 "buf0"
               OpMemberName %26 0 "injectionSwitch"
               OpName %28 ""
               OpName %39 "sums"
               OpName %50 "_GLF_color"
               OpMemberDecorate %9 0 RelaxedPrecision
               OpDecorate %23 RelaxedPrecision
               OpMemberDecorate %26 0 Offset 0
               OpDecorate %26 Block
               OpDecorate %28 DescriptorSet 0
               OpDecorate %28 Binding 0
               OpDecorate %44 RelaxedPrecision
               OpDecorate %46 RelaxedPrecision
               OpDecorate %50 Location 0
               OpDecorate %59 RelaxedPrecision
               OpDecorate %60 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeBool
          %8 = OpTypeVector %7 3
          %9 = OpTypeStruct %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpConstant %6 0
         %13 = OpConstantTrue %7
         %14 = OpConstantComposite %8 %13 %13 %13
         %15 = OpConstantComposite %9 %12 %14
         %24 = OpTypeFloat 32
         %25 = OpTypeVector %24 2
         %26 = OpTypeStruct %25
         %27 = OpTypePointer Uniform %26
         %28 = OpVariable %27 Uniform
         %29 = OpTypeInt 32 0
         %30 = OpConstant %29 1
         %31 = OpTypePointer Uniform %24
         %36 = OpConstant %29 9
         %37 = OpTypeArray %24 %36
         %38 = OpTypePointer Function %37
         %40 = OpConstant %24 0
         %41 = OpTypePointer Function %24
         %45 = OpConstant %6 1
         %48 = OpTypeVector %24 4
         %49 = OpTypePointer Output %48
         %50 = OpVariable %49 Output
         %51 = OpConstant %24 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %39 = OpVariable %38 Function
               OpStore %11 %15
               OpBranch %16
         %16 = OpLabel
               OpLoopMerge %18 %19 None
               OpBranch %20
         %20 = OpLabel
         %59 = OpLoad %9 %11
         %23 = OpCompositeExtract %6 %59 0
         %32 = OpAccessChain %31 %28 %12 %30
         %33 = OpLoad %24 %32
         %34 = OpConvertFToS %6 %33
         %35 = OpINotEqual %7 %23 %34
               OpBranchConditional %35 %17 %18
         %17 = OpLabel
         %42 = OpAccessChain %41 %39 %12
               OpStore %42 %40
               OpBranch %19
         %19 = OpLabel
         %60 = OpLoad %9 %11
         %44 = OpCompositeExtract %6 %60 0
         %46 = OpIAdd %6 %44 %45
         %61 = OpLoad %9 %11
         %62 = OpCompositeInsert %9 %46 %61 0
               OpStore %11 %62
               OpBranch %16
         %18 = OpLabel
         %53 = OpAccessChain %41 %39 %12
         %54 = OpLoad %24 %53
         %55 = OpCompositeConstruct %25 %54 %54
         %56 = OpCompositeExtract %24 %55 0
         %57 = OpCompositeExtract %24 %55 1
         %58 = OpCompositeConstruct %48 %51 %56 %57 %51
               OpStore %50 %58
               OpReturn
               OpFunctionEnd
