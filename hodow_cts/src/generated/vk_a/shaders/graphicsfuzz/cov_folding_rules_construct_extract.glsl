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
               OpName %9 "a"
               OpName %10 "buf0"
               OpMemberName %10 0 "twoandthree"
               OpName %12 ""
               OpName %18 "b"
               OpName %46 "_GLF_color"
               OpMemberDecorate %10 0 Offset 0
               OpDecorate %10 Block
               OpDecorate %12 DescriptorSet 0
               OpDecorate %12 Binding 0
               OpDecorate %46 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpTypeStruct %7
         %11 = OpTypePointer Uniform %10
         %12 = OpVariable %11 Uniform
         %13 = OpTypeInt 32 1
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %7
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Function %6
         %25 = OpConstant %6 1
         %26 = OpConstantComposite %7 %25 %25
         %28 = OpConstant %19 1
         %31 = OpTypeBool
         %34 = OpConstant %6 2
         %44 = OpTypeVector %6 4
         %45 = OpTypePointer Output %44
         %46 = OpVariable %45 Output
         %47 = OpConstant %6 0
         %48 = OpConstantComposite %44 %25 %47 %47 %25
         %50 = OpConstantComposite %44 %47 %47 %47 %47
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %18 = OpVariable %8 Function
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %7 %16
               OpStore %9 %17
         %22 = OpAccessChain %21 %9 %20
         %23 = OpLoad %6 %22
         %24 = OpLoad %7 %9
         %27 = OpExtInst %7 %1 FClamp %24 %26 %26
         %29 = OpCompositeExtract %6 %27 1
         %30 = OpCompositeConstruct %7 %23 %29
               OpStore %18 %30
         %32 = OpAccessChain %21 %18 %20
         %33 = OpLoad %6 %32
         %35 = OpFOrdEqual %31 %33 %34
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
         %38 = OpAccessChain %21 %18 %28
         %39 = OpLoad %6 %38
         %40 = OpFOrdEqual %31 %39 %25
               OpBranch %37
         %37 = OpLabel
         %41 = OpPhi %31 %35 %5 %40 %36
               OpSelectionMerge %43 None
               OpBranchConditional %41 %42 %49
         %42 = OpLabel
               OpStore %46 %48
               OpBranch %43
         %49 = OpLabel
               OpStore %46 %50
               OpBranch %43
         %43 = OpLabel
               OpReturn
               OpFunctionEnd
