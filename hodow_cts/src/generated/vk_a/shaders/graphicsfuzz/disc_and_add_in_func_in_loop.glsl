#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 102
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %52
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %12 "buf0"
               OpMemberName %12 0 "injectionSwitch"
               OpName %14 ""
               OpName %52 "_GLF_color"
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %52 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
         %11 = OpTypeVector %6 2
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 0
         %19 = OpTypePointer Uniform %6
         %22 = OpConstant %6 0
         %23 = OpTypeBool
         %28 = OpConstant %6 1
         %29 = OpConstantComposite %7 %28 %22 %22 %28
         %41 = OpConstantTrue %23
         %47 = OpConstant %17 1
         %51 = OpTypePointer Output %7
         %52 = OpVariable %51 Output
         %63 = OpConstantFalse %23
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %60
         %60 = OpLabel
               OpLoopMerge %59 %62 None
               OpBranch %36
         %36 = OpLabel
        %100 = OpPhi %23 %63 %60 %98 %66
               OpLoopMerge %38 %66 None
               OpBranch %42
         %42 = OpLabel
         %48 = OpAccessChain %19 %14 %16 %47
         %49 = OpLoad %6 %48
         %50 = OpFOrdGreaterThan %23 %49 %22
               OpLoopMerge %44 %45 None
               OpBranchConditional %50 %43 %44
         %43 = OpLabel
               OpBranch %81
         %81 = OpLabel
               OpLoopMerge %82 %83 None
               OpBranch %84
         %84 = OpLabel
         %85 = OpAccessChain %19 %14 %16 %18
         %86 = OpLoad %6 %85
         %87 = OpFOrdGreaterThan %23 %86 %22
               OpSelectionMerge %88 None
               OpBranchConditional %87 %89 %88
         %89 = OpLabel
         %90 = OpFunctionCall %2 %55
         %91 = OpUndef %7
               OpBranch %82
         %88 = OpLabel
         %94 = OpCompositeConstruct %7 %86 %86 %86 %86
         %95 = OpFAdd %7 %29 %94
               OpBranch %82
         %83 = OpLabel
               OpBranch %81
         %82 = OpLabel
         %97 = OpPhi %7 %91 %89 %95 %88
               OpStore %52 %97
               OpBranch %44
         %45 = OpLabel
               OpBranch %42
         %44 = OpLabel
         %98 = OpPhi %23 %100 %42 %41 %82
               OpSelectionMerge %101 None
               OpBranchConditional %98 %38 %66
        %101 = OpLabel
               OpBranch %66
         %66 = OpLabel
               OpBranch %36
         %38 = OpLabel
               OpSelectionMerge %68 None
               OpBranchConditional %98 %59 %68
         %68 = OpLabel
               OpBranch %59
         %62 = OpLabel
               OpBranch %60
         %59 = OpLabel
               OpReturn
               OpFunctionEnd
         %55 = OpFunction %2 None %3
         %56 = OpLabel
               OpTerminateInvocation
               OpFunctionEnd
