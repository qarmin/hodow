#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 60
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %36
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %36 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %36 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 4
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpConstant %15 1
         %18 = OpTypePointer Uniform %6
         %21 = OpConstant %15 3
         %26 = OpTypeBool
         %34 = OpTypeVector %6 4
         %35 = OpTypePointer Output %34
         %36 = OpVariable %35 Output
         %46 = OpConstant %9 0
         %47 = OpTypePointer Output %6
         %52 = OpConstant %15 2
         %57 = OpConstant %6 0
         %58 = OpConstant %6 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %19 = OpAccessChain %18 %14 %16 %17
         %20 = OpLoad %6 %19
               OpStore %8 %20
         %22 = OpAccessChain %18 %14 %16 %21
         %23 = OpLoad %6 %22
         %24 = OpAccessChain %18 %14 %16 %16
         %25 = OpLoad %6 %24
         %27 = OpFOrdGreaterThan %26 %23 %25
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %29
         %28 = OpLabel
         %30 = OpAccessChain %18 %14 %16 %16
         %31 = OpLoad %6 %30
         %32 = OpLoad %6 %8
         %33 = OpFAdd %6 %32 %31
               OpStore %8 %33
         %37 = OpLoad %6 %8
         %38 = OpCompositeConstruct %34 %37 %37 %37 %37
               OpStore %36 %38
         %39 = OpAccessChain %18 %14 %16 %21
         %40 = OpLoad %6 %39
         %41 = OpAccessChain %18 %14 %16 %17
         %42 = OpLoad %6 %41
         %43 = OpFOrdGreaterThan %26 %40 %42
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %45
         %44 = OpLabel
         %48 = OpAccessChain %47 %36 %46
         %49 = OpLoad %6 %48
         %50 = OpLoad %6 %8
         %51 = OpFAdd %6 %50 %49
               OpStore %8 %51
         %53 = OpAccessChain %18 %14 %16 %52
         %54 = OpLoad %6 %53
         %55 = OpCompositeConstruct %34 %54 %54 %54 %54
               OpStore %36 %55
               OpBranch %45
         %45 = OpLabel
               OpBranch %29
         %29 = OpLabel
         %56 = OpLoad %6 %8
         %59 = OpCompositeConstruct %34 %56 %57 %57 %58
               OpStore %36 %59
               OpReturn
               OpFunctionEnd
