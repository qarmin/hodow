#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 58
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %33
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "func(i1;"
               OpName %9 "x"
               OpName %13 "buf0"
               OpMemberName %13 0 "zero"
               OpName %15 ""
               OpName %33 "_GLF_color"
               OpName %39 "i"
               OpName %51 "param"
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %33 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %2 %7
         %13 = OpTypeStruct %6
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpConstant %6 0
         %17 = OpTypePointer Uniform %6
         %20 = OpTypeBool
         %26 = OpConstant %6 8
         %30 = OpTypeFloat 32
         %31 = OpTypeVector %30 4
         %32 = OpTypePointer Output %31
         %33 = OpVariable %32 Output
         %34 = OpConstant %30 1
         %35 = OpConstant %30 0
         %36 = OpConstantComposite %31 %34 %35 %35 %34
         %38 = OpConstantComposite %31 %35 %35 %35 %35
         %46 = OpConstant %6 10
         %55 = OpConstant %6 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %39 = OpVariable %7 Function
         %51 = OpVariable %7 Function
               OpStore %33 %38
               OpStore %39 %16
               OpBranch %40
         %40 = OpLabel
         %57 = OpPhi %6 %16 %5 %56 %41
         %47 = OpAccessChain %17 %15 %16
         %48 = OpLoad %6 %47
         %49 = OpIAdd %6 %46 %48
         %50 = OpSLessThan %20 %57 %49
               OpLoopMerge %42 %41 None
               OpBranchConditional %50 %41 %42
         %41 = OpLabel
               OpStore %51 %57
         %53 = OpFunctionCall %2 %10 %51
         %56 = OpIAdd %6 %57 %55
               OpStore %39 %56
               OpBranch %40
         %42 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %2 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %12 = OpLoad %6 %9
         %18 = OpAccessChain %17 %15 %16
         %19 = OpLoad %6 %18
         %21 = OpSLessThan %20 %12 %19
               OpSelectionMerge %23 None
               OpBranchConditional %21 %22 %23
         %22 = OpLabel
               OpTerminateInvocation
         %23 = OpLabel
         %25 = OpLoad %6 %9
         %27 = OpSGreaterThan %20 %25 %26
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %37
         %28 = OpLabel
               OpStore %33 %36
               OpBranch %29
         %37 = OpLabel
               OpStore %33 %38
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
