#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 63
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %12 %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "fx("
               OpName %12 "gl_FragCoord"
               OpName %24 "buf0"
               OpMemberName %24 0 "injectionSwitch"
               OpName %26 ""
               OpName %40 "_GLF_color"
               OpName %45 "x2"
               OpName %46 "B"
               OpName %57 "k0"
               OpDecorate %12 BuiltIn FragCoord
               OpMemberDecorate %24 0 Offset 0
               OpDecorate %24 Block
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 0
               OpDecorate %40 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypeVector %6 4
         %11 = OpTypePointer Input %10
         %12 = OpVariable %11 Input
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 1
         %15 = OpTypePointer Input %6
         %18 = OpConstant %6 0
         %19 = OpTypeBool
         %23 = OpTypeVector %6 2
         %24 = OpTypeStruct %23
         %25 = OpTypePointer Uniform %24
         %26 = OpVariable %25 Uniform
         %27 = OpTypeInt 32 1
         %28 = OpConstant %27 0
         %29 = OpTypePointer Uniform %6
         %38 = OpConstantTrue %19
         %39 = OpTypePointer Output %10
         %40 = OpVariable %39 Output
         %41 = OpConstant %6 1
         %42 = OpConstantComposite %10 %41 %41 %41 %41
         %44 = OpTypePointer Function %6
         %55 = OpConstant %6 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %45 = OpVariable %44 Function
         %46 = OpVariable %44 Function
         %57 = OpVariable %44 Function
               OpStore %45 %41
               OpStore %46 %41
         %47 = OpFunctionCall %6 %8
         %48 = OpCompositeConstruct %10 %47 %18 %18 %41
               OpStore %40 %48
               OpBranch %49
         %49 = OpLabel
               OpLoopMerge %51 %52 None
               OpBranch %53
         %53 = OpLabel
         %54 = OpLoad %6 %45
         %56 = OpFOrdGreaterThan %19 %54 %55
               OpBranchConditional %56 %50 %51
         %50 = OpLabel
         %58 = OpFunctionCall %6 %8
         %59 = OpFunctionCall %6 %8
         %60 = OpFSub %6 %58 %59
               OpStore %57 %60
         %61 = OpLoad %6 %57
               OpStore %46 %61
         %62 = OpLoad %6 %46
               OpStore %45 %62
               OpBranch %52
         %52 = OpLabel
               OpBranch %49
         %51 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %6 %16
         %20 = OpFOrdGreaterThanEqual %19 %17 %18
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %22
         %21 = OpLabel
         %30 = OpAccessChain %29 %26 %28 %14
         %31 = OpLoad %6 %30
               OpReturnValue %31
         %22 = OpLabel
               OpBranch %33
         %33 = OpLabel
               OpLoopMerge %35 %36 None
               OpBranch %37
         %37 = OpLabel
               OpBranchConditional %38 %34 %35
         %34 = OpLabel
               OpStore %40 %42
               OpBranch %36
         %36 = OpLabel
               OpBranch %33
         %35 = OpLabel
         %43 = OpUndef %6
               OpReturnValue %43
               OpFunctionEnd
