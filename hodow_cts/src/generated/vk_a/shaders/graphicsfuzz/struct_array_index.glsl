#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 60
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %54
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %7 "struct_base"
               OpMemberName %7 0 "data"
               OpMemberName %7 1 "leftIndex"
               OpMemberName %7 2 "rightIndex"
               OpName %12 "struct_array"
               OpName %17 "index"
               OpName %29 "buf0"
               OpMemberName %29 0 "injectionSwitch"
               OpName %31 ""
               OpName %54 "_GLF_color"
               OpMemberDecorate %29 0 Offset 0
               OpDecorate %29 Block
               OpDecorate %31 DescriptorSet 0
               OpDecorate %31 Binding 0
               OpDecorate %54 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6 %6 %6
          %8 = OpTypeInt 32 0
          %9 = OpConstant %8 3
         %10 = OpTypeArray %7 %9
         %11 = OpTypePointer Private %10
         %12 = OpVariable %11 Private
         %13 = OpConstant %6 1
         %14 = OpConstantComposite %7 %13 %13 %13
         %15 = OpConstantComposite %10 %14 %14 %14
         %16 = OpTypePointer Function %6
         %18 = OpConstant %6 2
         %19 = OpTypePointer Private %6
         %23 = OpTypeBool
         %27 = OpTypeFloat 32
         %28 = OpTypeVector %27 2
         %29 = OpTypeStruct %28
         %30 = OpTypePointer Uniform %29
         %31 = OpVariable %30 Uniform
         %32 = OpConstant %6 0
         %33 = OpConstant %8 0
         %34 = OpTypePointer Uniform %27
         %41 = OpConstant %8 1
         %52 = OpTypeVector %27 4
         %53 = OpTypePointer Output %52
         %54 = OpVariable %53 Output
         %55 = OpConstant %27 1
         %56 = OpConstant %27 0
         %57 = OpConstantComposite %52 %55 %56 %56 %55
         %59 = OpConstantComposite %52 %55 %55 %55 %55
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %17 = OpVariable %16 Function
               OpStore %12 %15
               OpStore %17 %13
         %20 = OpAccessChain %19 %12 %13 %18
               OpStore %20 %13
         %21 = OpAccessChain %19 %12 %13 %13
         %22 = OpLoad %6 %21
         %24 = OpIEqual %23 %22 %13
               OpSelectionMerge %26 None
               OpBranchConditional %24 %25 %40
         %25 = OpLabel
         %35 = OpAccessChain %34 %31 %32 %33
         %36 = OpLoad %27 %35
         %37 = OpConvertFToS %6 %36
         %38 = OpAccessChain %19 %12 %37 %18
         %39 = OpLoad %6 %38
               OpStore %17 %39
               OpBranch %26
         %40 = OpLabel
         %42 = OpAccessChain %34 %31 %32 %41
         %43 = OpLoad %27 %42
         %44 = OpConvertFToS %6 %43
         %45 = OpAccessChain %19 %12 %44 %13
         %46 = OpLoad %6 %45
               OpStore %17 %46
               OpBranch %26
         %26 = OpLabel
         %47 = OpAccessChain %19 %12 %13 %13
         %48 = OpLoad %6 %47
         %49 = OpIEqual %23 %48 %13
               OpSelectionMerge %51 None
               OpBranchConditional %49 %50 %58
         %50 = OpLabel
               OpStore %54 %57
               OpBranch %51
         %58 = OpLabel
               OpStore %54 %59
               OpBranch %51
         %51 = OpLabel
               OpReturn
               OpFunctionEnd
