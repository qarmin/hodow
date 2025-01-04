#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 38
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %9 "uv"
               OpName %34 "_GLF_color"
               OpDecorate %34 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstantComposite %7 %10 %10
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 1
         %14 = OpTypePointer Function %6
         %17 = OpConstant %12 0
         %19 = OpTypeBool
         %22 = OpConstant %6 0
         %32 = OpTypeVector %6 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
         %35 = OpConstantComposite %32 %10 %22 %22 %10
         %37 = OpConstantComposite %32 %10 %10 %10 %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
               OpStore %9 %11
         %15 = OpAccessChain %14 %9 %13
         %16 = OpExtInst %6 %1 Modf %10 %15
         %18 = OpAccessChain %14 %9 %17
               OpStore %18 %16
         %20 = OpAccessChain %14 %9 %13
         %21 = OpLoad %6 %20
         %23 = OpFOrdGreaterThan %19 %21 %22
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %25
         %24 = OpLabel
         %26 = OpAccessChain %14 %9 %17
         %27 = OpLoad %6 %26
         %28 = OpFOrdLessThan %19 %27 %10
               OpBranch %25
         %25 = OpLabel
         %29 = OpPhi %19 %23 %5 %28 %24
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %36
         %30 = OpLabel
               OpStore %34 %35
               OpBranch %31
         %36 = OpLabel
               OpStore %34 %37
               OpBranch %31
         %31 = OpLabel
               OpReturn
               OpFunctionEnd
