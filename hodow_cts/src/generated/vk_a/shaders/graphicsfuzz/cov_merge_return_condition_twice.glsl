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
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %48
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %11 "b"
               OpName %17 "buf0"
               OpMemberName %17 0 "three"
               OpName %19 ""
               OpName %48 "_GLF_color"
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %48 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 2
         %17 = OpTypeStruct %6
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypeInt 32 1
         %21 = OpConstant %20 0
         %22 = OpTypePointer Uniform %6
         %25 = OpConstant %6 0
         %26 = OpTypeBool
         %36 = OpConstant %6 1
         %38 = OpConstantFalse %26
         %46 = OpTypeVector %6 4
         %47 = OpTypePointer Output %46
         %48 = OpVariable %47 Output
         %49 = OpConstantComposite %46 %36 %25 %25 %36
         %51 = OpConstantComposite %46 %25 %25 %25 %25
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %42 = OpFunctionCall %6 %8
         %43 = OpFOrdEqual %26 %42 %36
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %50
         %44 = OpLabel
               OpStore %48 %49
               OpBranch %45
         %50 = OpLabel
               OpStore %48 %51
               OpBranch %45
         %45 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
               OpStore %11 %12
               OpBranch %13
         %13 = OpLabel
         %53 = OpPhi %6 %12 %9 %36 %16
               OpLoopMerge %15 %16 None
               OpBranch %14
         %14 = OpLabel
         %23 = OpAccessChain %22 %19 %21
         %24 = OpLoad %6 %23
         %27 = OpFOrdEqual %26 %24 %25
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %29
         %28 = OpLabel
               OpBranch %15
         %29 = OpLabel
         %31 = OpAccessChain %22 %19 %21
         %32 = OpLoad %6 %31
         %33 = OpFOrdEqual %26 %32 %25
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %35
         %34 = OpLabel
               OpReturnValue %36
         %35 = OpLabel
               OpStore %11 %36
               OpBranch %16
         %16 = OpLabel
               OpBranchConditional %38 %13 %15
         %15 = OpLabel
         %52 = OpPhi %6 %53 %28 %36 %16
               OpReturnValue %52
               OpFunctionEnd
