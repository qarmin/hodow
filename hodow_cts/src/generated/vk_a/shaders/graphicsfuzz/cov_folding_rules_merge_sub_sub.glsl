#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 49
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %44
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "b"
               OpName %12 "i"
               OpName %24 "a"
               OpName %44 "_GLF_color"
               OpDecorate %12 RelaxedPrecision
               OpDecorate %19 RelaxedPrecision
               OpDecorate %26 RelaxedPrecision
               OpDecorate %37 RelaxedPrecision
               OpDecorate %38 RelaxedPrecision
               OpDecorate %44 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
          %7 = OpTypePointer Function %6
          %9 = OpConstantFalse %6
         %10 = OpTypeInt 32 1
         %11 = OpTypePointer Function %10
         %13 = OpConstant %10 1
         %20 = OpConstant %10 0
         %22 = OpTypeFloat 32
         %23 = OpTypePointer Function %22
         %25 = OpConstant %22 3
         %29 = OpConstant %22 2
         %32 = OpConstant %22 0
         %36 = OpConstantTrue %6
         %42 = OpTypeVector %22 4
         %43 = OpTypePointer Output %42
         %44 = OpVariable %43 Output
         %45 = OpConstant %22 1
         %46 = OpConstantComposite %42 %45 %32 %32 %45
         %48 = OpConstantComposite %42 %32 %32 %32 %32
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %12 = OpVariable %11 Function
         %24 = OpVariable %23 Function
               OpStore %8 %9
               OpStore %12 %13
               OpBranch %14
         %14 = OpLabel
               OpLoopMerge %16 %17 None
               OpBranch %18
         %18 = OpLabel
         %19 = OpLoad %10 %12
         %21 = OpSGreaterThan %6 %19 %20
               OpBranchConditional %21 %15 %16
         %15 = OpLabel
         %26 = OpLoad %10 %12
         %27 = OpConvertSToF %22 %26
         %28 = OpFSub %22 %25 %27
               OpStore %24 %28
         %30 = OpLoad %22 %24
         %31 = OpFSub %22 %29 %30
         %33 = OpFOrdEqual %6 %31 %32
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %35
         %34 = OpLabel
               OpStore %8 %36
               OpBranch %35
         %35 = OpLabel
               OpBranch %17
         %17 = OpLabel
         %37 = OpLoad %10 %12
         %38 = OpISub %10 %37 %13
               OpStore %12 %38
               OpBranch %14
         %16 = OpLabel
         %39 = OpLoad %6 %8
               OpSelectionMerge %41 None
               OpBranchConditional %39 %40 %47
         %40 = OpLabel
               OpStore %44 %46
               OpBranch %41
         %47 = OpLabel
               OpStore %44 %48
               OpBranch %41
         %41 = OpLabel
               OpReturn
               OpFunctionEnd
