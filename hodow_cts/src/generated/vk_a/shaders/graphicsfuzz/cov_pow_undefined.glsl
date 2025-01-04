#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 52
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %18
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "b"
               OpName %12 "c"
               OpName %18 "_GLF_color"
               OpName %32 "buf0"
               OpMemberName %32 0 "_GLF_uniform_float_values"
               OpName %34 ""
               OpDecorate %18 Location 0
               OpDecorate %31 ArrayStride 16
               OpMemberDecorate %32 0 Offset 0
               OpDecorate %32 Block
               OpDecorate %34 DescriptorSet 0
               OpDecorate %34 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 -1
         %11 = OpConstant %6 1.70000005
         %16 = OpTypeVector %6 4
         %17 = OpTypePointer Output %16
         %18 = OpVariable %17 Output
         %22 = OpTypeBool
         %29 = OpTypeInt 32 0
         %30 = OpConstant %29 2
         %31 = OpTypeArray %6 %30
         %32 = OpTypeStruct %31
         %33 = OpTypePointer Uniform %32
         %34 = OpVariable %33 Uniform
         %35 = OpTypeInt 32 1
         %36 = OpConstant %35 0
         %37 = OpTypePointer Uniform %6
         %40 = OpConstant %35 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
         %12 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %11
         %13 = OpLoad %6 %8
         %14 = OpLoad %6 %10
         %15 = OpExtInst %6 %1 Pow %13 %14
               OpStore %12 %15
         %19 = OpLoad %6 %12
         %20 = OpCompositeConstruct %16 %19 %19 %19 %19
               OpStore %18 %20
         %21 = OpLoad %6 %8
         %23 = OpFOrdEqual %22 %21 %9
         %24 = OpLoad %6 %10
         %25 = OpFOrdEqual %22 %24 %11
         %26 = OpLogicalAnd %22 %23 %25
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %48
         %27 = OpLabel
         %38 = OpAccessChain %37 %34 %36 %36
         %39 = OpLoad %6 %38
         %41 = OpAccessChain %37 %34 %36 %40
         %42 = OpLoad %6 %41
         %43 = OpAccessChain %37 %34 %36 %40
         %44 = OpLoad %6 %43
         %45 = OpAccessChain %37 %34 %36 %36
         %46 = OpLoad %6 %45
         %47 = OpCompositeConstruct %16 %39 %42 %44 %46
               OpStore %18 %47
               OpBranch %28
         %48 = OpLabel
         %49 = OpAccessChain %37 %34 %36 %36
         %50 = OpLoad %6 %49
         %51 = OpCompositeConstruct %16 %50 %50 %50 %50
               OpStore %18 %51
               OpBranch %28
         %28 = OpLabel
               OpReturn
               OpFunctionEnd
