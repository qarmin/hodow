#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 39
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %35
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %35 "_GLF_color"
               OpDecorate %35 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpConstant %6 3000
          %9 = OpConstant %6 1
         %10 = OpConstant %6 8
         %11 = OpConstant %6 4
         %12 = OpConstantComposite %7 %8 %9 %10 %11
         %13 = OpConstant %6 2
         %14 = OpConstant %6 3
         %15 = OpTypeVector %6 2
         %16 = OpTypeMatrix %15 2
         %17 = OpConstant %6 0
         %18 = OpConstantComposite %15 %13 %17
         %19 = OpConstantComposite %15 %17 %13
         %20 = OpConstantComposite %16 %18 %19
         %22 = OpConstant %6 5
         %24 = OpConstant %6 6
         %25 = OpConstantComposite %7 %24 %24 %24 %24
         %27 = OpConstantComposite %7 %24 %14 %24 %22
         %28 = OpTypeBool
         %29 = OpTypeVector %28 4
         %34 = OpTypePointer Output %7
         %35 = OpVariable %34 Output
         %36 = OpConstantComposite %7 %17 %17 %17 %17
         %38 = OpConstantComposite %7 %9 %17 %17 %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %21 = OpExtInst %6 %1 Determinant %20
         %23 = OpCompositeConstruct %7 %13 %14 %21 %22
         %26 = OpExtInst %7 %1 FClamp %12 %23 %25
         %30 = OpFOrdNotEqual %29 %26 %27
         %31 = OpAny %28 %30
               OpSelectionMerge %33 None
               OpBranchConditional %31 %32 %37
         %32 = OpLabel
               OpStore %35 %36
               OpBranch %33
         %37 = OpLabel
               OpStore %35 %38
               OpBranch %33
         %33 = OpLabel
               OpReturn
               OpFunctionEnd
