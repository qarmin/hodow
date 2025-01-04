#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 64
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %22 %45
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %22 "gl_FragCoord"
               OpName %45 "_GLF_color"
               OpDecorate %22 BuiltIn FragCoord
               OpDecorate %45 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %9 = OpConstant %6 0
         %16 = OpConstant %6 10
         %17 = OpTypeBool
         %19 = OpTypeFloat 32
         %20 = OpTypeVector %19 4
         %21 = OpTypePointer Input %20
         %22 = OpVariable %21 Input
         %23 = OpTypeInt 32 0
         %24 = OpConstant %23 1
         %25 = OpTypePointer Input %19
         %28 = OpConstant %19 0
         %32 = OpConstant %23 0
         %42 = OpConstant %6 1
         %44 = OpTypePointer Output %20
         %45 = OpVariable %44 Output
         %46 = OpConstant %19 1
         %47 = OpConstantComposite %20 %46 %28 %28 %46
         %55 = OpConstantFalse %17
         %58 = OpConstantTrue %17
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %52
         %52 = OpLabel
               OpLoopMerge %51 %54 None
               OpBranch %10
         %10 = OpLabel
         %61 = OpPhi %6 %9 %52 %43 %37
         %18 = OpSLessThan %17 %61 %16
               OpLoopMerge %12 %37 None
               OpBranchConditional %18 %11 %12
         %11 = OpLabel
         %26 = OpAccessChain %25 %22 %24
         %27 = OpLoad %19 %26
         %29 = OpFOrdLessThan %17 %27 %28
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %31
         %30 = OpLabel
         %33 = OpAccessChain %25 %22 %32
         %34 = OpLoad %19 %33
         %35 = OpFOrdLessThan %17 %34 %28
               OpSelectionMerge %63 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
               OpBranch %12
         %63 = OpLabel
               OpBranch %37
         %37 = OpLabel
         %43 = OpIAdd %6 %61 %42
               OpBranch %10
         %31 = OpLabel
         %50 = OpFunctionCall %2 %48
               OpBranch %12
         %12 = OpLabel
         %62 = OpPhi %17 %55 %10 %55 %36 %58 %31
               OpSelectionMerge %59 None
               OpBranchConditional %62 %51 %59
         %59 = OpLabel
               OpStore %45 %47
               OpBranch %51
         %54 = OpLabel
               OpBranch %52
         %51 = OpLabel
               OpReturn
               OpFunctionEnd
         %48 = OpFunction %2 None %3
         %49 = OpLabel
               OpTerminateInvocation
               OpFunctionEnd
