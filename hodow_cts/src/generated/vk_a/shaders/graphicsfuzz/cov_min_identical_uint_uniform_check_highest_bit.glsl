#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 43
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %37
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "a"
               OpName %9 "buf0"
               OpMemberName %9 0 "one"
               OpName %11 ""
               OpName %37 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %37 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpTypePointer Uniform %6
         %17 = OpConstant %6 2147483648
         %19 = OpConstant %6 0
         %20 = OpTypeBool
         %22 = OpConstant %6 1
         %34 = OpTypeFloat 32
         %35 = OpTypeVector %34 4
         %36 = OpTypePointer Output %35
         %37 = OpVariable %36 Output
         %38 = OpConstant %34 1
         %39 = OpConstant %34 0
         %40 = OpConstantComposite %35 %38 %39 %39 %38
         %42 = OpConstantComposite %35 %39 %39 %39 %39
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %6 %15
         %18 = OpBitwiseAnd %6 %16 %17
         %21 = OpINotEqual %20 %18 %19
         %23 = OpSelect %6 %21 %22 %19
         %24 = OpAccessChain %14 %11 %13
         %25 = OpLoad %6 %24
         %26 = OpBitwiseAnd %6 %25 %17
         %27 = OpINotEqual %20 %26 %19
         %28 = OpSelect %6 %27 %22 %19
         %29 = OpExtInst %6 %1 UMin %23 %28
               OpStore %8 %29
         %30 = OpLoad %6 %8
         %31 = OpIEqual %20 %30 %19
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %41
         %32 = OpLabel
               OpStore %37 %40
               OpBranch %33
         %41 = OpLabel
               OpStore %37 %42
               OpBranch %33
         %33 = OpLabel
               OpReturn
               OpFunctionEnd
