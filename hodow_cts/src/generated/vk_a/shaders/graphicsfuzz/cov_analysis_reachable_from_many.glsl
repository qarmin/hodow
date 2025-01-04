#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 75
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %71
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %11 "s"
               OpName %15 "i"
               OpName %23 "buf0"
               OpMemberName %23 0 "zero"
               OpName %25 ""
               OpName %36 "j"
               OpName %60 "c"
               OpName %71 "_GLF_color"
               OpMemberDecorate %23 0 Offset 0
               OpDecorate %23 Block
               OpDecorate %25 DescriptorSet 0
               OpDecorate %25 Binding 0
               OpDecorate %71 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 2
         %13 = OpTypeInt 32 1
         %14 = OpTypePointer Function %13
         %16 = OpConstant %13 0
         %23 = OpTypeStruct %13
         %24 = OpTypePointer Uniform %23
         %25 = OpVariable %24 Uniform
         %26 = OpTypePointer Uniform %13
         %29 = OpConstant %13 1
         %31 = OpTypeBool
         %33 = OpConstant %6 3
         %43 = OpConstant %13 10
         %58 = OpTypeVector %6 4
         %59 = OpTypePointer Function %58
         %62 = OpConstant %6 0
         %63 = OpConstant %6 1
         %66 = OpConstant %6 5
         %70 = OpTypePointer Output %58
         %71 = OpVariable %70 Output
         %74 = OpConstantComposite %58 %62 %62 %62 %62
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %60 = OpVariable %59 Function
         %61 = OpFunctionCall %6 %8
         %64 = OpCompositeConstruct %58 %61 %62 %62 %63
               OpStore %60 %64
         %65 = OpFunctionCall %6 %8
         %67 = OpFOrdEqual %31 %65 %66
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %73
         %68 = OpLabel
         %72 = OpLoad %58 %60
               OpStore %71 %72
               OpBranch %69
         %73 = OpLabel
               OpStore %71 %74
               OpBranch %69
         %69 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
         %15 = OpVariable %14 Function
         %36 = OpVariable %14 Function
               OpStore %11 %12
               OpStore %15 %16
               OpBranch %17
         %17 = OpLabel
               OpLoopMerge %19 %20 None
               OpBranch %21
         %21 = OpLabel
         %22 = OpLoad %13 %15
         %27 = OpAccessChain %26 %25 %16
         %28 = OpLoad %13 %27
         %30 = OpIAdd %13 %28 %29
         %32 = OpSLessThan %31 %22 %30
               OpBranchConditional %32 %18 %19
         %18 = OpLabel
         %34 = OpLoad %6 %11
         %35 = OpFAdd %6 %34 %33
               OpStore %11 %35
               OpStore %36 %16
               OpBranch %37
         %37 = OpLabel
               OpLoopMerge %39 %40 None
               OpBranch %41
         %41 = OpLabel
         %42 = OpLoad %13 %36
         %44 = OpSLessThan %31 %42 %43
               OpBranchConditional %44 %38 %39
         %38 = OpLabel
         %45 = OpAccessChain %26 %25 %16
         %46 = OpLoad %13 %45
         %47 = OpIEqual %31 %46 %29
               OpSelectionMerge %49 None
               OpBranchConditional %47 %48 %49
         %48 = OpLabel
               OpTerminateInvocation
         %49 = OpLabel
               OpBranch %40
         %40 = OpLabel
         %51 = OpLoad %13 %36
         %52 = OpIAdd %13 %51 %29
               OpStore %36 %52
               OpBranch %37
         %39 = OpLabel
               OpBranch %20
         %20 = OpLabel
         %53 = OpLoad %13 %15
         %54 = OpIAdd %13 %53 %29
               OpStore %15 %54
               OpBranch %17
         %19 = OpLabel
         %55 = OpLoad %6 %11
               OpReturnValue %55
               OpFunctionEnd
