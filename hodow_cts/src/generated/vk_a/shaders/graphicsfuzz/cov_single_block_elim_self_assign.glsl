#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 64
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %58
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "g"
               OpName %18 "buf0"
               OpMemberName %18 0 "injectionSwitch"
               OpName %20 ""
               OpName %35 "a"
               OpName %58 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %15 RelaxedPrecision
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %31 RelaxedPrecision
               OpDecorate %33 RelaxedPrecision
               OpDecorate %35 RelaxedPrecision
               OpDecorate %36 RelaxedPrecision
               OpDecorate %42 RelaxedPrecision
               OpDecorate %48 RelaxedPrecision
               OpDecorate %49 RelaxedPrecision
               OpDecorate %50 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %58 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %16 = OpTypeFloat 32
         %17 = OpTypeVector %16 2
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 0
         %23 = OpTypePointer Uniform %16
         %26 = OpConstant %16 2
         %29 = OpTypeBool
         %32 = OpConstant %6 1
         %34 = OpTypePointer Function %6
         %43 = OpConstant %21 1
         %52 = OpConstant %6 2
         %56 = OpTypeVector %16 4
         %57 = OpTypePointer Output %56
         %58 = OpVariable %57 Output
         %59 = OpConstant %16 1
         %60 = OpConstant %16 0
         %61 = OpConstantComposite %56 %59 %60 %60 %59
         %63 = OpConstantComposite %56 %60 %60 %60 %60
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %35 = OpVariable %34 Function
               OpStore %8 %9
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %6 %8
         %24 = OpAccessChain %23 %20 %9 %22
         %25 = OpLoad %16 %24
         %27 = OpFAdd %16 %25 %26
         %28 = OpConvertFToS %6 %27
         %30 = OpSLessThan %29 %15 %28
               OpBranchConditional %30 %11 %12
         %11 = OpLabel
         %31 = OpLoad %6 %8
         %33 = OpIAdd %6 %31 %32
               OpStore %8 %33
               OpBranch %13
         %13 = OpLabel
               OpBranch %10
         %12 = OpLabel
         %36 = OpLoad %6 %8
               OpStore %35 %36
               OpBranch %37
         %37 = OpLabel
               OpLoopMerge %39 %40 None
               OpBranch %41
         %41 = OpLabel
         %42 = OpLoad %6 %8
         %44 = OpAccessChain %23 %20 %9 %43
         %45 = OpLoad %16 %44
         %46 = OpConvertFToS %6 %45
         %47 = OpSLessThan %29 %42 %46
               OpBranchConditional %47 %38 %39
         %38 = OpLabel
         %48 = OpLoad %6 %8
         %49 = OpIAdd %6 %48 %32
               OpStore %8 %49
               OpBranch %40
         %40 = OpLabel
               OpBranch %37
         %39 = OpLabel
         %50 = OpLoad %6 %35
               OpStore %35 %50
         %51 = OpLoad %6 %35
         %53 = OpIEqual %29 %51 %52
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %62
         %54 = OpLabel
               OpStore %58 %61
               OpBranch %55
         %62 = OpLabel
               OpStore %58 %63
               OpBranch %55
         %55 = OpLabel
               OpReturn
               OpFunctionEnd
