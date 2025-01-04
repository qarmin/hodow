#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 76
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %70
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %11 "buf0"
               OpMemberName %11 0 "injectionSwitch"
               OpName %13 ""
               OpName %70 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 0
               OpDecorate %20 RelaxedPrecision
               OpDecorate %21 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpDecorate %31 RelaxedPrecision
               OpDecorate %32 RelaxedPrecision
               OpDecorate %39 RelaxedPrecision
               OpDecorate %40 RelaxedPrecision
               OpDecorate %43 RelaxedPrecision
               OpDecorate %44 RelaxedPrecision
               OpDecorate %46 RelaxedPrecision
               OpDecorate %50 RelaxedPrecision
               OpDecorate %56 RelaxedPrecision
               OpDecorate %57 RelaxedPrecision
               OpDecorate %60 RelaxedPrecision
               OpDecorate %61 RelaxedPrecision
               OpDecorate %63 RelaxedPrecision
               OpDecorate %70 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 2
         %11 = OpTypeStruct %10
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpConstant %6 0
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %9
         %30 = OpConstant %6 1
         %38 = OpConstant %6 5
         %42 = OpConstant %6 7
         %47 = OpConstant %6 200
         %48 = OpTypeBool
         %51 = OpConstant %6 100
         %55 = OpConstant %6 2
         %59 = OpConstant %6 3
         %64 = OpConstant %6 -2
         %68 = OpTypeVector %9 4
         %69 = OpTypePointer Output %68
         %70 = OpVariable %69 Output
         %71 = OpConstant %9 1
         %72 = OpConstant %9 0
         %73 = OpConstantComposite %68 %71 %72 %72 %71
         %75 = OpConstantComposite %68 %72 %72 %72 %71
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %18 = OpAccessChain %17 %13 %14 %16
         %19 = OpLoad %9 %18
         %20 = OpConvertFToS %6 %19
               OpStore %8 %20
         %21 = OpLoad %6 %8
               OpSelectionMerge %24 None
               OpSwitch %21 %23 0 %22
         %23 = OpLabel
         %60 = OpLoad %6 %8
         %61 = OpISub %6 %60 %59
               OpStore %8 %61
               OpBranch %24
         %22 = OpLabel
               OpBranch %25
         %25 = OpLabel
               OpLoopMerge %27 %28 None
               OpBranch %26
         %26 = OpLabel
         %29 = OpLoad %6 %8
         %31 = OpIAdd %6 %29 %30
               OpStore %8 %31
         %32 = OpLoad %6 %8
               OpSelectionMerge %36 None
               OpSwitch %32 %35 1 %33 2 %34
         %35 = OpLabel
         %43 = OpLoad %6 %8
         %44 = OpIAdd %6 %43 %42
               OpStore %8 %44
               OpBranch %36
         %33 = OpLabel
               OpBranch %28
         %34 = OpLabel
         %39 = OpLoad %6 %8
         %40 = OpIAdd %6 %39 %38
               OpStore %8 %40
               OpBranch %36
         %36 = OpLabel
               OpBranch %28
         %28 = OpLabel
         %46 = OpLoad %6 %8
         %49 = OpSGreaterThan %48 %46 %47
               OpBranchConditional %49 %25 %27
         %27 = OpLabel
         %50 = OpLoad %6 %8
         %52 = OpSGreaterThan %48 %50 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %56 = OpLoad %6 %8
         %57 = OpISub %6 %56 %55
               OpStore %8 %57
               OpBranch %24
         %54 = OpLabel
               OpBranch %23
         %24 = OpLabel
         %63 = OpLoad %6 %8
         %65 = OpIEqual %48 %63 %64
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %74
         %66 = OpLabel
               OpStore %70 %73
               OpBranch %67
         %74 = OpLabel
               OpStore %70 %75
               OpBranch %67
         %67 = OpLabel
               OpReturn
               OpFunctionEnd
