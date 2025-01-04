#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 87
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %32
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %15 "i"
               OpName %18 "buf0"
               OpMemberName %18 0 "injectionSwitch"
               OpName %20 ""
               OpName %32 "gl_FragCoord"
               OpName %55 "i"
               OpName %69 "i"
               OpDecorate %9 Location 0
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %32 BuiltIn FragCoord
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %13 = OpTypeInt 32 1
         %14 = OpTypePointer Function %13
         %16 = OpConstant %13 0
         %17 = OpTypeVector %6 2
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 1
         %23 = OpTypePointer Uniform %6
         %26 = OpTypeBool
         %31 = OpTypePointer Input %7
         %32 = OpVariable %31 Input
         %33 = OpTypePointer Input %6
         %36 = OpConstant %6 -1
         %46 = OpConstant %13 256
         %62 = OpConstant %13 1
         %83 = OpConstantFalse %26
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %15 = OpVariable %14 Function
         %55 = OpVariable %14 Function
         %69 = OpVariable %14 Function
               OpStore %9 %12
               OpStore %15 %16
         %24 = OpAccessChain %23 %20 %16 %22
         %25 = OpLoad %6 %24
         %27 = OpFOrdLessThan %26 %25 %11
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %30
         %28 = OpLabel
               OpBranch %29
         %30 = OpLabel
         %34 = OpAccessChain %33 %32 %22
         %35 = OpLoad %6 %34
         %37 = OpFOrdLessThan %26 %35 %36
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %40
         %38 = OpLabel
               OpBranch %39
         %40 = OpLabel
               OpBranch %41
         %41 = OpLabel
               OpLoopMerge %43 %53 None
               OpBranch %42
         %42 = OpLabel
         %45 = OpLoad %13 %15
         %47 = OpSGreaterThanEqual %26 %45 %46
               OpSelectionMerge %49 None
               OpBranchConditional %47 %48 %49
         %48 = OpLabel
               OpBranch %43
         %49 = OpLabel
               OpBranch %51
         %51 = OpLabel
               OpStore %55 %16
               OpLoopMerge %84 %58 None
               OpBranch %56
         %56 = OpLabel
         %61 = OpLoad %13 %55
         %63 = OpSLessThan %26 %61 %62
               OpLoopMerge %85 %72 None
               OpBranchConditional %63 %57 %85
         %57 = OpLabel
               OpSelectionMerge %68 None
               OpBranchConditional %37 %67 %68
         %67 = OpLabel
               OpStore %69 %16
               OpBranch %70
         %70 = OpLabel
         %75 = OpLoad %13 %69
         %76 = OpSLessThan %26 %75 %62
               OpLoopMerge %86 %71 None
               OpBranchConditional %76 %71 %86
         %71 = OpLabel
         %77 = OpLoad %13 %69
         %78 = OpIAdd %13 %77 %62
               OpStore %69 %78
               OpBranch %70
         %86 = OpLabel
               OpBranch %72
         %72 = OpLabel
         %81 = OpLoad %13 %55
         %82 = OpIAdd %13 %81 %62
               OpStore %55 %82
               OpBranch %56
         %68 = OpLabel
               OpReturn
         %85 = OpLabel
               OpBranch %58
         %58 = OpLabel
               OpBranchConditional %83 %51 %84
         %84 = OpLabel
               OpBranch %53
         %53 = OpLabel
               OpBranchConditional %83 %41 %43
         %43 = OpLabel
               OpBranch %39
         %39 = OpLabel
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
