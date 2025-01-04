#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 41
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %36
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "buf0"
               OpMemberName %9 0 "fourtytwo"
               OpName %11 ""
               OpName %36 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %36 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
          %7 = OpTypeFloat 32
          %8 = OpConstant %7 1
          %9 = OpTypeStruct %7
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpTypePointer Uniform %7
         %20 = OpConstant %7 42
         %34 = OpTypeVector %7 4
         %35 = OpTypePointer Output %34
         %36 = OpVariable %35 Output
         %37 = OpConstant %7 0
         %38 = OpConstantComposite %34 %37 %37 %37 %37
         %40 = OpConstantComposite %34 %8 %37 %37 %8
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %7 %15
         %17 = OpAccessChain %14 %11 %13
         %18 = OpLoad %7 %17
         %19 = OpExtInst %7 %1 FClamp %8 %16 %18
         %21 = OpFOrdGreaterThan %6 %19 %20
         %22 = OpLogicalNot %6 %21
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %25 = OpAccessChain %14 %11 %13
         %26 = OpLoad %7 %25
         %27 = OpAccessChain %14 %11 %13
         %28 = OpLoad %7 %27
         %29 = OpExtInst %7 %1 FClamp %8 %26 %28
         %30 = OpFOrdLessThan %6 %29 %20
               OpBranch %24
         %24 = OpLabel
         %31 = OpPhi %6 %21 %5 %30 %23
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %39
         %32 = OpLabel
               OpStore %36 %38
               OpBranch %33
         %39 = OpLabel
               OpStore %36 %40
               OpBranch %33
         %33 = OpLabel
               OpReturn
               OpFunctionEnd
