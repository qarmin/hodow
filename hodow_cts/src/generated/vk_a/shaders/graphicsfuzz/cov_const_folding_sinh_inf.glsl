#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 43
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %37
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %18 "buf0"
               OpMemberName %18 0 "injectionSwitch"
               OpName %20 ""
               OpName %37 "_GLF_color"
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %37 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 724.322021
         %11 = OpTypeBool
         %17 = OpTypeVector %6 2
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 1
         %22 = OpConstant %21 0
         %23 = OpTypeInt 32 0
         %24 = OpConstant %23 0
         %25 = OpTypePointer Uniform %6
         %28 = OpConstant %23 1
         %35 = OpTypeVector %6 4
         %36 = OpTypePointer Output %35
         %37 = OpVariable %36 Output
         %38 = OpConstant %6 1
         %39 = OpConstant %6 0
         %40 = OpConstantComposite %35 %38 %39 %39 %38
         %42 = OpConstantComposite %35 %39 %39 %39 %39
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpExtInst %6 %1 Sinh %9
               OpStore %8 %10
         %12 = OpLoad %6 %8
         %13 = OpIsInf %11 %12
         %14 = OpLogicalNot %11 %13
               OpSelectionMerge %16 None
               OpBranchConditional %14 %15 %16
         %15 = OpLabel
         %26 = OpAccessChain %25 %20 %22 %24
         %27 = OpLoad %6 %26
         %29 = OpAccessChain %25 %20 %22 %28
         %30 = OpLoad %6 %29
         %31 = OpFOrdLessThan %11 %27 %30
               OpBranch %16
         %16 = OpLabel
         %32 = OpPhi %11 %13 %5 %31 %15
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %41
         %33 = OpLabel
               OpStore %37 %40
               OpBranch %34
         %41 = OpLabel
               OpStore %37 %42
               OpBranch %34
         %34 = OpLabel
               OpReturn
               OpFunctionEnd
