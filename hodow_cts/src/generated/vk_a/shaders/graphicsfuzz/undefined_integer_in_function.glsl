#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 80
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %13
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "performPartition("
               OpName %13 "_GLF_color"
               OpName %22 "buf0"
               OpMemberName %22 0 "injectionSwitch"
               OpName %24 ""
               OpName %37 "GLF_live0i"
               OpName %66 "i"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %13 Location 0
               OpMemberDecorate %22 0 Offset 0
               OpDecorate %22 Block
               OpDecorate %24 DescriptorSet 0
               OpDecorate %24 Binding 0
               OpDecorate %37 RelaxedPrecision
               OpDecorate %66 RelaxedPrecision
               OpDecorate %70 RelaxedPrecision
               OpDecorate %73 RelaxedPrecision
               OpDecorate %72 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 4
         %12 = OpTypePointer Output %11
         %13 = OpVariable %12 Output
         %14 = OpConstant %10 1
         %15 = OpConstant %10 0
         %16 = OpConstantComposite %11 %14 %15 %15 %14
         %21 = OpTypeVector %10 2
         %22 = OpTypeStruct %21
         %23 = OpTypePointer Uniform %22
         %24 = OpVariable %23 Uniform
         %25 = OpConstant %6 0
         %26 = OpTypeInt 32 0
         %27 = OpConstant %26 1
         %28 = OpTypePointer Uniform %10
         %31 = OpTypeBool
         %36 = OpTypePointer Function %6
         %44 = OpConstant %6 1
         %65 = OpConstantFalse %31
         %74 = OpUndef %6
         %78 = OpConstantTrue %31
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %70 = OpFunctionCall %6 %8
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %37 = OpVariable %36 Function
         %66 = OpVariable %36 Function
               OpStore %13 %16
               OpBranch %17
         %17 = OpLabel
         %73 = OpPhi %6 %74 %9 %72 %34
               OpLoopMerge %19 %34 None
               OpBranch %18
         %18 = OpLabel
         %29 = OpAccessChain %28 %24 %25 %27
         %30 = OpLoad %10 %29
         %32 = OpFOrdLessThan %31 %30 %15
               OpSelectionMerge %79 None
               OpBranchConditional %32 %33 %35
         %35 = OpLabel
               OpStore %37 %25
               OpBranch %38
         %38 = OpLabel
         %45 = OpSLessThan %31 %25 %44
               OpLoopMerge %49 %41 None
               OpBranch %39
         %39 = OpLabel
               OpSelectionMerge %50 None
               OpBranchConditional %32 %49 %50
         %49 = OpLabel
               OpSelectionMerge %59 None
               OpBranchConditional %32 %58 %59
         %50 = OpLabel
               OpReturnValue %44
         %41 = OpLabel
               OpBranch %38
         %58 = OpLabel
               OpBranch %60
         %60 = OpLabel
               OpLoopMerge %62 %63 None
               OpBranch %61
         %61 = OpLabel
               OpReturnValue %44
         %63 = OpLabel
               OpBranch %60
         %62 = OpLabel
               OpUnreachable
         %59 = OpLabel
               OpBranch %34
         %33 = OpLabel
               OpBranch %34
         %79 = OpLabel
               OpBranch %34
         %34 = OpLabel
         %72 = OpPhi %6 %73 %33 %73 %59 %25 %79
               OpBranchConditional %65 %17 %19
         %19 = OpLabel
               OpReturnValue %72
               OpFunctionEnd
