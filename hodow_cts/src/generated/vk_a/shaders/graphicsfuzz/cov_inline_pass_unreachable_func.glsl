#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 50
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %15 %44
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %11 "x"
               OpName %15 "gl_FragCoord"
               OpName %44 "_GLF_color"
               OpDecorate %15 BuiltIn FragCoord
               OpDecorate %44 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 2
         %13 = OpTypeVector %6 4
         %14 = OpTypePointer Input %13
         %15 = OpVariable %14 Input
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 0
         %18 = OpTypePointer Input %6
         %21 = OpConstant %6 12
         %22 = OpTypeBool
         %26 = OpConstant %16 1
         %29 = OpConstant %6 13
         %33 = OpConstant %6 1
         %40 = OpConstantFalse %22
         %43 = OpTypePointer Output %13
         %44 = OpVariable %43 Output
         %48 = OpConstant %6 0
         %49 = OpConstantComposite %13 %33 %48 %48 %33
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpSelectionMerge %42 None
               OpBranchConditional %40 %41 %47
         %41 = OpLabel
         %45 = OpFunctionCall %6 %8
         %46 = OpCompositeConstruct %13 %45 %45 %45 %45
               OpStore %44 %46
               OpBranch %42
         %47 = OpLabel
               OpStore %44 %49
               OpBranch %42
         %42 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
               OpStore %11 %12
         %19 = OpAccessChain %18 %15 %17
         %20 = OpLoad %6 %19
         %23 = OpFOrdEqual %22 %20 %21
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %25
         %24 = OpLabel
         %27 = OpAccessChain %18 %15 %26
         %28 = OpLoad %6 %27
         %30 = OpFOrdEqual %22 %28 %29
               OpSelectionMerge %32 None
               OpBranchConditional %30 %31 %32
         %31 = OpLabel
         %34 = OpLoad %6 %11
         %35 = OpFAdd %6 %34 %33
               OpStore %11 %35
               OpBranch %32
         %32 = OpLabel
         %36 = OpLoad %6 %11
               OpReturnValue %36
         %25 = OpLabel
               OpReturnValue %33
               OpFunctionEnd
