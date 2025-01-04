#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 58
; Schema: 0
               OpCapability Shader
               OpCapability SignedZeroInfNanPreserve
               OpExtension "SPV_KHR_float_controls"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %11 %54
               OpExecutionMode %4 OriginUpperLeft
               OpExecutionMode %4 SignedZeroInfNanPreserve 32
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %11 "gl_FragCoord"
               OpName %37 "buf0"
               OpMemberName %37 0 "zero"
               OpName %39 ""
               OpName %54 "_GLF_color"
               OpDecorate %11 BuiltIn FragCoord
               OpMemberDecorate %37 0 Offset 0
               OpDecorate %37 Block
               OpDecorate %39 DescriptorSet 0
               OpDecorate %39 Binding 0
               OpDecorate %54 Location 0
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
         %17 = OpConstant %6 -0x1.8p+128
         %20 = OpConstant %6 5
         %23 = OpConstant %6 0
         %24 = OpTypeBool
         %28 = OpConstant %6 1
         %37 = OpTypeStruct %6
         %38 = OpTypePointer Uniform %37
         %39 = OpVariable %38 Uniform
         %40 = OpTypeInt 32 1
         %41 = OpConstant %40 0
         %42 = OpTypePointer Uniform %6
         %53 = OpTypePointer Output %9
         %54 = OpVariable %53 Output
         %55 = OpConstantComposite %9 %28 %23 %23 %28
         %57 = OpConstantComposite %9 %23 %23 %23 %23
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %6 %15
               OpStore %8 %16
         %18 = OpLoad %6 %8
         %19 = OpFAdd %6 %18 %17
               OpStore %8 %19
         %21 = OpLoad %6 %8
         %22 = OpFDiv %6 %20 %21
         %25 = OpFOrdEqual %24 %22 %23
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %27
         %26 = OpLabel
         %29 = OpLoad %6 %8
         %30 = OpFAdd %6 %29 %28
               OpStore %8 %30
               OpBranch %27
         %27 = OpLabel
         %31 = OpLoad %6 %8
         %32 = OpIsNan %24 %31
         %33 = OpLogicalNot %24 %32
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %35
         %34 = OpLabel
         %36 = OpLoad %6 %8
         %43 = OpAccessChain %42 %39 %41
         %44 = OpLoad %6 %43
         %45 = OpFOrdNotEqual %24 %36 %44
               OpBranch %35
         %35 = OpLabel
         %46 = OpPhi %24 %32 %27 %45 %34
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %48
         %47 = OpLabel
               OpStore %8 %23
               OpBranch %48
         %48 = OpLabel
         %49 = OpLoad %6 %8
         %50 = OpFOrdEqual %24 %49 %23
               OpSelectionMerge %52 None
               OpBranchConditional %50 %51 %56
         %51 = OpLabel
               OpStore %54 %55
               OpBranch %52
         %56 = OpLabel
               OpStore %54 %57
               OpBranch %52
         %52 = OpLabel
               OpReturn
               OpFunctionEnd
