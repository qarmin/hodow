#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 53
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %48
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %12 "i"
               OpName %48 "_GLF_color"
               OpDecorate %48 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypeInt 32 1
         %11 = OpTypePointer Function %10
         %13 = OpConstant %10 0
         %20 = OpConstant %10 10
         %21 = OpTypeBool
         %24 = OpConstant %10 5
         %29 = OpConstant %10 1
         %32 = OpConstant %10 8
         %36 = OpConstant %6 0
         %40 = OpConstant %6 1
         %43 = OpConstantFalse %21
         %46 = OpTypeVector %6 4
         %47 = OpTypePointer Output %46
         %48 = OpVariable %47 Output
         %52 = OpConstantComposite %46 %40 %36 %36 %40
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %51
         %44 = OpLabel
         %49 = OpFunctionCall %6 %8
         %50 = OpCompositeConstruct %46 %49 %49 %49 %49
               OpStore %48 %50
               OpBranch %45
         %51 = OpLabel
               OpStore %48 %52
               OpBranch %45
         %45 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %12 = OpVariable %11 Function
               OpStore %12 %13
               OpBranch %14
         %14 = OpLabel
               OpLoopMerge %16 %17 None
               OpBranch %18
         %18 = OpLabel
         %19 = OpLoad %10 %12
         %22 = OpSLessThan %21 %19 %20
               OpBranchConditional %22 %15 %16
         %15 = OpLabel
         %23 = OpLoad %10 %12
         %25 = OpSGreaterThan %21 %23 %24
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %27
         %26 = OpLabel
         %28 = OpLoad %10 %12
         %30 = OpIAdd %10 %28 %29
               OpStore %12 %30
               OpBranch %27
         %27 = OpLabel
         %31 = OpLoad %10 %12
         %33 = OpSGreaterThan %21 %31 %32
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %35
         %34 = OpLabel
               OpReturnValue %36
         %35 = OpLabel
               OpBranch %17
         %17 = OpLabel
         %38 = OpLoad %10 %12
         %39 = OpIAdd %10 %38 %29
               OpStore %12 %39
               OpBranch %14
         %16 = OpLabel
               OpReturnValue %40
               OpFunctionEnd
