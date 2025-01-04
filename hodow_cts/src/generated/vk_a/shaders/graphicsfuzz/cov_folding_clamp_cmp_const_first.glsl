#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 45
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %14 "buf0"
               OpMemberName %14 0 "one"
               OpName %16 ""
               OpName %40 "_GLF_color"
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %40 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %14 = OpTypeStruct %6
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpTypePointer Uniform %6
         %24 = OpConstant %6 10
         %26 = OpConstant %6 8
         %27 = OpConstant %6 9
         %32 = OpTypeBool
         %38 = OpTypeVector %6 4
         %39 = OpTypePointer Output %38
         %40 = OpVariable %39 Output
         %41 = OpConstant %6 0
         %42 = OpConstantComposite %38 %9 %41 %41 %9
         %44 = OpConstantComposite %38 %41 %41 %41 %41
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
               OpStore %8 %9
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %11
         %11 = OpLabel
         %20 = OpAccessChain %19 %16 %18
         %21 = OpLoad %6 %20
         %22 = OpLoad %6 %8
         %23 = OpFAdd %6 %22 %21
               OpStore %8 %23
               OpBranch %13
         %13 = OpLabel
         %25 = OpLoad %6 %8
         %28 = OpAccessChain %19 %16 %18
         %29 = OpLoad %6 %28
         %30 = OpFAdd %6 %27 %29
         %31 = OpExtInst %6 %1 FClamp %25 %26 %30
         %33 = OpFOrdGreaterThan %32 %24 %31
               OpBranchConditional %33 %10 %12
         %12 = OpLabel
         %34 = OpLoad %6 %8
         %35 = OpFOrdEqual %32 %34 %24
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %43
         %36 = OpLabel
               OpStore %40 %42
               OpBranch %37
         %43 = OpLabel
               OpStore %40 %44
               OpBranch %37
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
