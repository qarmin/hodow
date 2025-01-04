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
               OpEntryPoint Fragment %4 "main" %38
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %16 "buf0"
               OpMemberName %16 0 "zeroOne"
               OpName %18 ""
               OpName %26 "d"
               OpName %38 "_GLF_color"
               OpMemberDecorate %16 0 Offset 0
               OpDecorate %16 Block
               OpDecorate %18 DescriptorSet 0
               OpDecorate %18 Binding 0
               OpDecorate %38 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 2
         %11 = OpConstant %6 3
         %12 = OpConstantComposite %7 %10 %11
         %13 = OpConstant %6 4
         %14 = OpConstant %6 5
         %15 = OpConstantComposite %7 %13 %14
         %16 = OpTypeStruct %7
         %17 = OpTypePointer Uniform %16
         %18 = OpVariable %17 Uniform
         %19 = OpTypeInt 32 1
         %20 = OpConstant %19 0
         %21 = OpTypePointer Uniform %7
         %25 = OpTypePointer Function %6
         %28 = OpConstantComposite %7 %10 %14
         %31 = OpConstant %6 0.100000001
         %32 = OpTypeBool
         %36 = OpTypeVector %6 4
         %37 = OpTypePointer Output %36
         %38 = OpVariable %37 Output
         %39 = OpTypeInt 32 0
         %40 = OpConstant %39 0
         %43 = OpConstant %6 1
         %45 = OpConstant %39 1
         %49 = OpConstant %6 0
         %52 = OpConstantComposite %36 %49 %49 %49 %49
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %26 = OpVariable %25 Function
         %22 = OpAccessChain %21 %18 %20
         %23 = OpLoad %7 %22
         %24 = OpExtInst %7 %1 FMix %12 %15 %23
               OpStore %9 %24
         %27 = OpLoad %7 %9
         %29 = OpExtInst %6 %1 Distance %27 %28
               OpStore %26 %29
         %30 = OpLoad %6 %26
         %33 = OpFOrdLessThan %32 %30 %31
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %51
         %34 = OpLabel
         %41 = OpAccessChain %25 %9 %40
         %42 = OpLoad %6 %41
         %44 = OpFSub %6 %42 %43
         %46 = OpAccessChain %25 %9 %45
         %47 = OpLoad %6 %46
         %48 = OpFSub %6 %47 %14
         %50 = OpCompositeConstruct %36 %44 %48 %49 %43
               OpStore %38 %50
               OpBranch %35
         %51 = OpLabel
               OpStore %38 %52
               OpBranch %35
         %35 = OpLabel
               OpReturn
               OpFunctionEnd
