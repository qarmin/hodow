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
               OpEntryPoint Fragment %4 "main" %46
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %20 "v"
               OpName %31 "buf0"
               OpMemberName %31 0 "ref"
               OpName %33 ""
               OpName %46 "_GLF_color"
               OpMemberDecorate %31 0 Offset 0
               OpDecorate %31 Block
               OpDecorate %33 DescriptorSet 0
               OpDecorate %33 Binding 0
               OpDecorate %46 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeVector %6 3
         %10 = OpTypeMatrix %9 3
         %11 = OpConstant %6 1
         %12 = OpConstant %6 0
         %13 = OpConstantComposite %9 %11 %12 %12
         %14 = OpConstantComposite %9 %12 %11 %12
         %15 = OpConstantComposite %9 %12 %12 %11
         %16 = OpConstantComposite %10 %13 %14 %15
         %18 = OpTypeVector %6 4
         %19 = OpTypePointer Function %18
         %31 = OpTypeStruct %18
         %32 = OpTypePointer Uniform %31
         %33 = OpVariable %32 Uniform
         %34 = OpTypeInt 32 1
         %35 = OpConstant %34 0
         %36 = OpTypePointer Uniform %18
         %40 = OpConstant %6 0.100000001
         %41 = OpTypeBool
         %45 = OpTypePointer Output %18
         %46 = OpVariable %45 Output
         %47 = OpConstantComposite %18 %11 %12 %12 %11
         %49 = OpConstantComposite %18 %12 %12 %12 %12
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %19 Function
         %17 = OpExtInst %6 %1 Determinant %16
               OpStore %8 %17
         %21 = OpLoad %6 %8
         %22 = OpExtInst %6 %1 Sin %21
         %23 = OpLoad %6 %8
         %24 = OpExtInst %6 %1 Cos %23
         %25 = OpLoad %6 %8
         %26 = OpExtInst %6 %1 Exp2 %25
         %27 = OpLoad %6 %8
         %28 = OpExtInst %6 %1 Log %27
         %29 = OpCompositeConstruct %18 %22 %24 %26 %28
               OpStore %20 %29
         %30 = OpLoad %18 %20
         %37 = OpAccessChain %36 %33 %35
         %38 = OpLoad %18 %37
         %39 = OpExtInst %6 %1 Distance %30 %38
         %42 = OpFOrdLessThan %41 %39 %40
               OpSelectionMerge %44 None
               OpBranchConditional %42 %43 %48
         %43 = OpLabel
               OpStore %46 %47
               OpBranch %44
         %48 = OpLabel
               OpStore %46 %49
               OpBranch %44
         %44 = OpLabel
               OpReturn
               OpFunctionEnd
