#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 59
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %52
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "func(i1;"
               OpName %9 "x"
               OpName %22 "a"
               OpName %24 "b"
               OpName %25 "buf0"
               OpMemberName %25 0 "zero"
               OpName %27 ""
               OpName %35 "param"
               OpName %52 "_GLF_color"
               OpMemberDecorate %25 0 Offset 0
               OpDecorate %25 Block
               OpDecorate %27 DescriptorSet 0
               OpDecorate %27 Binding 0
               OpDecorate %52 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %13 = OpConstant %6 10
         %14 = OpTypeBool
         %23 = OpConstant %6 0
         %25 = OpTypeStruct %6
         %26 = OpTypePointer Uniform %25
         %27 = OpVariable %26 Uniform
         %28 = OpTypePointer Uniform %6
         %39 = OpConstant %6 1
         %42 = OpConstant %6 4
         %45 = OpConstant %6 3
         %49 = OpTypeFloat 32
         %50 = OpTypeVector %49 4
         %51 = OpTypePointer Output %50
         %52 = OpVariable %51 Output
         %53 = OpConstant %49 1
         %54 = OpConstant %49 0
         %55 = OpConstantComposite %50 %53 %54 %54 %53
         %57 = OpConstantComposite %50 %54 %54 %54 %54
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %22 = OpVariable %7 Function
         %24 = OpVariable %7 Function
         %35 = OpVariable %7 Function
               OpStore %22 %23
         %29 = OpAccessChain %28 %27 %23
         %30 = OpLoad %6 %29
               OpStore %24 %30
               OpBranch %31
         %31 = OpLabel
         %58 = OpPhi %6 %30 %5 %40 %31
               OpStore %35 %58
         %37 = OpFunctionCall %6 %10 %35
               OpStore %22 %37
         %40 = OpIAdd %6 %58 %39
               OpStore %24 %40
         %43 = OpSLessThan %14 %40 %42
               OpLoopMerge %33 %31 None
               OpBranchConditional %43 %31 %33
         %33 = OpLabel
         %46 = OpIEqual %14 %37 %45
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %56
         %47 = OpLabel
               OpStore %52 %55
               OpBranch %48
         %56 = OpLabel
               OpStore %52 %57
               OpBranch %48
         %48 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %12 = OpLoad %6 %9
         %15 = OpIEqual %14 %12 %13
               OpSelectionMerge %17 None
               OpBranchConditional %15 %16 %17
         %16 = OpLabel
               OpTerminateInvocation
         %17 = OpLabel
         %19 = OpLoad %6 %9
               OpReturnValue %19
               OpFunctionEnd
