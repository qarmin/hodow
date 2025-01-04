#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 51
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %19 "buf0"
               OpMemberName %19 0 "threeandfour"
               OpName %21 ""
               OpName %46 "_GLF_color"
               OpMemberDecorate %19 0 Offset 0
               OpDecorate %19 Block
               OpDecorate %21 DescriptorSet 0
               OpDecorate %21 Binding 0
               OpDecorate %46 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 2
         %11 = OpConstant %6 3
         %12 = OpConstant %6 4
         %13 = OpConstant %6 5
         %14 = OpConstantComposite %7 %10 %11 %12 %13
         %15 = OpTypeVector %6 2
         %16 = OpConstant %6 6
         %17 = OpConstantComposite %15 %10 %16
         %18 = OpConstant %6 1
         %19 = OpTypeStruct %15
         %20 = OpTypePointer Uniform %19
         %21 = OpVariable %20 Uniform
         %22 = OpTypeInt 32 1
         %23 = OpConstant %22 0
         %24 = OpTypeInt 32 0
         %25 = OpConstant %24 1
         %26 = OpTypePointer Uniform %6
         %30 = OpTypeBool
         %31 = OpTypeVector %30 2
         %32 = OpConstantTrue %30
         %33 = OpConstantFalse %30
         %34 = OpConstantComposite %31 %32 %33
         %39 = OpConstantComposite %7 %18 %16 %12 %13
         %40 = OpTypeVector %30 4
         %45 = OpTypePointer Output %7
         %46 = OpVariable %45 Output
         %47 = OpConstant %6 0
         %48 = OpConstantComposite %7 %18 %47 %47 %18
         %50 = OpConstantComposite %7 %47 %47 %47 %47
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
               OpStore %9 %14
         %27 = OpAccessChain %26 %21 %23 %25
         %28 = OpLoad %6 %27
         %29 = OpCompositeConstruct %15 %18 %28
         %35 = OpSelect %15 %34 %29 %17
         %36 = OpLoad %7 %9
         %37 = OpVectorShuffle %7 %36 %35 4 5 2 3
               OpStore %9 %37
         %38 = OpLoad %7 %9
         %41 = OpFOrdEqual %40 %38 %39
         %42 = OpAll %30 %41
               OpSelectionMerge %44 None
               OpBranchConditional %42 %43 %49
         %43 = OpLabel
               OpStore %46 %48
               OpBranch %44
         %49 = OpLabel
               OpStore %46 %50
               OpBranch %44
         %44 = OpLabel
               OpReturn
               OpFunctionEnd
