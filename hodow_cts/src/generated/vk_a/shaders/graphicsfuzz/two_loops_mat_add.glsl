#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 104
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %92
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf0"
               OpMemberName %8 0 "injectionSwitch"
               OpName %10 ""
               OpName %26 "m44"
               OpName %48 "s"
               OpName %51 "c"
               OpName %52 "i"
               OpName %71 "i"
               OpName %92 "_GLF_color"
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 0
               OpDecorate %51 RelaxedPrecision
               OpDecorate %52 RelaxedPrecision
               OpDecorate %70 RelaxedPrecision
               OpDecorate %71 RelaxedPrecision
               OpDecorate %86 RelaxedPrecision
               OpDecorate %92 Location 0
               OpDecorate %96 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeStruct %7
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %6
         %18 = OpConstant %6 1
         %19 = OpTypeBool
         %23 = OpTypeVector %6 4
         %24 = OpTypeMatrix %23 4
         %25 = OpTypePointer Private %24
         %26 = OpVariable %25 Private
         %27 = OpConstant %6 2
         %28 = OpConstant %6 3
         %29 = OpConstant %6 4
         %30 = OpConstantComposite %23 %18 %27 %28 %29
         %31 = OpConstant %6 5
         %32 = OpConstant %6 6
         %33 = OpConstant %6 7
         %34 = OpConstant %6 8
         %35 = OpConstantComposite %23 %31 %32 %33 %34
         %36 = OpConstant %6 9
         %37 = OpConstant %6 10
         %38 = OpConstant %6 11
         %39 = OpConstant %6 12
         %40 = OpConstantComposite %23 %36 %37 %38 %39
         %41 = OpConstant %6 13
         %42 = OpConstant %6 14
         %43 = OpConstant %6 15
         %44 = OpConstant %6 16
         %45 = OpConstantComposite %23 %41 %42 %43 %44
         %46 = OpConstantComposite %24 %30 %35 %40 %45
         %47 = OpTypePointer Function %6
         %49 = OpConstant %6 0
         %50 = OpTypePointer Function %11
         %59 = OpConstant %11 4
         %63 = OpTypePointer Private %6
         %69 = OpConstant %11 1
         %91 = OpTypePointer Output %23
         %92 = OpVariable %91 Output
         %93 = OpConstantComposite %23 %18 %49 %49 %18
         %95 = OpConstantComposite %23 %49 %49 %49 %18
        %102 = OpConstantTrue %19
        %103 = OpConstantFalse %19
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %48 = OpVariable %47 Function
         %51 = OpVariable %50 Function
         %52 = OpVariable %50 Function
         %71 = OpVariable %50 Function
         %16 = OpAccessChain %15 %10 %12 %14
         %17 = OpLoad %6 %16
         %20 = OpFOrdLessThan %19 %17 %18
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %22
         %21 = OpLabel
               OpStore %26 %46
               OpBranch %22
         %22 = OpLabel
               OpStore %48 %49
               OpStore %51 %12
               OpStore %52 %12
               OpBranch %53
         %53 = OpLabel
         %99 = OpPhi %6 %49 %22 %67 %56
         %96 = OpPhi %11 %12 %22 %70 %56
               OpLoopMerge %55 %56 None
               OpBranch %57
         %57 = OpLabel
         %60 = OpSLessThan %19 %96 %59
               OpBranchConditional %60 %54 %55
         %54 = OpLabel
         %64 = OpAccessChain %63 %26 %12 %96
         %65 = OpLoad %6 %64
         %67 = OpFAdd %6 %99 %65
               OpStore %48 %67
               OpBranch %56
         %56 = OpLabel
         %70 = OpIAdd %11 %96 %69
               OpStore %52 %70
               OpBranch %53
         %55 = OpLabel
               OpStore %71 %59
               OpBranch %72
         %72 = OpLabel
         %98 = OpPhi %6 %99 %55 %84 %75
         %97 = OpPhi %11 %59 %55 %86 %75
               OpLoopMerge %74 %75 None
               OpBranch %76
         %76 = OpLabel
         %78 = OpSLessThan %19 %59 %59
               OpBranchConditional %103 %73 %74
         %73 = OpLabel
         %81 = OpAccessChain %63 %26 %12 %59
         %82 = OpLoad %6 %81
         %84 = OpFAdd %6 %98 %82
               OpStore %48 %84
               OpBranch %75
         %75 = OpLabel
         %86 = OpIAdd %11 %59 %69
               OpStore %71 %86
               OpBranch %72
         %74 = OpLabel
         %88 = OpFOrdEqual %19 %98 %37
               OpSelectionMerge %90 None
               OpBranchConditional %88 %89 %94
         %89 = OpLabel
               OpStore %92 %93
               OpBranch %90
         %94 = OpLabel
               OpStore %92 %95
               OpBranch %90
         %90 = OpLabel
               OpReturn
               OpFunctionEnd
