#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 73
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %65
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "func("
               OpName %11 "loop_count"
               OpName %28 "buf0"
               OpMemberName %28 0 "injectionSwitch"
               OpName %30 ""
               OpName %65 "_GLF_color"
               OpMemberDecorate %28 0 Offset 0
               OpDecorate %28 Block
               OpDecorate %30 DescriptorSet 0
               OpDecorate %30 Binding 0
               OpDecorate %65 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 0
         %18 = OpConstant %6 1
         %26 = OpTypeFloat 32
         %27 = OpTypeVector %26 2
         %28 = OpTypeStruct %27
         %29 = OpTypePointer Uniform %28
         %30 = OpVariable %29 Uniform
         %31 = OpTypeInt 32 0
         %32 = OpConstant %31 0
         %33 = OpTypePointer Uniform %26
         %36 = OpConstant %31 1
         %39 = OpTypeBool
         %53 = OpConstant %6 100
         %63 = OpTypeVector %26 4
         %64 = OpTypePointer Output %63
         %65 = OpVariable %64 Output
         %66 = OpConstant %26 1
         %67 = OpConstant %26 0
         %68 = OpConstantComposite %63 %66 %67 %67 %66
         %70 = OpConstantComposite %63 %66 %66 %66 %66
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %59 = OpFunctionCall %6 %8
         %60 = OpIEqual %39 %59 %18
               OpSelectionMerge %62 None
               OpBranchConditional %60 %61 %69
         %61 = OpLabel
               OpStore %65 %68
               OpBranch %62
         %69 = OpLabel
               OpStore %65 %70
               OpBranch %62
         %62 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
               OpStore %11 %12
               OpBranch %13
         %13 = OpLabel
         %71 = OpPhi %6 %12 %9 %25 %16
               OpLoopMerge %15 %16 None
               OpBranch %14
         %14 = OpLabel
         %19 = OpIAdd %6 %71 %18
               OpStore %11 %19
               OpBranch %20
         %20 = OpLabel
         %72 = OpPhi %6 %19 %14 %25 %23
               OpLoopMerge %22 %23 None
               OpBranch %21
         %21 = OpLabel
         %25 = OpIAdd %6 %72 %18
               OpStore %11 %25
         %34 = OpAccessChain %33 %30 %12 %32
         %35 = OpLoad %26 %34
         %37 = OpAccessChain %33 %30 %12 %36
         %38 = OpLoad %26 %37
         %40 = OpFOrdLessThan %39 %35 %38
               OpSelectionMerge %42 None
               OpBranchConditional %40 %41 %42
         %41 = OpLabel
               OpReturnValue %18
         %42 = OpLabel
         %44 = OpAccessChain %33 %30 %12 %32
         %45 = OpLoad %26 %44
         %46 = OpAccessChain %33 %30 %12 %36
         %47 = OpLoad %26 %46
         %48 = OpFOrdLessThan %39 %45 %47
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %50
         %49 = OpLabel
               OpBranch %22
         %50 = OpLabel
               OpBranch %23
         %23 = OpLabel
         %54 = OpSLessThan %39 %25 %53
               OpBranchConditional %54 %20 %22
         %22 = OpLabel
               OpBranch %16
         %16 = OpLabel
         %56 = OpSLessThan %39 %25 %53
               OpBranchConditional %56 %13 %15
         %15 = OpLabel
               OpReturnValue %12
               OpFunctionEnd
