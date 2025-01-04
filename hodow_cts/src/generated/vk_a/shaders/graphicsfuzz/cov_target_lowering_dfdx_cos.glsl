#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 48
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %11 %42
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %11 "gl_FragCoord"
               OpName %19 "b"
               OpName %21 "buf0"
               OpMemberName %21 0 "two"
               OpName %23 ""
               OpName %42 "_GLF_color"
               OpDecorate %11 BuiltIn FragCoord
               OpMemberDecorate %21 0 Offset 0
               OpDecorate %21 Block
               OpDecorate %23 DescriptorSet 0
               OpDecorate %23 Binding 0
               OpDecorate %42 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeVector %6 4
         %10 = OpTypePointer Input %9
         %11 = OpVariable %10 Input
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 0
         %14 = OpTypePointer Input %6
         %20 = OpConstant %6 2
         %21 = OpTypeStruct %6
         %22 = OpTypePointer Uniform %21
         %23 = OpVariable %22 Uniform
         %24 = OpTypeInt 32 1
         %25 = OpConstant %24 0
         %26 = OpTypePointer Uniform %6
         %32 = OpConstant %6 1.89999998
         %33 = OpTypeBool
         %36 = OpConstant %6 2.0999999
         %41 = OpTypePointer Output %9
         %42 = OpVariable %41 Output
         %43 = OpConstant %6 1
         %44 = OpConstant %6 0
         %45 = OpConstantComposite %9 %43 %44 %44 %43
         %47 = OpConstantComposite %9 %44 %44 %44 %44
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %19 = OpVariable %7 Function
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %6 %15
         %17 = OpExtInst %6 %1 Cos %16
         %18 = OpDPdx %6 %17
               OpStore %8 %18
         %27 = OpAccessChain %26 %23 %25
         %28 = OpLoad %6 %27
         %29 = OpLoad %6 %8
         %30 = OpExtInst %6 %1 FMix %20 %28 %29
               OpStore %19 %30
         %31 = OpLoad %6 %19
         %34 = OpFOrdGreaterThanEqual %33 %31 %32
         %35 = OpLoad %6 %19
         %37 = OpFOrdLessThanEqual %33 %35 %36
         %38 = OpLogicalAnd %33 %34 %37
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %46
         %39 = OpLabel
               OpStore %42 %45
               OpBranch %40
         %46 = OpLabel
               OpStore %42 %47
               OpBranch %40
         %40 = OpLabel
               OpReturn
               OpFunctionEnd
