#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 96
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %17 %51
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %17 "gl_FragCoord"
               OpName %30 "buf0"
               OpMemberName %30 0 "injectionSwitch"
               OpName %32 ""
               OpName %51 "_GLF_color"
               OpDecorate %17 BuiltIn FragCoord
               OpMemberDecorate %30 0 Offset 0
               OpDecorate %30 Block
               OpDecorate %32 DescriptorSet 0
               OpDecorate %32 Binding 0
               OpDecorate %51 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
         %15 = OpTypeVector %6 4
         %16 = OpTypePointer Input %15
         %17 = OpVariable %16 Input
         %18 = OpTypeInt 32 0
         %19 = OpConstant %18 0
         %20 = OpTypePointer Input %6
         %23 = OpConstant %6 0
         %24 = OpTypeBool
         %28 = OpConstant %6 1
         %29 = OpTypeVector %6 2
         %30 = OpTypeStruct %29
         %31 = OpTypePointer Uniform %30
         %32 = OpVariable %31 Uniform
         %33 = OpTypeInt 32 1
         %34 = OpConstant %33 0
         %35 = OpConstant %18 1
         %36 = OpTypePointer Uniform %6
         %46 = OpConstantFalse %24
         %50 = OpTypePointer Output %15
         %51 = OpVariable %50 Output
         %52 = OpConstantComposite %15 %28 %23 %23 %28
         %65 = OpConstantTrue %24
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %71
         %71 = OpLabel
               OpLoopMerge %72 %73 None
               OpBranch %75
         %75 = OpLabel
               OpLoopMerge %76 %87 None
               OpBranch %78
         %78 = OpLabel
         %79 = OpAccessChain %20 %17 %19
         %80 = OpLoad %6 %79
         %81 = OpFOrdLessThan %24 %80 %23
               OpSelectionMerge %82 None
               OpBranchConditional %81 %83 %82
         %83 = OpLabel
         %84 = OpAccessChain %36 %32 %34 %35
         %85 = OpLoad %6 %84
         %86 = OpFOrdGreaterThan %24 %28 %85
               OpSelectionMerge %95 None
               OpBranchConditional %86 %88 %87
         %88 = OpLabel
               OpTerminateInvocation
         %95 = OpLabel
	       OpBranch %87
         %87 = OpLabel
               OpBranchConditional %46 %75 %76
         %82 = OpLabel
               OpBranch %76
         %76 = OpLabel
         %94 = OpPhi %24 %65 %82 %46 %87
               OpSelectionMerge %91 None
               OpBranchConditional %94 %72 %91
         %91 = OpLabel
               OpBranch %72
         %73 = OpLabel
               OpBranch %71
         %72 = OpLabel
               OpStore %51 %52
               OpReturn
               OpFunctionEnd
