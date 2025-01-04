#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 54
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %49
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %13 "coord"
               OpName %27 "tmp3"
               OpName %30 "tmp2"
               OpName %38 "tmp"
               OpName %49 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %44 RelaxedPrecision
               OpDecorate %49 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 2
         %12 = OpTypePointer Function %11
         %14 = OpConstant %10 1
         %15 = OpConstantComposite %11 %14 %14
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 1
         %18 = OpTypePointer Function %10
         %22 = OpConstant %6 180
         %23 = OpTypeBool
         %28 = OpTypeArray %10 %17
         %29 = OpTypePointer Function %28
         %31 = OpConstant %6 0
         %36 = OpTypeVector %10 4
         %37 = OpTypePointer Function %36
         %41 = OpConstant %6 1
         %48 = OpTypePointer Output %36
         %49 = OpVariable %48 Output
         %50 = OpConstant %10 0
         %51 = OpConstantComposite %36 %14 %50 %50 %14
         %53 = OpConstantComposite %36 %50 %50 %50 %14
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %44 = OpFunctionCall %6 %8
         %45 = OpIEqual %23 %44 %41
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %52
         %46 = OpLabel
               OpStore %49 %51
               OpBranch %47
         %52 = OpLabel
               OpStore %49 %53
               OpBranch %47
         %47 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %13 = OpVariable %12 Function
         %27 = OpVariable %18 Function
         %30 = OpVariable %29 Function
         %38 = OpVariable %37 Function
               OpStore %13 %15
         %19 = OpAccessChain %18 %13 %17
         %20 = OpLoad %10 %19
         %21 = OpConvertFToS %6 %20
         %24 = OpSLessThan %23 %21 %22
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %34
         %25 = OpLabel
         %32 = OpAccessChain %18 %30 %31
         %33 = OpLoad %10 %32
               OpStore %27 %33
               OpBranch %26
         %34 = OpLabel
               OpTerminateInvocation
         %26 = OpLabel
         %40 = OpCompositeConstruct %36 %33 %33 %33 %33
               OpStore %38 %40
               OpReturnValue %41
               OpFunctionEnd
