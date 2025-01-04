#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3 %4
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %3 "_GLF_color"
               OpName %4 "gl_FragCoord"
               OpDecorate %3 Location 0
               OpDecorate %4 BuiltIn FragCoord
          %5 = OpTypeVoid
          %6 = OpTypeFunction %5
          %7 = OpTypeFloat 32
          %8 = OpTypeVector %7 4
          %9 = OpTypePointer Output %8
          %3 = OpVariable %9 Output
         %10 = OpConstant %7 1
         %11 = OpConstant %7 0
         %12 = OpConstantComposite %8 %10 %11 %11 %10
         %13 = OpTypeInt 32 1
         %14 = OpConstant %13 0
         %15 = OpConstant %13 1
         %16 = OpTypeBool
         %17 = OpTypePointer Input %8
          %4 = OpVariable %17 Input
         %18 = OpTypeInt 32 0
         %19 = OpConstant %18 0
         %20 = OpTypePointer Input %7
         %21 = OpConstant %13 10000000
         %22 = OpUndef %8
          %2 = OpFunction %5 None %6
         %23 = OpLabel
               OpStore %3 %12
               OpBranch %24
         %24 = OpLabel
         %25 = OpPhi %8 %22 %23 %26 %27
         %28 = OpPhi %13 %14 %23 %29 %27
         %30 = OpSLessThan %16 %28 %15
               OpLoopMerge %31 %27 None
               OpBranchConditional %30 %32 %31
         %32 = OpLabel
         %33 = OpAccessChain %20 %4 %19
         %34 = OpLoad %7 %33
         %35 = OpConvertFToS %13 %34
         %36 = OpSLessThan %16 %35 %21
               OpSelectionMerge %37 None
               OpBranchConditional %36 %38 %39
         %38 = OpLabel
               OpBranch %27
         %39 = OpLabel
               OpSelectionMerge %40 None
               OpBranchConditional %36 %41 %42
         %41 = OpLabel
               OpBranch %43
         %43 = OpLabel
         %44 = OpPhi %13 %14 %41 %45 %46
         %47 = OpSLessThan %16 %44 %15
               OpLoopMerge %48 %46 None
               OpBranchConditional %47 %49 %48
         %49 = OpLabel
               OpBranch %50
         %50 = OpLabel
         %51 = OpPhi %13 %14 %49 %52 %53
         %54 = OpSLessThan %16 %51 %15
               OpLoopMerge %55 %53 None
               OpBranchConditional %54 %53 %55
         %53 = OpLabel
               OpStore %3 %12
         %52 = OpIAdd %13 %51 %15
               OpBranch %50
         %55 = OpLabel
               OpBranch %46
         %46 = OpLabel
         %45 = OpIAdd %13 %44 %15
               OpBranch %43
         %48 = OpLabel
               OpBranch %56
         %56 = OpLabel
         %57 = OpPhi %8 %25 %48 %12 %58
         %59 = OpPhi %13 %14 %48 %60 %58
         %61 = OpSLessThan %16 %59 %15
               OpLoopMerge %62 %58 None
               OpBranchConditional %61 %58 %62
         %58 = OpLabel
         %60 = OpIAdd %13 %59 %15
               OpBranch %56
         %62 = OpLabel
               OpStore %3 %57
               OpBranch %40
         %42 = OpLabel
               OpTerminateInvocation
         %40 = OpLabel
               OpBranch %27
         %37 = OpLabel
               OpBranch %27
         %27 = OpLabel
         %26 = OpPhi %8 %25 %38 %57 %40 %22 %37
         %29 = OpIAdd %13 %28 %15
               OpBranch %24
         %31 = OpLabel
               OpReturn
               OpFunctionEnd
