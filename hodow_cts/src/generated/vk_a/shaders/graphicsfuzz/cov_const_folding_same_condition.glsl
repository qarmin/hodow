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
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %13 "buf0"
               OpMemberName %13 0 "one"
               OpName %15 ""
               OpDecorate %9 Location 0
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %10 %10 %10 %10
         %12 = OpTypeBool
         %13 = OpTypeStruct %6
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %27 = OpConstant %6 1
         %46 = OpConstantComposite %7 %27 %27 %27 %27
         %49 = OpConstantComposite %7 %27 %10 %10 %27
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpStore %9 %11
         %19 = OpAccessChain %18 %15 %17
         %20 = OpLoad %6 %19
         %21 = OpFOrdLessThan %12 %20 %10
         %22 = OpLogicalNot %12 %21
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %25 = OpAccessChain %18 %15 %17
         %26 = OpLoad %6 %25
         %28 = OpFOrdLessThan %12 %26 %27
               OpBranch %24
         %24 = OpLabel
         %29 = OpPhi %12 %21 %5 %28 %23
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %31
         %30 = OpLabel
               OpReturn
         %31 = OpLabel
         %33 = OpAccessChain %18 %15 %17
         %34 = OpLoad %6 %33
         %35 = OpFOrdLessThan %12 %34 %10
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %48
         %36 = OpLabel
               OpBranch %38
         %38 = OpLabel
               OpLoopMerge %40 %41 None
               OpBranch %42
         %42 = OpLabel
         %43 = OpAccessChain %18 %15 %17
         %44 = OpLoad %6 %43
         %45 = OpFOrdLessThan %12 %44 %10
               OpBranchConditional %45 %39 %40
         %39 = OpLabel
               OpStore %9 %46
               OpBranch %40
         %41 = OpLabel
               OpBranch %38
         %40 = OpLabel
               OpBranch %37
         %48 = OpLabel
               OpStore %9 %49
               OpBranch %37
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
